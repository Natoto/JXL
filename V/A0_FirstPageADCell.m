//
//  FacialChangeImagesCell.m
//  pengmi
//
//  Created by 星盛 on 15/2/10.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "A0_FirstPageADCell.h"
#import "HBSignalBus.h"

@implementation A0_FirstPageADCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setcellProfile:(NSString *)profile{}
-(void)setcellTitle:(NSString *)title{}
-(void)setcelldetailtitle:(NSString *)detailtitle{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)heightOfCell
{
    return 140.0;
}
-(AdScrollView *)ScrollView
{
    if (!_ScrollView) {
         _ScrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [A0_FirstPageADCell heightOfCell])];
        _ScrollView.ad_delgate = self;
         [self.contentView addSubview:_ScrollView];
    }
    return _ScrollView;
}

-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    if (!dictionary) {
        return;
    }
    [super setcelldictionary:dictionary];
    self.contentView.backgroundColor = [UIColor grayColor];
    NSArray * headerimageNameArray = [dictionary objectForKey:@"headerimageNameArray"];
    NSArray * headerTitleNameArray = [dictionary objectForKey:@"headerTitleNameArray"];
    if (self.ScrollView) {
        
    }
//    self.ScrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.ScrollView.imageNameArray = headerimageNameArray;
    self.ScrollView.PageControlShowStyle = UIPageControlShowStyleNone;
    self.ScrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.ScrollView setAdTitleArray:headerTitleNameArray withShowStyle:AdTitleShowStyleLeft];
    
    self.ScrollView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
//    [NSMutableDictionary dictionaryWithObjectsAndKeys:headerimageNameArray,@"headerimageNameArray",headerTitleNameArray,@"headerTitleNameArray",  nil];
}
-(void)AdScrollView:(AdScrollView *)AdScrollView selectIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPageADCell:AdScrollView:selectIndex:)]) {
        [self.delegate A0_FirstPageADCell:self AdScrollView:AdScrollView selectIndex:index];
    }
//    SEND_HBSIGNAL(@"AdScrollView", @"selectIndex", [NSNumber numberWithInteger:index])
}

@end
