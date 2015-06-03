//
//  SearchViewController.m
//  JXL
//
//  Created by 跑酷 on 15/5/21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "jxl.h"
#import "SearchViewController.h"
#import "NSDictionary_JSONExtensions.h"
#import "NewsTableViewCell.h"
#import "C1_ProjectViewController.h"
#import "RootViewController.h"
#import "FilterSearchBoard.h"
#import "D4_CollegeSelectorController.h"
#import "FilterNeedTypeViewController.h"
#import "FilterProjectTypeListController.h"
@interface SearchViewController ()<UISearchBarDelegate,D4_CollegeSelectorControllerDelegate ,FilterNeedTypeViewControllerDelegate,FilterProjectTypeListControllerDelegate>
@property(nonatomic,retain) UISearchBar     * searchBar;
@property(nonatomic,retain) NSMutableArray  * historylist;
@property(nonatomic,retain) UIView          * footerView;
@property(nonatomic,retain) FilterSearchBoard * filterboard;
@property(nonatomic,assign) UIButton        * selectbutton;
@property(nonatomic,retain) NSString        * schoolId;
@property(nonatomic,retain) NSString        * collegeName;
@property(nonatomic,retain) NSString        * needtype;
@property(nonatomic,retain) NSString        * needmoney;
@property(nonatomic,retain) NSString        * keywords;
@property(nonatomic,retain) NSString        * ProjectTypeid;
@end

@implementation SearchViewController
#define KEY_HISTORY_SEARCH @"historysearch"
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationbar];
//    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"NewsTableViewCell")
   
    self.dataDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    
     if (self.historylist) {
        [self loadHistorySearch:self.historylist];
    }
    
}

-(void)initNavigationbar
{
    [self userDefaultConfigWithTitle:@""];
    self.navigationbar.leftItem.hidden = YES;
    self.navigationbar.backgroundColor = JXL_COLOR_THEME;
    UISearchBar * searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 5, 280, 30)];
    searchbar.placeholder = @"查看热门项目";
    searchbar.delegate = self;
    [searchbar setBackgroundImage:[UIImage new]];
    self.navigationbar.titleView = searchbar;
    self.navigationbar.titleView.width = 260;
    self.navigationbar.titleView.center = CGPointMake(self.navigationbar.width/2, self.navigationbar.height/2 + 10);
    self.navigationbar.titleView.left = 10;
    self.searchBar = searchbar;
    
    UIButton * rightbutton = [ToolsFunc CreateButtonWithFrame:CGRectMake(self.view.width - 50, 20 + 10 , 40, 40) andTxt:@"取消"];
    [rightbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(cancelinput:) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.center = CGPointMake(self.navigationbar.width - 30, self.navigationbar.height/2 + 10);
    self.navigationbar.rightItem = rightbutton;
//    [self.navigationbar setrightBarButtonItemWithTitle:@"取消" target:self selector:@selector(cancelinput:)];
//    self.navigationbar.rightItem.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.statusBarStyleDefault = YES;
    [self.searchBar becomeFirstResponder];
}
-(void)cancelinput:(id)sender
{
    [self.searchBar  resignFirstResponder];
//    self.searchBar.text = @"";
    [self backtoparent:nil];
}


-(IBAction)filterSelect:(id)sender
{
    self.selectbutton = (UIButton *)sender;
    //选择学校
    if (self.selectbutton == self.filterboard.btn_school) {
      
        if (self.selectbutton.selected == NO) {
            D4_CollegeSelectorController * ctr = [[D4_CollegeSelectorController alloc] init];
            ctr.selectordelegate = self;
            [self presentViewController:ctr animated:YES completion:nil];
            self.selectbutton.selected = YES;
        }
        else
        {
            self.selectbutton.selected = NO;
//            [self presentMessageTips_:[NSString stringWithFormat:@"取消条件%@",self.collegeName]];
            self.schoolId = nil;
            [self startSearch:self.keywords];
        }
    }
    //选择行业
    else if (self.selectbutton == self.filterboard.btn_hangye) {
        if (self.selectbutton.selected == NO) {
            self.selectbutton.selected = YES;
            FilterProjectTypeListController * ctr = [[FilterProjectTypeListController alloc] init];
            ctr.delegate = self;
            [self presentViewController:ctr animated:YES completion:nil];
        }
        else
        {
            self.selectbutton.selected = NO;
             self.ProjectTypeid = nil;
            [self startSearch:self.keywords];
        }
       
        
    }
    //选择需求类别
    else if (self.selectbutton == self.filterboard.btn_needtype) {
        if (self.selectbutton.selected == NO) {
              self.selectbutton.selected = YES;
            FilterNeedTypeViewController * ctr = [[FilterNeedTypeViewController alloc] init];
            ctr.delegate = self;
            [self presentViewController:ctr animated:YES completion:nil];
        }
        else
        {
            self.selectbutton.selected = NO;
//            [self presentMessageTips_:[NSString stringWithFormat:@"取消条件%@",self.needtype]];
            self.needtype = nil;
            [self startSearch:self.keywords];
        }
    }
    
}

-(NSMutableArray *)historylist
{
    if (!_historylist) {
        NSArray * array = GET_OBJECT_OF_USERDEFAULT(KEY_HISTORY_SEARCH)
        if (array) {
            _historylist = [[NSMutableArray alloc] initWithArray:array];
        }
        else
        {
            _historylist = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return _historylist;
}

#pragma mark FilterProjectTypeListController delegate

-(void)FilterProjectTypeListController:(FilterProjectTypeListController *)FilterProjectTypeListController selectItem:(ProjectTypeList *)item
{
    self.ProjectTypeid = item.m_id;
    [self startSearch:self.keywords];
}

#pragma mark FilterNeedTypeViewController delegate
-(void)cancelSelectFilterNeedTypeViewController:(FilterNeedTypeViewController *)FilterNeedTypeViewController
{
//    self.needtype = nil;
//    self.needmoney = nil;
}

-(void)FilterNeedTypeViewController:(FilterNeedTypeViewController *)FilterNeedTypeViewController selectItem:(NSString *)title money:(NSString *)money
{
    self.needtype = title;
    self.needmoney = money;
//    [self presentMessageTips_:[NSString stringWithFormat:@"选择了%@",money]];
    [self startSearch:self.keywords];
    
}
-(void)FilterNeedTypeViewController:(FilterNeedTypeViewController *)FilterNeedTypeViewController selectItem:(NSString *)title
{
    self.needtype = title;
    self.needmoney = nil;
//    [self presentMessageTips_:[NSString stringWithFormat:@"选择了%@",title]];
    [self startSearch:self.keywords];
}

#pragma mark D4_CollegeSelectorController Delegate
-(void)cencelSelectD4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController
{
//    self.schoolId = nil;
//    self.collegeName = nil;
//    self.filterboard.btn_school.selected = NO;
}
-(void)D4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController selectCollegeName:(NSString *)collegeName collegeID:(NSString *)collegeID
{
//    [self presentMessageTips_:[NSString stringWithFormat:@"选择了%@",collegeName]];
    self.collegeName = collegeName;
    self.schoolId = collegeID;
    
    [self startSearch:self.keywords];
}
#pragma mark - searchbar delegate 
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    self.navigationbar.rightItem.hidden = NO;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
//    self.navigationbar.rightItem.hidden = YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self startSearch:searchBar.text];
}

#pragma mark - 开始搜索
-(void)startSearch:(NSString *)keywords
{
    self.keywords = keywords;
    [[HTTPSEngine sharedInstance]  fetch_projectSearchWithKey:keywords page:@1 schoolId:self.schoolId typeId:self.ProjectTypeid demand:self.needtype money:nil response:^(NSString *responsejson) {
        NSLog(@"%@",responsejson);
        NSDictionary * Dictionary = [NSDictionary dictionaryWithJSONString:responsejson error:nil];
        if ([Dictionary isErrorObject]) {
            APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips:error.m_errorMsg];
            self.searchBar.text = @"";
        }
        else
        {
            NSArray * newslist = [ProjectListModel encodeDiction:Dictionary];
            if (newslist.count) {
                if(![self.historylist containsObject:keywords])
                [self.historylist insertObject:keywords atIndex:0];
                SET_OBJECT_OF_USERDEFAULT(self.historylist, KEY_HISTORY_SEARCH);
            }
            else
            {
                [self presentMessageTips_:@"没有搜索结果"];
            }
            self.searchBar.text = @"";
            [self datachange:newslist];
        }
    } errorHandler:nil];
}

#pragma mark 历史记录
-(void)loadHistorySearch:(NSArray *)array
{
    if (!array.count) {
        return;
    } 
    if (self.filterboard) {
        self.filterboard.hidden = YES;
        [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    }
    self.tableView.tableFooterView = [self footerView];
    [self.dataDictionary removeAllObjects];
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
     
        CELL_STRUCT * cell_struct = [JXL_Common cell_x_x_struct:obj target:self selectAction:@selector(selectAction:)];
        [self.dataDictionary setObject:cell_struct forKey:KEY_INDEXPATH(0, idx)];
     }];
    [self.tableView reloadData];
}

#pragma mark 搜索结果
-(void)datachange:(NSArray *)array
{
    if (!array.count) {
        //        [self loadHistorySearch:self.historylist];
        self.tableView.tableFooterView = nil;
        [self.dataDictionary removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    [self.searchBar resignFirstResponder];
    if (self.filterboard) {
        self.filterboard.hidden = NO;
        [self adjustContentOffSet:self.filterboard.bottom bottom:0];
    }
    self.tableView.tableFooterView = nil;
    [self.dataDictionary removeAllObjects];
    [array enumerateObjectsUsingBlock:^(ProjectList *obj, NSUInteger idx, BOOL *stop) {
        
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"NewsTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.picture = obj.m_team_photo;
        cell0_0.object  =  obj;
        cell0_0.value   = obj.m_demandName;
        
        cell0_0.subvalue1 = @"xib";
        cell0_0.subvalue2 = @"C1_ProjectViewController";
        cell0_0.cellheight = [NewsTableViewCell heightOfCell];
        
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_newstableviewcell_dianzan:obj.m_topNum,key_newstableviewcell_views:obj.m_views,key_newstableviewcell_title:obj.m_demandName,key_newstableviewcell_photo:obj.m_team_photo,key_newstableviewcell_isproject:@1,key_newstableviewcell_projectlocation:JOIN_STR(obj.m_schoolCity, @"  ", obj.m_schoolName)}];
        [self.dataDictionary setObject:cell0_0 forKey:KEY_INDEXPATH(0, idx)];
    }];
    [self.tableView reloadData];
    
}
#pragma mark 行选择

GET_CELL_SELECT_ACTION(cellstruct)
{
    NSString * Classname = cellstruct.subvalue2;
    if ([Classname isEqualToString:@"C1_ProjectViewController"]) {
        C1_ProjectViewController *ctr = [[C1_ProjectViewController alloc] init];
        ProjectList * pro = (ProjectList *) cellstruct.object;
        ctr.m_projectid = pro.m_id;
        [[RootViewController sharedInstance].navigationController pushViewController:ctr animated:YES];
    }
    
    if([cellstruct.cellclass isEqualToString:@"BaseTableViewCell"])
    {
        [self startSearch:cellstruct.title];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)clearHistory
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_HISTORY_SEARCH];
    [self.dataDictionary removeAllObjects];
    [self.historylist removeAllObjects];
    [self.tableView reloadData];
}

-(UIView *)footerView
{
    if (!_footerView) {
        _footerView =[JXL_Common BigCenterButtonview:CGRectMake(0, 0, SCREEN_WIDTH, 50) btnframe:CGRectMake(10, 10, SCREEN_WIDTH - 20, 30)  title:@"清除历史记录" target:self sel:@selector(clearHistory)];;
    }
    return _footerView;
 
}


-(FilterSearchBoard *)filterboard
{
    if (!_filterboard) {
         _filterboard = [[[NSBundle mainBundle] loadNibNamed:@"FilterSearchBoard" owner:nil options:nil] firstObject];
        _filterboard.frame = CGRectMake(0, HEIGHT_NAVIGATIONBAR, self.view.width, 40);
        [_filterboard addTarget:self action:@selector(filterSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_filterboard];
    }
    return _filterboard;
}

@end
