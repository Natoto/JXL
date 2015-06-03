//
//  A0_FirstPageViewController.m
//  JXL
//
//  Created by BooB on 15-4-14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A0_FirstPageViewController2.h"
#import "BubbleLayout.h"
#import "BubbleViewCell.h"
#import "JXL_Define.h"
#import "QCSlideSwitchView.h"
#import "MJRefresh.h"
#import "HBSignalBus.h"
#import "NSObject+HBHUD.h"
#import "BubbleStruct.h"
#import "ADScrollViewCell.h"
#import "HBNavigationbar.h"
#import "UIImage+Tint.h"
#import "RootViewController.h" 
#import "B0_NewsViewController.h"
#import "C0_ProjectViewController.h"
#import "A1_ActivityViewController.h"
#import "BaseJXLViewController.h"
#import "HTTPSEngine.h"
#import "AdvertiseList.h"
#import "WebViewController.h"
#import "WebViewController.h"

@interface A0_FirstPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,AdScrollViewCellDelegate>

@property (nonatomic,strong) UICollectionView   * collectionView;
@property(nonatomic,strong) NSMutableArray      * topicArray;
@property(nonatomic,strong) NSString            * defaultTips;

@property(nonatomic,strong) NSMutableArray      * advertiseList;

@end

@implementation A0_FirstPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //使用默认背景图
    [self userDefaultBackground];
     
    HBNavigationbar * navigationbar = [HBNavigationbar navigationbar];
    navigationbar.title = @"金项恋";
    navigationbar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navigationbar];
    
    UIImage * menuimg = [UIImage imageNamed:@"menu"];
    menuimg = [menuimg imageWithTintColor:[UIColor whiteColor]];
    [navigationbar setleftBarButtonItemWithImage:menuimg target:self selector:@selector(showLeftViewController)];
    menuimg = [UIImage imageNamed:@"profile"];
    menuimg = [menuimg imageWithTintColor:[UIColor whiteColor]];
    [navigationbar setrightBarButtonItemWithImage:menuimg target:self selector:@selector(showRightViewController)];
    
    
    
     self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    BubbleLayout* flowLayout = [[BubbleLayout alloc]init];
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect rect =CGRectMake(0, CGRectGetMaxY(navigationbar.frame), CGRectGetWidth(bounds), CGRectGetHeight(bounds) - HEIGHT_TABBAR - HEIGHT_NAVIGATIONBAR);// - bee.ui.tabbar.height
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    //解决一直下拉不动的问题
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[BubbleViewCell class] forCellWithReuseIdentifier:@"BubbleViewCell"];
    [self.collectionView registerClass:[ADScrollViewCell class] forCellWithReuseIdentifier:@"ADScrollViewCell"];
    NSLog(@"%@",[ADScrollViewCell class]);
    
    self.collectionView.backgroundColor =[UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    NSArray * titleary = [NSArray arrayWithObjects:@"第一页",@"新闻中心",@"项目中心",@"活动",@"赛事直播",@"参赛报名",@"设置", nil];
    NSArray * imgarray = [NSArray arrayWithObjects:@"root_page_1",@"root_news",@"root_xiangmu",@"root_huodong",@"root_saishi",@"root_cansai",@"root_shezhi", nil];
    
    self.topicArray = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger index=0; index < imgarray.count; index ++) {
        BubbleStruct *abs=[[BubbleStruct alloc] initWithid:[NSNumber numberWithInteger:index] m_image:[imgarray objectAtIndex:index] m_title:[titleary objectAtIndex:index] m_money:@0];
        
        [self.topicArray addObject:abs];
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [[HTTPSEngine sharedInstance] fetch_advertiseListWithType:@"4" catid:nil response:^(NSDictionary *Dictionary) {
     
        if (Dictionary) {
            NSLog(@"首页广告：%@",Dictionary);
            NSArray * array = [AdvertiseListModel encodeDiction:Dictionary];
            self.advertiseList = [NSMutableArray arrayWithArray:array];
            [self.collectionView reloadData];
        }
    } errorHandler:^(NSError *error) {
        
    }];
} 
-(IBAction)showLeftViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPageViewController:left:navigationItem:)]) {
        [self.delegate A0_FirstPageViewController:self left:YES navigationItem:nil];
    }
    NSLog(@"%s",__func__);
}

-(void)showRightViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPageViewController:left:navigationItem:)]) {
        [self.delegate A0_FirstPageViewController:self left:NO navigationItem:nil];
    }
      NSLog(@"%s",__func__);
}
-(NSString *)defaultTips
{
    if (!_defaultTips) {
        _defaultTips =  @"亲,暂时任何气泡";
    }
    return _defaultTips;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidCurrentView
{
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.topicArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
    
        static NSString* identifier = @"ADScrollViewCell";
        UINib *nib = [UINib nibWithNibName:@"ADScrollViewCell"
                                    bundle: [NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:@"ADScrollViewCell"];
        
        ADScrollViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath]; 
//        [cell layoutSubviews];
        cell.delegate = self;
        NSMutableArray * headerimageNameArray = [NSMutableArray arrayWithCapacity:0];// @[@"root_page_1"];
        NSMutableArray * headerTitleNameArray = [NSMutableArray arrayWithCapacity:0];//@[@"首页"];
        if (self.advertiseList.count) {
            [self.advertiseList enumerateObjectsUsingBlock:^(AdvertiseList * obj, NSUInteger idx, BOOL *stop) {
                [headerimageNameArray addObject:obj.m_thumb];
                [headerTitleNameArray addObject:obj.m_title];
                
            }];
        }
        
        NSMutableDictionary * dictionary =[NSMutableDictionary dictionaryWithObjectsAndKeys:headerimageNameArray,@"headerimageNameArray",headerTitleNameArray,@"headerTitleNameArray",  nil];
        [cell dataChange:dictionary];
        return cell;
    }
    else
    {
        static NSString* identifier = @"BubbleViewCell";
        UINib *nib = [UINib nibWithNibName:@"BubbleViewCell"
                                    bundle: [NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:@"BubbleViewCell"];
        BubbleViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        [cell layoutSubviews];
        BubbleStruct * bs=[self.topicArray objectAtIndex:indexPath.row];
        [cell dataChange:bs];
        return cell;
    }
}


#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {//顶部不算
        return;
    }
    //触发点击cell事件
    NSLog(@"选择 %d",indexPath.row);
    BubbleViewCell * cell =(BubbleViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell selectBubbleCell:!cell.isselected];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPageViewController:pushviewcontroller:)]) {
        BaseViewController * ctr;
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
            {
                ctr = [[B0_NewsViewController alloc] init];
                break;
            }
            case 2:
                ctr = [[C0_ProjectViewController alloc] init];
                break;
            case 3:
                ctr = [[A1_ActivityViewController alloc] init];
                break;
            case 4:
                
            default:
                ctr = [[BaseJXLViewController alloc] init];
                break;
        }
        [self.delegate A0_FirstPageViewController:self pushviewcontroller:ctr];
    }
}

-(void)ADScrollViewCell:(ADScrollViewCell *)ADScrollViewCell AdScrollView:(AdScrollView *)AdScrollView selectIndex:(NSInteger)index
{   
    AdvertiseList * advertist = [self.advertiseList objectAtIndex:index];
    NSLog(@"%@",advertist);
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPageViewController:pushviewcontroller:)]) {
//        WebViewController * ctr = [[WebViewController alloc] init];
//        ctr.url = advertist.m_url;
        NSURL * url = [NSURL URLWithString:advertist.m_url];
        WebViewController *ctr = [[WebViewController alloc] initWithURL:url];
       [self.delegate A0_FirstPageViewController:self pushviewcontroller:ctr];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {//顶部不算
        return;
    }
    NSLog(@"取消选择 %d",indexPath.row);
    BubbleViewCell * cell =(BubbleViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell selectBubbleCell:NO];
}
@end
