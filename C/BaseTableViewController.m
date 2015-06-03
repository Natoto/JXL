//
//  BaseTableViewController.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "CELL_STRUCT.h"
#import "BaseTableViewController.h"
#import "MJRefresh.h"
#import "HBSignalBus.h"
#import "NSObject+HBHUD.h"
#import "UIImage+Tint.h"
@interface BaseTableViewController()

@end;

@implementation BaseTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {//这个是需要的
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //    self.dataDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (!self.noAutoConfigTableView) {
        [self configTableView];
    }
}

ON_HBSIGNAL(HTTPSEngine, networkerror, notify)
{
    NSString * errormsg = notify.object;
    [self dismissAllTips];
    [self presentMessageTips_:errormsg];
    [self FinishedLoadData];
}
//注册
-(void)configTableView
{
    if ([self tableView]) {
        [self setExtraCellLineHidden:self.tableView];
//        [self setupRefresh];
        //注册CELL 目前只考虑到两种情况 2个 section不同的时候 注册 其他的自己添加
        CELL_STRUCT * cell0struct= [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
        if ([cell0struct.subvalue1 isEqualToString:@"xib"]) {
            TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, cell0struct.cellclass)
        }
        CELL_STRUCT * cellstruct1 = [self.dataDictionary objectForKey:KEY_INDEXPATH(1, 0)];
        if (cellstruct1) {
            if ([cellstruct1.subvalue1 isEqualToString:@"xib"]) {
                TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, cellstruct1.cellclass)
            }
        }
    }
}

/**
 * 使用默认配置 供子类调用
 */
-(void)TableViewDefaultConfigWithTitle:(NSString *)title
{
    [self userDefaultBackground];
    [self.navigationbar setTitle:title];
    [self showhbnavigationbarBackItem:YES];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
}

/**
 * 使用默认配置 供子类调用
 */
-(void)userDefaultConfigWithTitle:(NSString *)title
{
    [self TableViewDefaultConfigWithTitle:title];
}

/**
 * 使用灰色顶部 灰色返回按钮
 */
-(void)usegrayNavigationbarConfigWithTitle:(NSString *)title
{
//    [self TableViewDefaultConfigWithTitle:title];
    [self userDefaultBackground];
    [self.navigationbar setTitle:title];
    [self showhbnavigationbarBackItem:YES];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    
    self.navigationbar.TintColor = [UIColor blackColor];
    self.navigationbar.backgroundColor = JXL_COLOR_THEME;
    UIImage * graybackimg = [UIImage imageNamed:@"white_back_btn"];
    graybackimg = [graybackimg imageWithTintColor:[UIColor grayColor]];
    [self.navigationbar setleftBarButtonItemWithImage:graybackimg target:self selector:@selector(backtoparent:)];
    
}
-(void)observeTapgesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTap:)];
    [self.tableView addGestureRecognizer:tap];
}

-(void)tableViewTap:(UIGestureRecognizer *)gesture
{
     [[NSNotificationCenter defaultCenter] postNotificationName:notify_basetableview_tap object:gesture];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = JXL_COLOR_THEME; //[UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(void)viewDidCurrentView
{
    
}
- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的refreshView)
    self.noHeaderFreshView = YES;
    [self.tableView headerBeginRefreshing];
    self.noFooterView = YES;
}

-(void)setNoHeaderFreshView:(BOOL)noHeaderFreshView
{
    _noHeaderFreshView = noHeaderFreshView;
    if (noHeaderFreshView) {
        [self.tableView removeHeader];
    }
    else
    {
        [self.tableView addHeaderWithTarget:self action:@selector(refreshView)];
    }
}

-(void)setNoFooterView:(BOOL)noFooterView
{
    _noFooterView = noFooterView;
    if (noFooterView) {
        [self.tableView removeFooter];
    }
    else
    {
        [self.tableView addFooterWithTarget:self action:@selector(getNextPageView)];
    }
}


-(void)refreshView
{
}
-(void)removeFooterView{
}

-(void)setFooterView{
}

//调用上下拉需要的

//加载调用的方法
-(void)getNextPageView
{
    
}

-(void)startHeaderLoading
{
    [self.tableView headerBeginRefreshing];
}
-(void)FinishedLoadData
{
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

-(void)noMore
{
    [self.tableView removeFooter];
}

-(void)finishReloadingData
{
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 响应cell选择
-(void)cellDidSelect:(id)sender
{
    NSLog(@"%@",sender);
 
}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        
        CELL_STRUCT * cell0_0;
        CELL_STRUCT * cell0_1;
        CELL_STRUCT * cell0_2;
        CELL_STRUCT * cell0_3;
        
        cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@" " cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:nil delegate:self];
        cell0_0.cellheight = 80;
        
        cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@" " cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:nil delegate:self];
//        cell0_1.selectionStyle = NO;//不可点击
        cell0_1.cellheight = 80;
        
        cell0_2 = [[CELL_STRUCT alloc] initWithtitle:@" " cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:nil delegate:self];
//        cell0_2.selectionStyle = NO;
        cell0_2.cellheight = 80;
        
        cell0_3 = [[CELL_STRUCT alloc] initWithtitle:@"  " cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:nil delegate:self];
        cell0_3.titlecolor = @"gray";
        cell0_3.cellheight = 80;
        
        NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell0_1,KEY_INDEXPATH(0, 1),cell0_2,KEY_INDEXPATH(0, 2),cell0_3,KEY_INDEXPATH(0, 3),nil];
        
        _dataDictionary = array0; //[[NSMutableDictionary alloc] initWithObjectsAndKeys:array0,KEY_SECTION(0), nil];
    }
    return _dataDictionary;
}


-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.tableView.frame = CGRectMake(0, top, UISCREEN_WIDTH ,UISCREEN_HEIGHT - top - bottom);
    return self.tableView.frame;
}
#pragma mark - Table view data source

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
//    return cell_struce.sectiontitle;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionheight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionfooterheight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.sectiontitle.length) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cell_struce.sectionheight)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width - 20, cell_struce.sectionheight)];
        label.center = CGPointMake(view.centerX, view.centerY);
        label.text = cell_struce.sectiontitle;
        label.textAlignment = NSTextAlignmentLeft;
        view.backgroundColor = self.tableView.backgroundColor;
        [view addSubview:label];
        return view;
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.sectionfooter.length) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cell_struce.sectionfooterheight)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width - 20, cell_struce.sectionfooterheight)];
        label.center = CGPointMake(view.centerX, view.centerY);
        label.text = cell_struce.sectionfooter;
        label.textAlignment = NSTextAlignmentLeft;
        view.backgroundColor = self.tableView.backgroundColor;
        [view addSubview:label];
        return view;
    }
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSInteger maxsection = 1;
    for (int index = 0; index < keys.count; index ++) {
         NSString * key =[keys objectAtIndex:index];
        
        NSString * sectionstr = KEY_SECTION_INDEX_STR(key); //[key substringWithRange:NSMakeRange(7, 1)];
        if ((sectionstr.integerValue +1) > maxsection) {
            maxsection = (sectionstr.integerValue + 1);
        }
     }
    return maxsection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSString * sectionx = KEY_SECTION_MARK(section);
    
    //[NSString stringWithFormat:@"section%ld_",(long)section];
    NSInteger sectioncount = 0;
    for (int index = 0; index < keys.count; index ++) {
        NSString * key =[keys objectAtIndex:index];
        if ([key rangeOfString:sectionx].location != NSNotFound) {
            sectioncount ++;
        }
    }
    return sectioncount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSString * identifier01 = cellstruct.cellclass;
    BaseTableViewCell *cell ;
    if(cellstruct.subvalue1 && [cellstruct.subvalue1 isEqualToString:@"xib"])
    {
//        [tableView registerClass:NSClassFromString(cellstruct.cellclass) forCellReuseIdentifier:identifier01];
        cell =  [tableView dequeueReusableCellWithIdentifier:identifier01 forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier01];
    }
    
    if (!cell) {
        NSString * Classname = [NSString stringWithFormat:@"%@",cellstruct.cellclass];
        Class cls = NSClassFromString(Classname);
        if(cellstruct.subvalue1 && [cellstruct.subvalue1 isEqualToString:@"xib"])
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellstruct.cellclass owner:self options:nil] lastObject];
        }
        else
        {
            cell = [[cls alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier01];
        }
    }
    if ([[cell class] isSubclassOfClass:[BaseTableViewCell class]]) {
        cell.cellstruct = cellstruct;
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.selector = cellstruct.sel_selector;
        cell.selectionStyle = cellstruct.selectionStyle?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
        cell.accessoryType = cellstruct.accessory?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        [cell setcellimageRight:cellstruct.imageRight];
        [cell setcelldetailtitle:cellstruct.detailtitle];
        [cell setcellplaceholder:cellstruct.placeHolder];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellTitle:cellstruct.title];
        [cell setcellValue2:cellstruct.subvalue2];
        [cell setcellProfile:cellstruct.picture];
        [cell setcellpicturecolor:cellstruct.picturecolor];
        [cell setcellValue:cellstruct.value];
        [cell setcellobject:cellstruct.object];
        [cell setcellTitleColor:cellstruct.titlecolor];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellimageCornerRadius:cellstruct.imageCornerRadius];
    }
    return cell;
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.nodeselectRow) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    CELL_STRUCT * cellstruct = [self.dataDictionary  objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    if ( cellstruct.sel_selector && [self respondsToSelector:cellstruct.sel_selector])
    {
        [self performSelector:cellstruct.sel_selector withObject:cellstruct afterDelay:0];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL_STRUCT * cellstruct = [self.dataDictionary  objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    return cellstruct.cellheight;
}

@end
