//
//  RootViewController.m
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "YahooEngine.h"
#import "HTTPSEngine.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "TopSelectorScrollerView.h"
#import "jxl.h"
#import "WebViewController.h"
#import "D1_LoginViewController.h"
#import "D1_RegisterView1Controller.h"
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface RootViewController ()<BaseViewControllerDelegate,A0_FirstPageViewControllerDelegate>
@property (strong, nonatomic) YahooEngine *yahooEngine;

@property (strong, nonatomic) HTTPSEngine               *   httpsTestsEngine;
@property (strong, nonatomic) UIView                        *   currentctrview;
@end

@implementation RootViewController

DEF_SINGLETON(RootViewController)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)openURL:(NSString *)htmlurl//广告选择
{
    NSLog(@"%s %@",__func__,htmlurl);
    if (htmlurl && htmlurl.length) {
        NSURL * url = [NSURL URLWithString:htmlurl];
        WebViewController *ctr = [[WebViewController alloc] initWithURL:url];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"金项恋";
    self.yahooEngine = [[YahooEngine alloc] initWithHostName:@"download.finance.yahoo.com"];
    [self.yahooEngine useCache];
    
//    UIImage * menuimg = [UIImage imageNamed:@"menu"];
//    menuimg = [menuimg imageWithTintColor:[UIColor whiteColor]];
//    [self setleftBarButtonItemWithImage:menuimg target:self selector:@selector(showLeftViewController)];
//     menuimg = [UIImage imageNamed:@"profile"];
//    menuimg = [menuimg imageWithTintColor:[UIColor whiteColor]];
//    [self setrightBarButtonItemWithImage:menuimg target:self selector:@selector(showRightViewController)];
    
//    UIButton * button = [ToolsFunc CreateButtonWithFrame:CGRectMake(10, 100, 100, 50) andTxt:@"测试接口" txtcolor:[UIColor whiteColor] tag:10 target:self action:@selector(buttonTap:)];
//    [self.view addSubview:button];
    
    self.httpsTestsEngine = [HTTPSEngine sharedInstance];
    if ([self firstpagectr]) {
        [self transitionToViewController:self.firstpagectr duration:0.5];
    }
    self.currentctrview.frame = CGRectMake(0, 0, self.view.width, self.view.height - HEIGHT_TABBAR);
    [self.view addSubview:self.tabViewSocial];
    
//    [[HTTPSEngine sharedInstance] sendMessageWithPhone:@"15920549038" response:^(NSDictionary *Dictionary) {
//        NSLog(@"%@",Dictionary);
//    } errorHandler:^(NSError *error) {
//    }];
//    [[HTTPSEngine sharedInstance] fetch_loginMemberWithPhone:@"15920549038" email:nil password:@"123456" response:^(NSDictionary *Dictionary) {
//        
//    } errorHandler:^(NSError *error) {
//        
//    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.currentctrview == self.projectctr.view || self.currentctrview == self.newsctr.view) {
        self.statusBarStyleDefault = YES;
    }
    else self.statusBarStyleDefault = NO;
    [super viewWillAppear:animated];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    
//}
-(IBAction)buttonTap:(id)sender
{
//    [self.httpsTestsEngine serverTrustTest];
    [self.httpsTestsEngine fetch_regMember:@"15920549037"  response:^(NSDictionary *Dictionary) {
        NSLog(@"%@",Dictionary);
    } errorHandler:^(NSError *error) {
        
    }];
}

-(void)showRightViewController
{
    HSideViewController *sideViewController=[ApplicationDelegate sideViewController];
    [sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        //使用简单的平移动画
        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
    [sideViewController showRightViewController:true];
}


-(A0_FirstPageViewController *)firstpagectr
{
    if (!_firstpagectr) {
        _firstpagectr = [[A0_FirstPageViewController alloc] init];
        _firstpagectr.delegate = self;
    }
    return _firstpagectr;
}

-(B0_NewsViewController *)newsctr
{
    if (!_newsctr) {
        _newsctr = [[B0_NewsViewController alloc] init];
        _newsctr.basedelegate = self;
        _newsctr.showBackItem = NO;
    }
    return _newsctr;
}


-(OnlinePlayViewController *)onlinectr
{
    if (!_onlinectr) {
        _onlinectr = [[OnlinePlayViewController alloc] init];
        _onlinectr.basedelegate = self;
    }
    return _onlinectr;
}

-(C0_ProjectViewController *)projectctr
{
    if (!_projectctr) {
        _projectctr = [[C0_ProjectViewController alloc] init];
        _projectctr.basedelegate = self;
        _projectctr.showBackItem = NO;
    }
    return _projectctr;
}

-(D0_MineViewController *)minectr
{
    if (!_minectr) {
        _minectr = [[D0_MineViewController alloc] init];
    }
    return _minectr;
}

-(void)showLeftViewController
{
    HSideViewController *sideViewController=[ApplicationDelegate sideViewController];
    [sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        //使用简单的平移动画
        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
    [sideViewController showLeftViewController:true];
}

-(void)TabSelectAtIndex:(int)index
{
     [self setnavigationWithBarBackgroundColor:JXL_COLOR_THEME];
    switch (index) {
        case 0:
        {
            [self transitionToViewController:self.firstpagectr duration:0.5];
            break;
        }
        case 1:
        {
            [self transitionToViewController:self.newsctr duration:0.5];
            break;
        }
//        case 2:
//        {
//            [self transitionToViewController:self.onlinectr duration:0.5];
//            break;
//        }
        case 2:
        {
            [self transitionToViewController:self.projectctr duration:0.5];
            break;
        }
        case 3:
        {
            [self transitionToViewController:self.minectr duration:0.5];
            break;
        }
        default:
            break;
    }
}


-(void)transitionToViewController:(UIViewController *)ctr duration:(CGFloat)duration
{
    [self.currentctrview removeFromSuperview];
    self.currentctrview = ctr.view;
    [self.view  insertSubview:self.currentctrview belowSubview:self.tabViewSocial];
    [self.view transitionFade];
}

#pragma mark - a0firstpageviewcontroller delegate

-(void)A0_FirstPageViewController:(A0_FirstPageViewController *)A0_FirstPageViewController left:(BOOL)left navigationItem:(id)sender
{
    if (left) {
        [self showLeftViewController];
    }
    else
    {
        [self showRightViewController];
    }
}

-(void)A0_FirstPageViewController:(A0_FirstPageViewController *)A0_FirstPageViewController pushviewcontroller:(UIViewController *)viewcontroller
{
    [self rootpushviewcontroller:viewcontroller animated:YES];
}

#pragma mark - BaseViewController delegate

-(void)BaseViewController:(BaseViewController *)ViewController left:(BOOL)left navigationItem:(id)sender
{
    if (left == YES && ViewController == self.newsctr) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)rootpresentLoginViewController
{
    D1_LoginViewController  * ctr = [[D1_LoginViewController alloc] initWithNibName:@"D1_LoginViewController" bundle:nil];
     UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ctr];
    navigationController.navigationBarHidden = YES;
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}


-(void)rootRegisterView1Controller
{
    D1_RegisterView1Controller  * ctr = [[D1_RegisterView1Controller alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ctr];
    navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:navigationController animated:YES];
}

-(void)rootpushviewcontroller:(UIViewController *)ctr animated:(BOOL)anmimated
{
    [self.navigationController pushViewController:ctr animated:anmimated];
}

-(void)rootpresentViewController:(UIViewController *)ctr animated:(BOOL)animated completion:(void (^)(void))completion
{
    [self presentViewController:ctr animated:animated completion:completion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
