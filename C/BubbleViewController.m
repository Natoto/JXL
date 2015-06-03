//
//  BubbleViewController.m
//  pengmi
//
//  Created by 星盛 on 15/2/9.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "BubbleViewController.h"

#import "BubbleLayout.h"
#import "BubbleViewCell.h"
#import "JXL_Define.h"
#import "QCSlideSwitchView.h"
#import "MJRefresh.h"
#import "HBSignalBus.h"
#import "NSObject+HBHUD.h"
#import "BubbleStruct.h"


@interface BubbleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain) UIView * defaultBgView;
@property (nonatomic,strong) UICollectionView  * collectionView;
@property(nonatomic,strong) NSMutableArray * topicArray;
@property(nonatomic,strong) NSString * defaultTips;

@end

@implementation BubbleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self userDefaultBackground];
    BubbleLayout* flowLayout = [[BubbleLayout alloc]init];
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect rect =CGRectMake(0, 64, CGRectGetWidth(bounds), CGRectGetHeight(bounds) - 64.0);// - bee.ui.tabbar.height
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    //解决一直下拉不动的问题
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[BubbleViewCell class] forCellWithReuseIdentifier:@"BubbleViewCell"];
    self.collectionView.backgroundColor =[UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    /* 收费
    NSArray * imgarray = [NSArray arrayWithObjects:@"piaofufengzhengxuanchuan",@"jishiceziditu",@"haiyangbolangditu",@"piaofufengzhengditu", nil];
    NSArray * titleary = [NSArray arrayWithObjects:@"",@"免费",@"免费",@"免费", nil];*/
    //免费
    NSArray * imgarray = [NSArray arrayWithObjects:@"piaofufengzhengxuanchuan",@"jishiceziditu", nil];
    NSArray * titleary = [NSArray arrayWithObjects:@"",@"免费", nil];
    
    self.topicArray = [NSMutableArray arrayWithCapacity:0];
    
//    NSNumber * bubble = GET_OBJECT_OF_USERDEFAULT(KEY_BUBBLE_TYPE);
    for (NSInteger index=0; index < imgarray.count; index ++) {
        BubbleStruct *abs=[[BubbleStruct alloc] initWithid:[NSNumber numberWithInteger:index] m_image:[imgarray objectAtIndex:index] m_title:[titleary objectAtIndex:index] m_money:@0];
       
        [self.topicArray addObject:abs];
    }
//    [[HBSignalBus shareIntance] observerWithObject:self key:@"TopicSyncData" targetclass:SIGNAL_SENDER];
//    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    
}

-(UIView *)defaultBgView
{
    if (!_defaultBgView) {
        _defaultBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 150, 156)];
        imageview.image = [UIImage imageNamed:@"logo"];
        [_defaultBgView addSubview:imageview];
        [imageview setCenter:CGPointMake(CGRectGetWidth(_defaultBgView.frame)/2, CGRectGetHeight(_defaultBgView.frame)/2 - 150)];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame), CGRectGetWidth(_defaultBgView.frame), 30)];
        label.tag = 1927;
        label.text = self.defaultTips;//
        label.textAlignment = NSTextAlignmentCenter;
        [_defaultBgView addSubview:label];
    }
    UILabel * label = (UILabel *)[_defaultBgView viewWithTag:1927];
    label.text = self.defaultTips;
    return _defaultBgView;
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
    static NSString* identifier = @"BubbleViewCell";
    UINib *nib = [UINib nibWithNibName:@"BubbleViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"BubbleViewCell"];
    BubbleViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.row) {
        cell.layer.cornerRadius = 5;        
    }
    [cell layoutSubviews];
    BubbleStruct * bs=[self.topicArray objectAtIndex:indexPath.row];
    [cell dataChange:bs];
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {//顶部不算
        return;
    }
    //触发点击cell事件
    NSLog(@"选择 %ld",(long)indexPath.row);
    BubbleViewCell * cell =(BubbleViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell selectBubbleCell:!cell.isselected];
//    if (cell.isselected) {
//        SET_OBJECT_OF_USERDEFAULT([NSNumber numberWithInt:indexPath.row], KEY_BUBBLE_TYPE);
//        USERDEFAULT_SYNC
//    }
//    else
//    {
//        SET_OBJECT_OF_USERDEFAULT([NSNumber numberWithInt:0], KEY_BUBBLE_TYPE);
//        USERDEFAULT_SYNC
//    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {//顶部不算
        return;
    }
     NSLog(@"取消选择 %ld",(long)indexPath.row);
    BubbleViewCell * cell =(BubbleViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell selectBubbleCell:NO];
}

#pragma mark - UICollectionViewDelegateFlowLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    if (indexPath.row == 0) {
////        return CGSizeMake(300, 100);
////    }
////    else
////    {
//        CGFloat aFloat = 0.0;
//        float pcimgwidth = 50;
//        float cellwidth =  150; //[MypmlikeLayout cellwidth];
//        aFloat = cellwidth/pcimgwidth;//image.size.width;
//        float aheight = cellwidth;
//        
//        CGSize size = CGSizeMake(0,0);
//        size = CGSizeMake(cellwidth, aheight+1);
//        return size;
////    }
//}

@end
