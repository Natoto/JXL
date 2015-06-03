//
//  NewsCotentViewController.m
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "NewsCotentViewController.h"
#import "ProjectContentViewController.h"
#import "NewsTableViewCell.h"
#import "HBSignalBus.h"
#import "jxl.h"
#import "B1_ANewsViewController.h"
#import "RootViewController.h"
#import "A0_FirstPageADCell.h"

@interface NewsCotentViewController ()<A0_FirstPageADCellDelegate>
AS_ARRAY(advertiseList)
AS_CELL_STRUCT_JXLCOMMON(lunbo)
@end

@implementation NewsCotentViewController
@synthesize dataDictionary = _dataDictionary;

GET_A0_FIRSTPAGE_CELL(lunbo, @"A0_FirstPageADCell", [A0_FirstPageADCell heightOfCell])

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.view.backgroundColor = JXL_COLOR_THEME;
    ADD_HBSIGNAL_OBSERVER(self, @"showbackitem", @"JXL")
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"NewsTableViewCell");
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_FirstPageADCell")
    
    [self setNoHeaderFreshView:NO];
    [self setNoFooterView:NO];
    
    [self reloadNews];
    if (self.m_catid) {
        NSArray * array = [[CacheCenter sharedInstance] readObject:[NSString stringWithFormat:@"newslist%@",self.m_catid]];
        if (array) {
            [self datachange:array];
        }
    }
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

-(void)viewWillAppear:(BOOL)animated
{
    if (1 >= self.dataDictionary.count) {
        [self refreshView];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    
}
 
-(void)reloadNews
{
    [[HTTPSEngine sharedInstance] fetch_advertiseListWithType:@"1" catid:self.m_catid response:^(NSDictionary *Dictionary) {
        
        if (Dictionary) {
            NSLog(@"新闻广告：%@",Dictionary);
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

-(void)requestData:(NSInteger)page
{
    [[HTTPSEngine sharedInstance] fetch_newsListWithcatid:self.m_catid page:page pagesize:20 response:^(NSDictionary *Dictionary) {
        [self FinishedLoadData];
        if ([Dictionary isErrorObject]) {
            APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips:error.m_errorMsg];
        }
        else
        {
            NSArray * newslist = [NewsListModel encodeDiction:Dictionary];
            if (!newslist.count) {
                [self presentMessageTips:@"无内容"];
            }
            else
            {
                [[CacheCenter sharedInstance] saveObject:newslist forkey:[NSString stringWithFormat:@"newslist%@",self.m_catid]];
            }
            [self datachange:newslist];
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


-(void)refreshView
{
    NSInteger page = 1;
    [self reloadNews];
    [self requestData:page];
}

-(void)getNextPageView
{
    NSInteger page = 1 + self.dataDictionary.count/20;
    [self requestData:page];
}
 

ON_HBSIGNAL(JXL, showbackitem, notify)
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

-(void)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.tableView.frame = CGRectMake(0, top, UISCREEN_WIDTH ,UISCREEN_HEIGHT - top - bottom);
}

-(void)setM_catid:(NSString *)m_catid
{
    _m_catid = m_catid;
   
}

-(void)datachange:(NSArray *)array
{
    if (!array.count) {
        [self.dataDictionary removeAllObjects];
        if (self.m_advertiseList.count) {
            [self.dataDictionary setObject:self.cell_struct_lunbo forKey:KEY_INDEXPATH(0, 0)];
        }
        [self.tableView reloadData];
        return;
    }
//    NSMutableDictionary * diction = [[NSMutableDictionary alloc] initWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(NewsList *obj, NSUInteger idx, BOOL *stop) {
        
       CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"NewsTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.picture = obj.m_thumb;
        cell0_0.object = obj;
        cell0_0.value  = obj.m_content;
        
        cell0_0.subvalue1 = @"xib";
        cell0_0.cellheight = [NewsTableViewCell heightOfCell];
          
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_newstableviewcell_dianzan:obj.m_topNum,key_newstableviewcell_views:obj.m_views,key_newstableviewcell_title:obj.m_title,key_newstableviewcell_photo:obj.m_thumb}];
        [self.dataDictionary setObject:cell0_0 forKey:KEY_INDEXPATH(1, idx)];
    }];
    [self.tableView reloadData];
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
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    NewsList *obj = cellstruct.object;
    B1_ANewsViewController * ctr = [[B1_ANewsViewController alloc] initWithNewsId:obj.m_id mid:[GlobalData sharedInstance].m_mid];
    ctr.m_newcomment = obj.m_views;
    ctr.title = obj.m_content;
    ctr.image = obj.m_thumb;
    [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];// pushViewController:ctr animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
