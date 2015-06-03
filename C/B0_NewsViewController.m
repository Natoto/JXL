//
//  B0_NewsViewController.m
//  JXL
//
//  Created by BooB on 15-4-14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "B0_NewsViewController.h"
#import "TopSelectorScrollerView.h"
#import "UIImage+Tint.h"
#include "NewsCotentViewController.h"
#import "HBSignalBus.h"
#import "HTTPSEngine.h"
#import "jxl.h"

@interface B0_NewsViewController ()
@end

@implementation B0_NewsViewController
@synthesize controllerArray = _controllerArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.controllerArray) {
        [self.pageViewController setViewControllers:@[[self.controllerArray objectAtIndex:0]] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
    }
    
    [[HTTPSEngine sharedInstance] fetch_catList:^(NSDictionary *Dictionary) {
        NSLog(@"%@",Dictionary);
        if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
            NSArray * array = [CatListModel encodeDiction:Dictionary];
            NSMutableArray * ctrs  = [NSMutableArray arrayWithCapacity:0];
            
            [array enumerateObjectsUsingBlock:^(catList *obj, NSUInteger idx, BOOL *stop) {
                NewsCotentViewController * viewController1 = [[NewsCotentViewController alloc] init];
                viewController1.m_catid = obj.m_catid;
                viewController1.title = obj.m_catname;
                if (!self.showBackItem) {
                    [viewController1 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
                }
                else
                {
                    [viewController1 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
                }
                [ctrs addObject:viewController1];
            }];
            self.controllerArray = ctrs;
            [self reloadData];
            [self.pageViewController setViewControllers:@[[self.controllerArray objectAtIndex:0]] direction:(UIPageViewControllerNavigationDirectionReverse) animated:YES completion:nil];
            
            NewsCotentViewController * ctr = [self.controllerArray objectAtIndex:0];
            [ctr refreshView];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}


-(void)selectViewControllerWithIndex:(NSInteger)index
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.statusBarStyleDefault = YES;
    [super viewWillAppear:animated];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[HBSignalBus shareIntance] sendUISignalwithsourceclassname:@"JXL" key:@"showbackitem" withObject:[NSNumber numberWithBool:self.showBackItem]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.navigationController.topViewController == self) {
                    self.showBackItem = YES;
                }
                else
                {
                    self.showBackItem = NO;
                }
            });
    });
    
}
-(NSArray *)controllerArray
{
    if (!_controllerArray) {
        
        NewsCotentViewController * viewController1 = [[NewsCotentViewController alloc] init];
        viewController1.title = @"新闻 1";
        if (!self.showBackItem) {
            [viewController1 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        NewsCotentViewController * viewController2 = [[NewsCotentViewController alloc] init];
        viewController2.title = @"新闻 2";
        if (!self.showBackItem) {
            [viewController2 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        NewsCotentViewController * viewController3 = [[NewsCotentViewController alloc] init];
        viewController3.title = @"新闻 3";
        if (!self.showBackItem) {
            [viewController3 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        NewsCotentViewController * viewController4 = [[NewsCotentViewController alloc] init];
        viewController4.title = @"新闻 4";
        if (!self.showBackItem) {
            [viewController4 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        NewsCotentViewController * viewController5 = [[NewsCotentViewController alloc] init];
        viewController5.title = @"新闻 5";
        if (!self.showBackItem) {
            [viewController5 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        _controllerArray = [[NSArray alloc] initWithObjects:viewController1,viewController2,viewController3, viewController4, viewController5 ,nil];
    }
    
    return _controllerArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
@end
