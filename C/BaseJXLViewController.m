//
//  BaseJXLViewController.m
//  JXL
//
//  Created by 跑酷 on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseJXLViewController.h"

@interface BaseJXLViewController ()

@end

@implementation BaseJXLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self userDefaultBackground];
    //自定义navigatonbar的配置
    [self navigationbar];
    [self showhbnavigationbarBackItem:YES];
    [self.navigationbar setTitle:@""];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    //tableview的配置
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    self.tableView.backgroundColor = JXL_COLOR_THEME;
    
    // Do any additional setup after loading the view.
}

-(void)setTitle:(NSString *)title
{
    [self.navigationbar setTitle:title];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
