//
//  OlinePlayViewController.m
//  JXL
//
//  Created by 跑酷 on 15/5/13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "OnlinePlayViewController.h"

@interface OnlinePlayViewController ()

@end

@implementation OnlinePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self userDefaultBackground];
    [self.navigationbar setTitle:@"直播"];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
