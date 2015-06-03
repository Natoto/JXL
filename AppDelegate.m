//
//  AppDelegate.m
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "HSideViewController.h"
#import "RootViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "jxl.h"
#import "HTTPSEngine.h"
#import "GuidanceViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //    self.window.backgroundColor = [UIColor whiteColor];
    self.viewController = [[UIViewController alloc] init];
    
     self.currentViewController = [self getRootViewController:[GlobalData sharedInstance].getIsRunGuidance];
   
    [self.viewController.view addSubview:self.currentViewController.view];
    
    self.window.rootViewController=self.viewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(UIViewController *)getRootViewController:(BOOL)runguidance
{
    if (runguidance) {
        RootViewController *mainViewController= [RootViewController sharedInstance];
        mainViewController.view.backgroundColor= [UIColor whiteColor];
        
        UINavigationController * mainNavigationctr = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [mainNavigationctr.navigationBar setHidden:YES];
        //
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        LeftViewController *leftViewController=[[LeftViewController alloc]init];
        RightViewController *rightViewController=[[RightViewController alloc]init];
        _sideViewController=[[HSideViewController alloc]initWithNibName:nil bundle:nil];
        _sideViewController.view.backgroundColor = [UIColor clearColor];
        _sideViewController.leftViewShowWidth = [UIScreen mainScreen].bounds.size.width * 0.5;
        _sideViewController.rightViewShowWidth = [UIScreen mainScreen].bounds.size.width * 0.5;
        _sideViewController.rootViewController = mainNavigationctr;
        _sideViewController.leftViewController= nil; //leftViewController;
        _sideViewController.rightViewController=rightViewController;
        
        _sideViewController.needSwipeShowMenu=NO;//默认开启的可滑动展示
        //动画效果可以被自己自定义，具体请看api
        
        return _sideViewController;
    }
    else
    {
        GuidanceViewController * ctr = [[GuidanceViewController alloc] init];
        ctr.delegate = self;
        return ctr;
    }

} 
-(void)GuidanceViewController:(GuidanceViewController *)GuidanceViewController selectButtonTag:(NSInteger)tag dismissblock:(void (^)())dismissblock
{
    if (tag ==2) {
        [[GlobalData sharedInstance] setGetIsRunGuidance:YES];
        [self.currentViewController.view removeFromSuperview];
        self.currentViewController = [self getRootViewController:YES];
        [self.viewController.view addSubview:self.currentViewController.view];
    }
    else if(tag == 0)//登录
    {
        [[GlobalData sharedInstance] setGetIsRunGuidance:YES];
        [self.currentViewController.view removeFromSuperview];
        self.currentViewController = [self getRootViewController:YES];
        [self.viewController.view addSubview:self.currentViewController.view];
        [[RootViewController sharedInstance] rootpresentLoginViewController];
    }
    else if(tag == 1)//注册
    {
        [[GlobalData sharedInstance] setGetIsRunGuidance:YES];
        [self.currentViewController.view removeFromSuperview];
        self.currentViewController = [self getRootViewController:YES];
        [self.viewController.view addSubview:self.currentViewController.view];
        [[RootViewController sharedInstance] rootRegisterView1Controller];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
