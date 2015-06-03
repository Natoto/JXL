//
//  BaseViewController.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "HBSignalBus.h"
#import "BaseViewController.h"
#import "MJRefresh.h"
#import "UIViewController+TopBarMessage.h"
#import "UIImage+Tint.h"
#import "NSObject+HBHUD.h"

@class HTTPSEngine;
@implementation BackGroundView
-(void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self.image drawInRect:CGRectMake(0, -10, rect.size.width, rect.size.height + 10)];
    // Drawing code
}
@end



@implementation BaseViewController

-(void)dealloc
{
    REMOVE_HBSIGNAL_OBSERVER(self, @"networkerror", @"HTTPSEngile")
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    
    self.view.backgroundColor = JXL_COLOR_THEME;// [UIColor grayColor];
    self.navigationItem.backBarButtonItem= [[UIBarButtonItem alloc]initWithTitle:@""
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil
                                                                          action:nil];
    
    ADD_HBSIGNAL_OBSERVER(self, @"networkerror", @"HTTPSEngine");
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//     if (self.statusBarStyleDefault) {
//         return UIStatusBarStyleDefault;
//     }
//    else
//        return UIStatusBarStyleLightContent;
//}
//
//-(void)setStatusBarStyleDefault:(BOOL)statusBarStyleDefault
//{
//    _statusBarStyleDefault = statusBarStyleDefault; 
//}

//static UIStatusBarStyle barstyle;

-(void)setStatusBarStyleDefault:(BOOL)statusBarStyleDefault
{
    _statusBarStyleDefault = statusBarStyleDefault;
    if (self.statusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewWillAppear:(BOOL)animated
{
}
 
-(void)viewDidDisappear:(BOOL)animated
{
//    [[UIApplication sharedApplication] setStatusBarStyle:barstyle];
}

ON_HBSIGNAL(HTTPSEngine, networkerror, notify)
{
    NSString * errormsg = notify.object;
    [self dismissAllTips];
    [self presentMessageTips_:errormsg];
}

-(void)changeFaceStyle:(int)style view:(UIView *)View
{
    
}

-(void)userDefaultBackground
{
    [self changeBackGroundWithBackColor:JXL_COLOR_THEME];
//    [self changeBackGroundWithBackimg:@"backgroundimage@2x" ofType:@"png"];
}

-(void)changeBackGroundWithBackImage:(UIImage *)Image
{
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];//
    if (!imageview) {
        imageview = [[UIImageView alloc] initWithImage:Image];
        imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
        [self.view addSubview:imageview];
        imageview.tag = 2222;
        [self.view sendSubviewToBack:imageview];
    }
    imageview.image = Image;
}

-(void)changeBackGroundWithBackColor:(UIColor *)color
{
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];
    if (!imageview) {
        imageview = [[UIImageView alloc] init];
        imageview.tag = 2222;
        [self.view addSubview:imageview];
    }
    imageview.backgroundColor = color;
    imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
    [self.view sendSubviewToBack:imageview];
}

-(void)changeBackGroundWithBackimg:(NSString *)imgname ofType:(NSString *)type
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imgname ofType:type];
    
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];
    if (!imageview) {
        imageview = [[UIImageView alloc] initWithImage:img];
        imageview.tag = 2222;
        [self.view addSubview:imageview];
    }
    imageview.image = img;
    imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
    [self.view sendSubviewToBack:imageview];
}
-(void)changeBackGroundWithBackimg:(NSString *)imgname
{
    [self changeBackGroundWithBackimg:imgname ofType:@"png"];
}


-(void)showhbnavigationbarBackItem:(BOOL)show
{
    [self.navigationbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"white_back_btn"] target:self selector:@selector(backtoparent:)];
}

-(IBAction)backtoparent:(id)sender
{
    if ((self.navigationController.childViewControllers.count > 1) && self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.presentingViewController || self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


-(void)observeTapgestureWithSuperView:(UIView *)superview target:(id)target sel:(SEL)seletor
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:seletor];
    [superview addGestureRecognizer:tap];
}


/**
 * 设置navigationbar的状态
 */

-(void)setnavigationWithBarBackgroundImage:(CGFloat)alpha
{
    if (alpha) {
        UIImage * bgimage = [UIImage imageNamed:@"navigationbar.jpg"];
        bgimage = [bgimage imageWithTintColor:[UIColor colorWithWhite:0 alpha:alpha]];
        [self.navigationController.navigationBar setBackgroundImage:bgimage
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(void)setnavigationWithBarBackgroundColor:(UIColor *)color
{
    if (color) {
        UIImage * bgimage = [UIImage imageNamed:@"navigationbar.jpg"];
        bgimage = [bgimage imageWithTintColor:color]; 
        [self.navigationController.navigationBar setBackgroundImage:bgimage
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


-(HBNavigationbar *)navigationtoolsbar
{
    if (!_navigationtoolsbar) {
        _navigationtoolsbar = [HBNavigationbar navigationtoolbar];
        [self.view addSubview:_navigationtoolsbar];
    }
    return _navigationtoolsbar;
}

-(HBNavigationbar *)navigationbar
{
    if (!_navigationbar) {
       _navigationbar = [HBNavigationbar navigationbar];
        [self.view addSubview:_navigationbar];
    }
    return _navigationbar;
}


-(BackGroundView *)backgroundview
{
    if (!_backgroundview) {
        BackGroundView * backgroundview =  [[BackGroundView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundview = backgroundview;
    }
    return _backgroundview;
}
-(void)selectCurrentView{};


@end
