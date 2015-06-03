//
//  C0_ProjectViewController.m
//  JXL
//
//  Created by BooB on 15-4-14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "C0_ProjectViewController.h"
#import "ProjectContentViewController.h"
#import "HBNavigationbar.h"
#import "UIImage+Tint.h"
#import "HBSignalBus.h"
#import "jxl.h"
@interface C0_ProjectViewController ()

@end

@implementation C0_ProjectViewController
@synthesize controllerArray = _controllerArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目";
    
    if (self.navigationController.topViewController == self) {
        self.showBackItem = YES;
    }
    
    
    [[ProjectTypeListModel sharedInstance] projectTypeList:^(NSDictionary *Dictionary) {
        NSLog(@"%@",Dictionary);
        if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
            NSArray * array = [ProjectTypeListModel encodeDiction:Dictionary];
            NSMutableArray * ctrs  = [NSMutableArray arrayWithCapacity:0];
            
            [array enumerateObjectsUsingBlock:^(ProjectTypeList *obj, NSUInteger idx, BOOL *stop) {
                ProjectContentViewController * viewController1 = [[ProjectContentViewController alloc] init];
                viewController1.m_typeid = obj.m_id;
                viewController1.title = obj.m_name;
                viewController1.m_sort = obj.m_sort;
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
            
            ProjectContentViewController * ctr = [self.controllerArray objectAtIndex:0];
            [ctr refreshView];
        }
    } errorHandler:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
     self.statusBarStyleDefault = YES;
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.navigationController.topViewController == self) {
                    self.showBackItem = YES;
                }
                else
                {
                    self.showBackItem = NO;
                }
                [[HBSignalBus shareIntance] sendUISignalwithsourceclassname:@"JXL" key:@"showbackitem" withObject:[NSNumber numberWithBool:self.showBackItem]];
            });
        });

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
        
        ProjectContentViewController * viewController1 = [[ProjectContentViewController alloc] init];
        viewController1.title = @"项目 1";
        
        ProjectContentViewController * viewController2 = [[ProjectContentViewController alloc] init];
        viewController2.title = @"项目 2";
        
        ProjectContentViewController * viewController3 = [[ProjectContentViewController alloc] init];
        viewController3.title = @"项目 3";
        if (!self.showBackItem) {
            [viewController1 adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
        }
        _controllerArray = [[NSArray alloc] initWithObjects:viewController1,viewController2,viewController3 ,nil];
    }
    return _controllerArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
