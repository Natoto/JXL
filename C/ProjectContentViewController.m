//
//  PageContentViewController.m
//  JXL
//
//  Created by BooB on 15-4-19.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "JXL_Define.h"
#import "ProjectContentViewController.h"
#import "ActivityTableViewCell.h"
#import "HBSignalBus.h"
#import "C1_ProjectViewController.h"
#import "RootViewController.h"
#import "jxl.h"
#import "NewsTableViewCell.h"
#import "A0_FirstPageADCell.h"

@interface ProjectContentViewController ()<A0_FirstPageADCellDelegate>
AS_ARRAY(advertiseList)
AS_CELL_STRUCT_JXLCOMMON(lunbo)


@end

@implementation ProjectContentViewController
@synthesize dataDictionary = _dataDictionary;

GET_A0_FIRSTPAGE_CELL(lunbo, @"A0_FirstPageADCell", [A0_FirstPageADCell heightOfCell])

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JXL_COLOR_THEME;
    [self setNoHeaderFreshView:NO];
    [[HBSignalBus shareIntance] observerWithObject:self key:@"showbackitem" targetclass:@"JXL"];
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"NewsTableViewCell");
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_FirstPageADCell");
    
    [self reloadNews];
    if (self.m_typeid) {
        NSArray * array = [[CacheCenter sharedInstance] readObject:[NSString stringWithFormat:@"projectlist%@",self.m_typeid]];
        if (array) {
            [self datachange:array];
        }
    }
    // Do any additional setup after loading the view.
} 

-(void)viewDidAppear:(BOOL)animated
{
    
}
-(void)dealloc
{
    [[HBSignalBus shareIntance] removeObserver:self key:@"showbackitem" targetname:@"JXL"];
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


-(void)handelSignal_JXL_showbackitem:(NSNotification *)notify
{
    NSNumber * show = notify.object;
    if (show.boolValue) {
        [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    }
    else
    {
        [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
    }
}

-(void)viewWillAppear:(BOOL)animated
{ 
    if (1 >= self.dataDictionary.count) {
        [self refreshView];
    }
}

-(void)refreshView
{
    [self reloadNews];
    [self requestData];
}

-(void)requestData
{
    [[HTTPSEngine sharedInstance] fetch_projectList:self.m_typeid response:^(NSDictionary *Dictionary) {
        
        [self FinishedLoadData];
        if ([Dictionary isErrorObject]) {
            APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips:error.m_errorMsg];
        }
        else
        {
            NSArray * newslist = [ProjectListModel encodeDiction:Dictionary];
            [[CacheCenter sharedInstance] saveObject:newslist forkey:[NSString stringWithFormat:@"projectlist%@",self.m_typeid]];
            [self datachange:newslist];
        }
    } errorHandler:^(NSError *error) {
    }];
}


-(void)reloadNews
{
    [[HTTPSEngine sharedInstance] fetch_advertiseListWithType:@"2" catid:self.m_typeid response:^(NSDictionary *Dictionary) {
        
        if (Dictionary) {
            NSLog(@"项目广告：%@",Dictionary);
            NSArray * array = [AdvertiseListModel encodeDiction:Dictionary];
            self.m_advertiseList = array;
            if (array.count) {
                [self loadTopNews:array];
                [self.tableView reloadData];
            }
        }
    } errorHandler:^(NSError *error) {
        
    }];
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


-(void)datachange:(NSArray *)array
{
    if (!array.count) {
        return;
    }
    [array enumerateObjectsUsingBlock:^(ProjectList *obj, NSUInteger idx, BOOL *stop) {
        
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"NewsTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.picture = obj.m_team_photo;
        cell0_0.object =  obj;
        cell0_0.value  = obj.m_demandName;
        
        cell0_0.subvalue1 = @"xib";
        cell0_0.subvalue2 = @"C1_ProjectViewController";
        cell0_0.cellheight = [NewsTableViewCell heightOfCell];
        
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_newstableviewcell_dianzan:obj.m_topNum,key_newstableviewcell_views:obj.m_views,key_newstableviewcell_title:obj.m_demandName,key_newstableviewcell_photo:obj.m_team_photo,key_newstableviewcell_isproject:@1,key_newstableviewcell_projectlocation:JOIN_STR(obj.m_schoolCity, @"  ", obj.m_schoolName)}];
        [self.dataDictionary setObject:cell0_0 forKey:KEY_INDEXPATH(1, idx)];
    }];
    [self.tableView reloadData];
    
}

-(void)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.tableView.frame = CGRectMake(0, top, UISCREEN_WIDTH ,UISCREEN_HEIGHT - top - bottom);
}


-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _dataDictionary;
}

-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT *cellstruct = (CELL_STRUCT *)sender;
     NSString * Classname = cellstruct.subvalue2;
    
    if ([Classname isEqualToString:@"C1_ProjectViewController"]) {
        C1_ProjectViewController *ctr = [[C1_ProjectViewController alloc] init];
        ProjectList * pro = (ProjectList *) cellstruct.object;
        ctr.m_projectid = pro.m_id;
        [[RootViewController sharedInstance].navigationController pushViewController:ctr animated:YES];
    }
    else
    {
        Classname = Classname?Classname:@"BaseViewController";
        Class cls = NSClassFromString(Classname);
        BaseViewController * ctr = nil;
        ctr = [[cls alloc] init];
        [[RootViewController sharedInstance].navigationController pushViewController:ctr animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
