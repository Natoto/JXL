//
//  BaseRootViewController.m
//  JXL
//
//  Created by 星盛 on 15/4/14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseRootViewController.h"
#import "RKTabView.h"
#import "AppDelegate.h"
#import "HBSignalBus.h"
#import "AdvertiseList.h"
#import "WebViewController.h"
#import "GlobalData.h"
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
@interface BaseRootViewController ()<RKTabViewDelegate>

@end

@implementation BaseRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    RKTabItem *anniushouye = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"anniushouye_select"] imageDisabled:[UIImage imageNamed:@"anniushouye"]];
    anniushouye.tabState = TabStateEnabled;
    
    RKTabItem *anniuxiangmu = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"anniuxiangmu_select"] imageDisabled:[UIImage imageNamed:@"anniuxiangmu"]];
    
//    RKTabItem *anniuzhibo = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"anniuzhibo_select"] imageDisabled:[UIImage imageNamed:@"anniuzhibo"]];
    
    RKTabItem *anniuxinwen = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"anniuxinwen_select"] imageDisabled:[UIImage imageNamed:@"anniuxinwen"]];
    
    RKTabItem *anniuwode = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"anniuwode_select"] imageDisabled:[UIImage imageNamed:@"anniuwode"]];
    
    if (self.tabViewSocial) {
        self.tabViewSocial.horizontalInsets = HorizontalEdgeInsetsMake(15, 15);
   
        self.tabViewSocial.drawSeparators = NO;
        self.tabViewSocial.delegate = self;
        [self.tabViewSocial setTabItems:@[anniushouye, anniuxinwen,anniuxiangmu,anniuwode]];
        [self.tabViewSocial setBackgroundColor: JXL_COLOR_THEME_TABBAR];
        self.tabViewSocial.anomalyStyle = NO;
    }
     
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.view bringSubviewToFront:self.tabViewSocial];
}

-(void)drawtabviewsociallayer
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, UISCREEN_WIDTH, 0.5);
    //    imageLayer.contents = (id)image.CGImage;
    imageLayer.cornerRadius = 0;  //设置layer圆角半径
    imageLayer.masksToBounds = YES;  //隐藏边界
    imageLayer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.8].CGColor;  //边框颜色
    imageLayer.borderWidth = 0.5;
    [self.tabViewSocial.layer addSublayer:imageLayer];
}

-(RKTabView *)tabViewSocial
{
    if (!_tabViewSocial) {
        _tabViewSocial = [[RKTabView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - [RKTabView heightOfTabView], [UIScreen mainScreen].bounds.size.width, [RKTabView heightOfTabView])];
        _tabViewSocial.backgroundColor = [UIColor clearColor];
        _tabViewSocial.anomalyStyle = YES;
        [self drawtabviewsociallayer];
    }
    return _tabViewSocial;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem
{
    NSLog(@"tabBecameEnabledAtIndex %d",index);
    [self TabSelectAtIndex:index];
}
- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem
{
    
}

-(void)TabSelectAtIndex:(int)index
{
    
}
@end
