//
//  ActivityViewController.m
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "ActivityContentViewController.h"
#import "ProjectContentViewController.h"
#import "ActivityTableViewCell.h"
#import "HBSignalBus.h"
#import "jxl.h"
#import "A0_FirstPageADCell.h"
#import "ActivityModel.h"
#import "A2_ActivityInfoViewController.h"
#import "RootViewController.h"
@interface ActivityContentViewController ()
AS_ARRAY(advertiseList)
AS_CELL_STRUCT_JXLCOMMON(lunbo)
@end

@implementation ActivityContentViewController
GET_A0_FIRSTPAGE_CELL(lunbo, @"A0_FirstPageADCell", [A0_FirstPageADCell heightOfCell])

@synthesize dataDictionary = _dataDictionary;
- (void)viewDidLoad {
    [super viewDidLoad];
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"ActivityTableViewCell");
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A0_FirstPageADCell");
    self.view.backgroundColor = JXL_COLOR_THEME;
    
    self.noHeaderFreshView = NO;
    self.noFooterView = NO;
    [[HBSignalBus shareIntance] observerWithObject:self key:@"showbackitem" targetclass:@"JXL"];
    [self.dataDictionary setObject:self.cell_struct_lunbo forKey:KEY_INDEXPATH(0, 0)];
    
    // Do any additional setup after loading the view.
}


-(void)refreshView
{
    //广告
    [self reloadADS];
    //活动
    [self reloadActivities:1];
}

-(void)getNextPageView
{
    NSInteger page = (self.dataDictionary.count -1)/20;
    [self reloadActivities:page];
}


-(void)reloadActivities:(NSInteger)page
{
    NSInteger count = self.dataDictionary.count -1;
    page = page?page:1;
    [[HTTPSEngine sharedInstance] fetch_activityListWithcatid:self.m_catid mid:[GlobalData sharedInstance].m_mid page:[NSNumber numberWithInteger:page] pagesize:@20 response:^(NSString *responsejson) {
        [self FinishedLoadData];
        NSLog(@"%@",responsejson);
        NSArray * activities = [ActivityModel encodeactivitylistWithJsonstring:responsejson];
        if (activities.count) {
            [activities enumerateObjectsUsingBlock:^(activitylist * obj, NSUInteger idx, BOOL *stop) {
                CELL_STRUCT * cell_struct = [self create_activitycell:obj.title pic:obj.thumb];
                cell_struct.object = obj;
                NSInteger row = idx;
                if (page > 1) {
                    row = count + idx;
                }
                [self.dataDictionary setObject:cell_struct forKey:KEY_INDEXPATH(1, row)];
            }];
            [self.tableView reloadData];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

-(void)reloadADS
{
    [[HTTPSEngine sharedInstance] fetch_advertiseListWithType:@"3" catid:self.m_catid response:^(NSDictionary *Dictionary) {
        
        if (Dictionary) {
            NSLog(@"活动广告：%@",Dictionary);
            NSArray * array = [AdvertiseListModel encodeDiction:Dictionary];
            self.m_advertiseList = array;
            if (array.count) {
                [self loadTopNews:array];
                [self.tableView reloadData];
            }
        }
    } errorHandler:^(NSError *error) {}];
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


-(void)dealloc
{
    [[HBSignalBus shareIntance] removeObserver:self key:@"showbackitem" targetname:@"JXL"];
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
-(void)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.tableView.frame = CGRectMake(0, top, UISCREEN_WIDTH ,UISCREEN_HEIGHT - top - bottom);
}


-(CELL_STRUCT *)create_activitycell:(NSString *)title pic:(NSString *)picture
{
    CELL_STRUCT * cell0_0;
    cell0_0 = [[CELL_STRUCT alloc] initWithtitle:title cellclass:@"ActivityTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell0_0.picture = picture;
    cell0_0.object= @"BaseViewController";
    cell0_0.subvalue1 = @"xib";
    cell0_0.cellheight = [ActivityTableViewCell heightOfCell];
    cell0_0.titlecolor = @"white";
    cell0_0.selectionStyle = NO;
    cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
    return cell0_0;
}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        NSMutableDictionary * array0 =[NSMutableDictionary dictionary];
        _dataDictionary = array0;
    }
    return _dataDictionary;
}

GET_CELL_SELECT_ACTION(cellstruct)
{
    if (cellstruct) {
        activitylist * active = (activitylist *)cellstruct.object;
        if(!active) return;
        A2_ActivityInfoViewController * ctr = [[A2_ActivityInfoViewController alloc] init];
        ctr.m_Activity = active;
        [[RootViewController sharedInstance] rootpushviewcontroller:ctr animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
