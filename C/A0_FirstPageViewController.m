//
//  A0_FirstPageViewController.m
//  JXL
//
//  Created by 跑酷 on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A0_FirstPageViewController.h"
#import "jxl.h"
#import "A0_FirstPage_RecomendCell.h"
#import "A0_FirstPageADCell.h"
#import "A0_FirstPageSquareCell.h"
#import "HomeIndexModel.h"
#import "RootViewController.h"
#import "A0_HotNewsCell.h"
#import "A0_HotProjectCell.h"
#import "B1_ANewsViewController.h"
#import "D1_PersonDynamicViewController.h"
#import "C1_ProjectViewController.h"
#import "A1_ActivityViewController.h"
#import "SearchViewController.h"
@interface A0_FirstPageViewController ()<A0_FirstPageADCellDelegate,A0_FirstPage_RecomendCellDelegate,A0_FirstPageSquareCellDelegate,UISearchBarDelegate>
@property(nonatomic,strong) NSMutableArray      * advertiseList;
AS_ARRAY(advertiseList)
AS_CELL_STRUCT_JXLCOMMON(lunbo)
AS_CELL_STRUCT_JXLCOMMON(tuijian)
AS_CELL_STRUCT_JXLCOMMON(square)
@end

@implementation A0_FirstPageViewController
@synthesize dataDictionary = _dataDictionary;
GET_A0_FIRSTPAGE_CELL(lunbo, @"A0_FirstPageADCell", [A0_FirstPageADCell heightOfCell])
GET_A0_FIRSTPAGE_CELL(tuijian, @"A0_FirstPage_RecomendCell", [A0_FirstPage_RecomendCell heightOfCell])
//GET_A0_FIRSTPAGE_CELL(square, @"A0_FirstPageSquareCell", [A0_FirstPageSquareCell heightofcell])

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationbar];
    
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_FirstPage_RecomendCell")
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_FirstPageADCell")
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_FirstPageSquareCell")
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_HotNewsCell")
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_HotProjectCell")
    
    [self initData];
    self.noHeaderFreshView = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self refreshView];
}

-(void)initNavigationbar
{
    self.navigationbar.backgroundColor = JXL_COLOR_THEME_NAVIGATIONBAR;
    [self.navigationbar setTitle:@"金项恋"];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
    
    UIImage  *menuimg = [UIImage imageNamed:@"user_icon"];
    menuimg = [menuimg imageWithTintColor:[UIColor whiteColor]];
    [self.navigationbar setrightBarButtonItemWithImage:menuimg target:self selector:@selector(showRightViewController)];
    [self.navigationbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"main_top_icon"] target:nil selector:nil];
    self.navigationbar.leftItem.userInteractionEnabled = NO;
    self.navigationbar.leftItem.left = 15;
    
    UISearchBar * searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 5, 250, 30)];
    searchbar.placeholder = @"查看热门项目";
    searchbar.delegate = self;
    [searchbar setBackgroundImage:[UIImage new]];
    self.navigationbar.titleView = searchbar;
    self.navigationbar.titleView.center = CGPointMake(self.navigationbar.width/2  , self.navigationbar.height/2 + 10);
}

-(void)initData
{
    self.cell_struct_tuijian.subvalue1 = @"xib";
    self.cell_struct_lunbo.sectionfooterheight = 10;
    self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:@{KEY_INDEXPATH(0, 0):self.cell_struct_lunbo,KEY_INDEXPATH(0, 1):self.cell_struct_tuijian}];
}

#pragma mark searchbar delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"搜索按钮点击");
    SearchViewController * ctr  = [[SearchViewController alloc] init];
    [[RootViewController sharedInstance] rootpushviewcontroller:ctr animated:YES];
    
    return NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
}

-(void)A0_FirstPageADCell:(A0_FirstPageADCell *)A0_FirstPageADCell AdScrollView:(AdScrollView *)AdScrollView selectIndex:(NSInteger)index
{
    NSArray * advertiseList = self.m_advertiseList;
    if (advertiseList && advertiseList.count) {
        AdvertiseList * advertist = [advertiseList objectAtIndex:index];
        NSLog(@"%@",advertist);
        [[RootViewController sharedInstance] openURL:advertist.m_url];
    }
}

-(void)refreshView
{
    [self FinishedLoadData];
    [[HTTPSEngine sharedInstance] fetch_advertiseListWithType:@"4" catid:nil response:^(NSDictionary *Dictionary) {
        if (Dictionary) {
            NSLog(@"首页广告：%@",Dictionary);
            NSArray * array = [AdvertiseListModel encodeDiction:Dictionary];
            if (array.count) {
                self.advertiseList = [NSMutableArray arrayWithArray:array];
                self.m_advertiseList = self.advertiseList;
                [self loadTopNews:self.advertiseList];
                [self.tableView reloadData];
            }
        }
    } errorHandler:^(NSError *error) {
        
    }];
    
    
    [[HTTPSEngine sharedInstance] fetch_homeIndex:^(NSDictionary *Dictionary) {
        
        if ([Dictionary isErrorObject]) {
        }
        else
        {
            [[HomeIndexModel sharedInstance] encodeDictionary:Dictionary];
            [self loadFirstNewsInvestor];
            [self loadProjectRecommand];
            [self loadGoodVC];
            [self loadhotnews];
            [self loadhotproject];
            [self.tableView reloadData];
            
        }
        NSLog(@"%@",Dictionary);
        
    } errorHandler:^(NSError *error) {
        
    }];
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.sectiontitle.length) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cell_struce.sectionheight)];
        UILabel * lblmark = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 2, 15)];
        lblmark.backgroundColor = JXL_COLOR_THEME_NAVIGATIONBAR;
        lblmark.centerY = view.height/2;
        [view addSubview:lblmark];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, view.width - 40, cell_struce.sectionheight)];
//        label.center = CGPointMake(view.centerX + 20, view.centerY);
        label.x = lblmark.right + 5;
        label.centerY = view.centerY;
        label.text = cell_struce.sectiontitle;
        label.textAlignment = NSTextAlignmentLeft;
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
        return view;
    }
    return [UIView new];
}

#pragma mark 优秀投资人推荐

-(void)loadGoodVC
{
    NSArray * array = [HomeIndexModel sharedInstance].m_homeindex.m_recommInvestor;
    NSInteger sectioncount = [self section_of_goodvc];
    CELL_STRUCT *  cellstruct = [self create_cell_struct_goodvc:array];
    cellstruct.sectionheight = 40;
    cellstruct.sectiontitle = @"优秀投资人推荐";
    cellstruct.key_indexpath = KEY_INDEXPATH(sectioncount, 0);
    [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(sectioncount, 0)];
   
}

#pragma mark 热点新闻

-(void)loadhotnews
{
    NSArray * ahotnews = [HomeIndexModel sharedInstance].m_homeindex.m_hotNews;
    NSInteger sectioncount = [self section_of_hotnews];
    [ahotnews enumerateObjectsUsingBlock:^(HotNews * obj, NSUInteger idx, BOOL *stop) {
         CELL_STRUCT *  cellstruct = [self create_cell_struct_hotnews:obj];
        cellstruct.sectionheight = 40;
        cellstruct.sectiontitle = @"热门新闻";
        cellstruct.key_indexpath = KEY_INDEXPATH(sectioncount, idx);
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(sectioncount, idx)];
    }];
}

-(BOOL)ishotnewsection:(NSString *)key_indexpath
{
    NSString  * sectionstr = KEY_INDEXPATH_SECTION_STR(key_indexpath);
    NSInteger sectioncount = [self section_of_hotnews];
    // [HomeIndexModel sharedInstance].m_homeindex.m_recommProject.count;
    if (sectioncount == sectionstr.integerValue) {
        return YES;
    }
    return NO;
}
-(HotNews *)gethotnews:(NSString *)key_indexpath
{
    NSString  * rowstr = KEY_INDEXPATH_ROW_STR(key_indexpath);
    if ([self ishotnewsection:key_indexpath]) {
         NSArray * ahotnews = [HomeIndexModel sharedInstance].m_homeindex.m_hotNews;
        return [ahotnews objectAtIndex:rowstr.integerValue];
    }
    return nil;
}

#pragma mark 热门项目


-(void)loadhotproject
{
    NSArray * ahotnews = [HomeIndexModel sharedInstance].m_homeindex.m_hotProject;
    NSInteger sectioncount = [self section_of_hotproject];
    [ahotnews enumerateObjectsUsingBlock:^(HotProject * obj, NSUInteger idx, BOOL *stop) {
        CELL_STRUCT *  cellstruct = [self create_cell_struct_hotproject:obj];
        cellstruct.sectionheight = 40;
        cellstruct.sectiontitle = @"热门项目";
        cellstruct.key_indexpath = KEY_INDEXPATH(sectioncount, idx);
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(sectioncount, idx)];
    }];
    [self.tableView reloadData];
}

-(BOOL)isrecommentprojectsection:(NSString *)key_indexpath
{
    NSString  * sectionstr = KEY_INDEXPATH_SECTION_STR(key_indexpath);
    if (sectionstr.integerValue >=1 && sectionstr.integerValue < [self section_of_goodvc]) {
        return YES;
    }
    return NO;
}

-(BOOL)ishotprojectsection:(NSString *)key_indexpath
{
    NSString  * sectionstr = KEY_INDEXPATH_SECTION_STR(key_indexpath);
    NSInteger sectioncount = [self section_of_hotproject]; //[HomeIndexModel sharedInstance].m_homeindex.m_recommProject.count + 1;
    if (sectioncount == sectionstr.integerValue) {
        return YES;
    }
    return NO;
}

-(BOOL)isgoodvcsection:(NSString *)key_indexpath
{
    NSString  * sectionstr = KEY_INDEXPATH_SECTION_STR(key_indexpath);
    NSInteger sectioncount = [self section_of_goodvc];
    if (sectioncount == sectionstr.integerValue) {
        return YES;
    }
    return NO;
}

-(RecommInvestor *)getagoodvc:(NSInteger)key_tag
{
//    NSString  * rowstr = KEY_INDEXPATH_ROW_STR(key_indexpath);
//    if ([self isgoodvcsection:key_indexpath]) {
        NSArray * ahotnews = [HomeIndexModel sharedInstance].m_homeindex.m_recommInvestor;
    if (ahotnews) {
        return [ahotnews objectAtIndex:key_tag];
    }    
//    }
    return nil;
}


-(HotProject *)getHotProject:(NSString *)key_indexpath
{
    NSString  * rowstr = KEY_INDEXPATH_ROW_STR(key_indexpath);
    if ([self ishotprojectsection:key_indexpath]) {
        NSArray * ahotnews = [HomeIndexModel sharedInstance].m_homeindex.m_hotProject;
        return [ahotnews objectAtIndex:rowstr.integerValue];
    }
    return nil;
}

-(NSInteger)section_of_hotproject
{
    return [self section_of_hotnews] + 1;
}
-(NSInteger)section_of_hotnews
{
    return [self section_of_goodvc] + 1;
}
-(NSInteger)section_of_goodvc
{
    return [HomeIndexModel sharedInstance].m_homeindex.m_recommProject.count;
}

#pragma mark 项目推荐

-(void)loadProjectRecommand
{
    NSArray * recommentproject = [HomeIndexModel sharedInstance].m_homeindex.m_recommProject;
    
    [recommentproject enumerateObjectsUsingBlock:^(RecommProject * obj, NSUInteger idx1, BOOL *stop) {
        if ([[obj class] isSubclassOfClass:[RecommProject class]]) {
            CELL_STRUCT * projectcellstruct = [self create_cell_struct_square:obj];
            projectcellstruct.key_indexpath = KEY_INDEXPATH(idx1 + 1, 0);
            [self.dataDictionary setObject:projectcellstruct forKey:KEY_INDEXPATH(idx1 + 1, 0)];
        }
    }];
}

#pragma mark 加载置顶投资人
-(void)loadFirstNewsInvestor
{
    NSDictionary * celldictionary
    = @{key_firstpage_recomendcell_article:[HomeIndexModel sharedInstance].m_homeindex.m_firstNews,
        key_firstpage_recomendcell_Investor:[HomeIndexModel sharedInstance].m_homeindex.m_firstInvestor,
        key_cellstruct_background:[UIColor clearColor]};
    
    self.cell_struct_tuijian.dictionary = [NSMutableDictionary dictionaryWithDictionary:celldictionary];
    
    [self.dataDictionary setObject:self.cell_struct_tuijian forKey:KEY_INDEXPATH(0, 1)];
}

#pragma mark  加载顶部新闻
-(void)loadTopNews:(NSArray *)advertiseList
{
    NSMutableArray * headerimageNameArray = [NSMutableArray arrayWithCapacity:0];// @[@"root_page_1"];
    NSMutableArray * headerTitleNameArray = [NSMutableArray arrayWithCapacity:0];//@[@"首页"];
    if (advertiseList.count) {
        [advertiseList enumerateObjectsUsingBlock:^(AdvertiseList * obj, NSUInteger idx, BOOL *stop) {
            [headerimageNameArray addObject:obj.m_thumb];
            [headerTitleNameArray addObject:obj.m_title];
        }];
    }
    NSMutableDictionary * dictionary =[NSMutableDictionary dictionaryWithObjectsAndKeys:headerimageNameArray,@"headerimageNameArray",headerTitleNameArray,@"headerTitleNameArray",  nil];
    self.cell_struct_lunbo.dictionary = dictionary;
    [self.dataDictionary setObject:self.cell_struct_lunbo forKey:KEY_INDEXPATH(0, 0)];
}

-(void)showRightViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPageViewController:left:navigationItem:)]) {
        [self.delegate A0_FirstPageViewController:self left:NO navigationItem:nil];
    }
    NSLog(@"%s",__func__);
}


-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    if ([self ishotnewsection:cellstruct.key_indexpath]) {
        HotNews *hotnew = [self gethotnews:cellstruct.key_indexpath];
        B1_ANewsViewController * ctr = [[B1_ANewsViewController alloc] initWithNewsId:hotnew.m__id mid:[GlobalData sharedInstance].m_mid];
        ctr.m_newcomment = @"0";
        [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];
        
    }
    else if([self ishotprojectsection:cellstruct.key_indexpath])
    {
        HotProject * project = [self getHotProject:cellstruct.key_indexpath];
        C1_ProjectViewController * ctr = [[C1_ProjectViewController alloc] init];
        ctr.m_projectid = project.m__id;
        [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];
    }
    
}
#pragma mark A0_FirstPageSquareCell delegate

-(void)A0_FirstPageSquareCell:(A0_FirstPageSquareCell *)A0_FirstPageSquareCell SqureImageTitleView:(SqureImageTitleView *)SqureImageTitleView SelectIndex:(NSInteger)index
{
    CELL_STRUCT * cellstruct = A0_FirstPageSquareCell.cellstruct;
    if([self isrecommentprojectsection:cellstruct.key_indexpath])
    {
        NSString * sectionstr = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
        RecommProject * RCP  = [[HomeIndexModel sharedInstance].m_homeindex.m_recommProject objectAtIndex:(sectionstr.integerValue  -1)]; //[self getHotProject:cellstruct.key_indexpath];
        RecommProjectContent * project = [RCP.m_content objectAtIndex:index];
        C1_ProjectViewController * ctr = [[C1_ProjectViewController alloc] init];
        ctr.m_projectid = project.m__id;
        [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];
    }
    else if([self isgoodvcsection:cellstruct.key_indexpath])
    {
        RecommInvestor *avc = [self getagoodvc:index];
        D1_PersonDynamicViewController * ctr = [[D1_PersonDynamicViewController alloc] init];
        ctr.m_mid = avc.m__id;
        [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];
    }
}

#pragma mark - A0_FirstPage_RecomendCell delegate
//活动中心
-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell ActiveCenter:(id)sender
{
    A1_ActivityViewController * ctr = [[A1_ActivityViewController alloc] init];
    
    [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];
}
//发现项目
-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell FindProject:(id)sender
{
    [[RootViewController sharedInstance].tabViewSocial selectTabItemWithIndex:2];
    [[RootViewController sharedInstance] TabSelectAtIndex:2];
}
//推荐文章
-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell RecomandAreticleTap:(id)RecomandAreticleSender
{
    FirstNews *hotnew = [HomeIndexModel sharedInstance].m_homeindex.m_firstNews;
    if (!hotnew) {
        return;
    }
    B1_ANewsViewController * ctr = [[B1_ANewsViewController alloc] initWithNewsId:hotnew.m__id mid:[GlobalData sharedInstance].m_mid];
    ctr.m_newcomment = @"0";
    ctr.title = hotnew.m_title;
    ctr.image = hotnew.m_img;
    [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];
    
}
//推荐投资人
-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell RecomandVCTap:(id)RecomandVCSender
{
    D1_PersonDynamicViewController * ctr = [[D1_PersonDynamicViewController alloc] init];
    FirstInvestor * first= [HomeIndexModel sharedInstance].m_homeindex.m_firstInvestor;
    ctr.m_mid = first.m__id;
    [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.statusBarStyleDefault = NO;
}

-(CELL_STRUCT *)create_cell_struct_tuijian
{
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"A0_FirstPage_RecomendCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell1_0.cellheight = [A0_FirstPage_RecomendCell heightOfCell];
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
    
    return cell1_0;
}

-(CELL_STRUCT *)create_cell_struct_square:(RecommProject *)obj
{
    
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"A0_FirstPageSquareCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell1_0.cellheight = [A0_FirstPageSquareCell heightofcell];
    cell1_0.subvalue1 = @"xib";
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
    
    cell1_0.sectiontitle = obj.m_titleName;
    cell1_0.sectionheight = 40;
    NSMutableArray * project_names = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * project_imges = [NSMutableArray arrayWithCapacity:0];
    if (obj.m_content.count) {
        [obj.m_content enumerateObjectsUsingBlock:^(RecommProjectContent * acontent , NSUInteger idx2, BOOL *stop) {
            [project_names addObject:acontent.m_title];
            if (acontent.m_img && ([acontent.m_img rangeOfString:@"null"].location ==NSNotFound)) {
                [project_imges addObject:acontent.m_img];
            }
            else
            {
                [project_imges addObject:@"http://f.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=16e6a35e9345d688b70fbaf6c5ab167b/279759ee3d6d55fb67e01c4b6c224f4a20a4ddbd.jpg"];
            }
        }];
        cell1_0.dictionary = [NSMutableDictionary dictionaryWithDictionary:
                                        @{key_firstpage_squarecell_names:project_names,
                                          key_firstpage_squarecell_images:project_imges,
                                          key_cellstruct_background:[UIColor clearColor]}];
    }
    cell1_0.cellheight = ceil(obj.m_content.count/2.) * (SCREEN_WIDTH/2.);
    return cell1_0;
}


-(CELL_STRUCT *)create_cell_struct_hotnews:(HotNews *)anews
{
    
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:anews.m_title cellclass:@"A0_HotNewsCell" placeholder:anews.m_desc accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell1_0.cellheight = 80;
    if (!anews.m_img || [anews.m_img rangeOfString:@"null"].location != NSNotFound) {
        anews.m_img = @"http://f.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=16e6a35e9345d688b70fbaf6c5ab167b/279759ee3d6d55fb67e01c4b6c224f4a20a4ddbd.jpg";
    }
    cell1_0.picture = anews.m_img;
    cell1_0.detailtitle = anews.m_desc;
    cell1_0.subvalue1 = @"xib";
    cell1_0.sectionfooterheight = 10;
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
    
    return cell1_0;
}

-(CELL_STRUCT *)create_cell_struct_hotproject:(HotProject *)anews
{
    
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:anews.m_title cellclass:@"A0_HotProjectCell" placeholder:anews.m_demand accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    if (!anews.m_img || [anews.m_img rangeOfString:@"null"].location != NSNotFound) {
        anews.m_img = @"http://f.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=16e6a35e9345d688b70fbaf6c5ab167b/279759ee3d6d55fb67e01c4b6c224f4a20a4ddbd.jpg";
    }
    cell1_0.picture = anews.m_img;
    cell1_0.detailtitle = anews.m_demand;
    cell1_0.subvalue1 = @"xib";
    cell1_0.sectionfooterheight = 10;
    cell1_0.cellheight = 110;
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],
                                                                         key_a0_hotprojectcell_state:anews.m_type, key_a0_hotprojectcell_location:anews.m_school,key_a0_hotprojectcell_state:anews.m_demand   }];
    
    return cell1_0;
}


-(CELL_STRUCT *)create_cell_struct_goodvc:(NSArray *)array
{ 
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"A0_FirstPageSquareCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell1_0.cellheight = [A0_FirstPageSquareCell heightofcell];
    cell1_0.subvalue1 = @"xib";
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
    
    cell1_0.sectiontitle = @"优秀投资人推荐";
    cell1_0.sectionheight = 40;
    NSMutableArray * project_names = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * project_imges = [NSMutableArray arrayWithCapacity:0];
    
    [array enumerateObjectsUsingBlock:^(RecommInvestor * acontent , NSUInteger idx2, BOOL *stop) {
        [project_names addObject:acontent.m_title];
        if (acontent.m_img && ([acontent.m_img rangeOfString:@"null"].location ==NSNotFound)) {
            [project_imges addObject:acontent.m_img];
        }
        else
        {
            [project_imges addObject:@"http://f.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=16e6a35e9345d688b70fbaf6c5ab167b/279759ee3d6d55fb67e01c4b6c224f4a20a4ddbd.jpg"];
        }
    }];
    cell1_0.dictionary = [NSMutableDictionary dictionaryWithDictionary:
                              @{key_firstpage_squarecell_names:project_names,
                                key_firstpage_squarecell_images:project_imges,
                                key_cellstruct_background:[UIColor clearColor]}];
    
    cell1_0.cellheight = (project_names.count/2) * (SCREEN_WIDTH/2);
    return cell1_0;
}

@end
