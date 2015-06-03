//
//  TopSelectorPageViewController.h
//  JXL
//
//  Created by 星盛 on 15/4/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseViewController.h"
#import "TopSelectorScrollerView.h"
#import "HBNavigationbar.h"


//
@interface HBTopSelectorPageViewController : BaseViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,TopSelectorScrollerViewDelegate>
 

@property(nonatomic,retain)   UIPageViewController      *   pageViewController;
@property (nonatomic,retain)  NSArray                   *   controllerArray;
@property (strong, nonatomic) TopSelectorScrollerView   *   topSelectorScrollerView;
//@property (strong, nonatomic) HBNavigationbar           *   navigationbar;
//+(TopSelectorScrollerView *)defaultTopSelectorScrollerView;

-(void)selectViewControllerWithIndex:(NSInteger) index;

-(void)reloadData;
@end
