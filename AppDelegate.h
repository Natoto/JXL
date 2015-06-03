//
//  AppDelegate.h
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSideViewController.h"
#import "RootViewController.h"
#import "GuidanceViewController.h"
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define AppdelegateSideViewController  APPDELEGATE.sideViewController
#define AppdelegateRootViewController  ((RootViewController *)AppdelegateSideViewController.rootViewController)

@interface AppDelegate : UIResponder <UIApplicationDelegate,GuidanceViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) HSideViewController *sideViewController;


@property (nonatomic,strong) UIViewController * currentViewController;
@property (nonatomic,strong) UIViewController * viewController;

@end
