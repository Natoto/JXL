//
//  RootViewController.h
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseRootViewController.h"
#import <UIKit/UIKit.h>
#import "JXL_Define.h"

#import "A0_FirstPageViewController.h"
#import "B0_NewsViewController.h"
#import "C0_ProjectViewController.h"
#import "D0_MineViewController.h"
#import "OnlinePlayViewController.h"
@interface RootViewController : BaseRootViewController
AS_SINGLETON(RootViewController)

@property (strong, nonatomic) A0_FirstPageViewController    *   firstpagectr;
@property (strong, nonatomic) B0_NewsViewController         *   newsctr;
@property (strong, nonatomic) OnlinePlayViewController      *   onlinectr;
@property (strong, nonatomic) C0_ProjectViewController      *   projectctr;
@property (strong, nonatomic) D0_MineViewController         *   minectr;

-(void)openURL:(NSString *)htmlurl;//打开广告
-(void)rootpushviewcontroller:(UIViewController *)ctr animated:(BOOL)anmimated;
-(void)rootpresentViewController:(UIViewController *)ctr animated:(BOOL)animated completion:(void (^)(void))completion;
-(void)rootpresentLoginViewController;
-(void)rootRegisterView1Controller;
@end
