//
//  GuidanceViewController.m
//  pengmi
//
//  Created by wei on 15/1/26.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "GuidanceViewController.h"
#import "QCSlideSwitchView.h"
#import "HBSignalBus.h"
#import "HBSignalBus.h"
#import "UIImage+HBExtension.h"
#import "GuidancePage1ViewController.h"
#import "GuidancePage2ViewController.h"
@interface GuidanceViewController ()<QCSlideSwitchViewDelegate>
@property(nonatomic,strong) NSMutableArray * mMutableArray;
@property(nonatomic,strong) NSMutableArray * mMutableArray1;
@property(nonatomic,strong) UIView * mCurrentView;
@property(nonatomic,assign) BOOL isMan;
@property NSInteger mActherIndex;
@end

@implementation GuidanceViewController


-(void)changeFaceStyle:(int)style view:(UIView *)view
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.mMutableArray = [[NSMutableArray alloc] init];
    self.mMutableArray1 = [[NSMutableArray alloc] init];
    self.isMan = true;
    self.mActherIndex = 1;
    [self gotoFirst];
    
    [self changeBackGroundWithBackimg:@"xuexiaobeijingdatu@2x"];
    
}
#pragma mark - 介绍页面
//观光页

-(GuidancePage1ViewController *)firstPage
{
    GuidancePage1ViewController * ctr = [[GuidancePage1ViewController alloc] initWithNibName:@"GuidancePage1ViewController" bundle:nil];
    return ctr;
}

- (void)gotoFirst
{
    [self deleteCurrentView];
    self.mCurrentView = [[UIView alloc] initWithFrame:CGRectMake(0, -30, CGRectGetWidth([UIScreen mainScreen].bounds) ,  CGRectGetHeight([UIScreen mainScreen].bounds) + 30)];
    QCSlideSwitchView * slideSwitchView = [[QCSlideSwitchView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.mCurrentView.frame) , CGRectGetHeight(self.mCurrentView.frame))];
    [self.mCurrentView addSubview:slideSwitchView];
    slideSwitchView.backgroundColor = [UIColor clearColor];
    slideSwitchView.slideSwitchViewDelegate = self;
    for (int i = 0; i < 3; i++) {
        //
        if (i == 0) {
            
            UIViewController * vc = [self firstPage];
            [self.mMutableArray addObject:vc];
            [self addPageController:i];
            continue;
        }
        if ( i == 1) {
            GuidancePage2ViewController * ctr = [[GuidancePage2ViewController alloc] init];
            [self.mMutableArray addObject:ctr];
            [self addPageController:i];
            continue;
        }
        
        BaseViewController * vc = [[BaseViewController alloc] init];
        vc.view.backgroundColor = KT_UIColorWithRGB(126, 205, 244);;//[UIColor clearColor];//KT_UIColorWithRGB(71, 64, 61);
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"Default"]]];
        [imageView setFrame:CGRectMake(0, - 50, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)];
        imageView.contentMode =  UIViewContentModeScaleToFill;
        [vc.view addSubview:imageView];
        
        if (i == 2) {
            UIButton * button0 = [self CreateButtonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, [UIScreen mainScreen].bounds.size.height - 180, 150, 40) Title:@"登录" color:KT_UIColorWithRGB(22, 168, 233) selector:@selector(startUserJXL:)];
            button0.tag = TAG_QC_BUTTON_START;
            button0.centerX = UISCREEN_WIDTH/2;
            [vc.view addSubview:button0];
            
            UIButton * button1 = [self CreateButtonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, [UIScreen mainScreen].bounds.size.height - 130, 150, 40) Title:@"注册" color:KT_UIColorWithRGB(22, 168, 233) selector:@selector(startUserJXL:)];
            button1.tag = 1 + TAG_QC_BUTTON_START;
            button1.centerX = UISCREEN_WIDTH/2;
            [vc.view addSubview:button1];
            
            UIButton * button = [self CreateButtonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 50, [UIScreen mainScreen].bounds.size.height - 80, 100, 50) Title:@"立即体验" color:[UIColor clearColor] selector:@selector(startUserJXL:)];
            button.tag =TAG_QC_BUTTON_START + 2;
            button.centerX = UISCREEN_WIDTH/2;
            [vc.view addSubview:button];
        }
        [self.mMutableArray addObject:vc];
        //
        [self addPageController:i];
    }
    [slideSwitchView buildUI];
    [self setSelectItem:0];
     
    [self.view addSubview:self.mCurrentView];
    
}

-(void)addPageController:(NSInteger)i
{
    UIImageView * imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit_select_off"] highlightedImage:[UIImage imageNamed:@"edit_select_on1"]];
    [self.mMutableArray1 addObject:imageView1];
    [imageView1 setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 + (-3/2 + i)*20, [UIScreen mainScreen].bounds.size.height - 10, 8, 8)];
    [imageView1 setHighlighted:true];
    [self.mCurrentView addSubview:imageView1];
}

-(UIButton *)CreateButtonWithFrame:(CGRect)frame Title:(NSString *)Title color:(UIColor *)color selector:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:Title forState:UIControlStateNormal];
    button.layer.cornerRadius = [self cornerRadius];
    //绘制纯色的图 并带圆角的
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    UIImage * normalimg = [UIImage buttonImageFromColor:color frame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    normalimg = [UIImage createRoundedRectImage:normalimg size:frame.size radius:5];
    [button setBackgroundImage:normalimg forState:UIControlStateNormal];
    
    UIImage * highligntimg = [UIImage buttonImageFromColor:[UIColor grayColor] frame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    highligntimg = [UIImage createRoundedRectImage:highligntimg size:frame.size radius:5];
    [button setBackgroundImage:highligntimg forState:UIControlStateHighlighted];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}
#pragma mark - 选择性别
#define TAG_QINGXIANG_START 10

-(UIColor *)green_button_0Color
{
    return KT_UIColorWithRGB(109, 190, 253);
}

-(UIColor *)white_button_1Color
{
    return KT_UIColorWithRGB(219, 216, 215);
}

-(NSInteger)cornerRadius
{
    return 5;
}



//清除
- (void)deleteCurrentView
{
    if(self.mCurrentView){
        [self.mCurrentView removeFromSuperview];
    }
}
//跳过
- (void)startUserJXL:(id)sander
{
    UIButton * button = (UIButton *)sander;
    
    self.mActherIndex = button.tag - TAG_QC_BUTTON_START ;
    
     [self deleteCurrentView];  
    if (self.delegate && [self.delegate respondsToSelector:@selector(GuidanceViewController:selectButtonTag:dismissblock:)]) {
   
        [self.delegate GuidanceViewController:self selectButtonTag:self.mActherIndex dismissblock:nil];
    }

}



#pragma mark - QCSlideSwitchView delegate
- (void)setSelectItem:(NSUInteger)index
{
    for(int i = 0;i < self.mMutableArray1.count;i++)
    {
        UIImageView * imageView = [self.mMutableArray1 objectAtIndex:i];
        if(i == index){
            [imageView setHighlighted:true];
        }else{
            [imageView setHighlighted:false];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return [self.mMutableArray count];
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return [self.mMutableArray objectAtIndex:number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    [self setSelectItem:number];
    BaseViewController * ctr = [self.mMutableArray objectAtIndex:number];
    [ctr selectCurrentView];
}

@end
