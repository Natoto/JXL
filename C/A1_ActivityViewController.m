//
//  A1_ActivityViewController.m
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A1_ActivityViewController.h"
#import "ActivityContentViewController.h"
#import "HBNavigationbar.h"
#import "UIImage+Tint.h"
#import "HBSignalBus.h"
#import "jxl.h"
#import "ActivityModel.h"

@interface A1_ActivityViewController ()

@end

@implementation A1_ActivityViewController
@synthesize controllerArray = _controllerArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目";
    
    if (self.navigationController.topViewController == self) {
        self.showBackItem = YES;
    }
    [self refreshview];
    
    
    NSArray * array = [[CacheCenter sharedInstance] readObject:@"fetch_activityType"];
    [self dataChange:array];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    
    self.statusBarStyleDefault = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.navigationController.topViewController == self) {
            self.showBackItem = YES;
        }
        else
        {
            self.showBackItem = NO;
        }
        [[HBSignalBus shareIntance] sendUISignalwithsourceclassname:@"JXL" key:@"showbackitem" withObject:[NSNumber numberWithBool:self.showBackItem]];
    });
    
}

-(void)refreshview
{
    [[HTTPSEngine sharedInstance] fetch_activityType:^(NSString *responsejson) {
        NSLog(@"%@",responsejson);
        if (responsejson) {
            NSArray * array = [ActivityModel encodeActivityTypeWithJsonstring:responsejson];
            [[CacheCenter sharedInstance] saveObject:array forkey:@"fetch_activityType"];
            [self dataChange:array];
        }

    } errorHandler:^(NSError *error) {
        
    }];
}
-(void)dataChange:(NSArray *)array
{
    if (!array && array.count == 0) {
        return;
    }
    NSMutableArray * ctrs  = [NSMutableArray arrayWithCapacity:0];
    
    [array enumerateObjectsUsingBlock:^(ActivityType *obj, NSUInteger idx, BOOL *stop) {
        ActivityContentViewController * viewController1 = [[ActivityContentViewController alloc] init];
        viewController1.m_catid = obj.catid;
        viewController1.title = obj.catname;
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
    
    ActivityContentViewController * ctr = [self.controllerArray objectAtIndex:0];
    [ctr refreshView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backtoparent:(id)sender
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSArray *)controllerArray
{
    if (!_controllerArray) {
        
        ActivityContentViewController * viewController1 = [[ActivityContentViewController alloc] init];
        viewController1.title = @"活动 1";
        if (!self.showBackItem) {
            [viewController1 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        ActivityContentViewController * viewController2 = [[ActivityContentViewController alloc] init];
        viewController2.title = @"活动 2";
        if (!self.showBackItem) {
            [viewController2 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        ActivityContentViewController * viewController3 = [[ActivityContentViewController alloc] init];
        viewController3.title = @"活动 3";
        if (!self.showBackItem) {
            [viewController3 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        ActivityContentViewController * viewController4 = [[ActivityContentViewController alloc] init];
        viewController4.title = @"活动 4";
        if (!self.showBackItem) {
            [viewController4 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        ActivityContentViewController * viewController5 = [[ActivityContentViewController alloc] init];
        viewController5.title = @"活动 5";
        if (!self.showBackItem) {
            [viewController5 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        _controllerArray = [[NSArray alloc] initWithObjects:viewController1,viewController2,viewController3, viewController4, viewController5 ,nil];
    }
    return _controllerArray;
}


@end
