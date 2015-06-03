//
//  ADScrollViewCell.m
//  JXL
//
//  Created by BooB on 15-4-16.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "BubbleLayout.h"
#import "ADScrollViewCell.h"

@implementation ADScrollViewCell


-(UIScrollView *)ScrollView
{
    if (!_ScrollView) {
        _ScrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [ADScrollViewCell heightOfCell])];
        [self.contentView addSubview:_ScrollView];
    }
    return _ScrollView;
}

+(CGFloat)heightOfCell
{
    return ITEM_HEIGHT;
}

-(void)dataChange:(NSMutableDictionary *)dictionary
{
    if (!dictionary) {
        return;
    }
    self.contentView.backgroundColor = [UIColor grayColor];
    NSArray * headerimageNameArray = [dictionary objectForKey:@"headerimageNameArray"];
    NSArray * headerTitleNameArray = [dictionary objectForKey:@"headerTitleNameArray"];
    if (self.ScrollView && headerimageNameArray.count && headerTitleNameArray.count) {
        self.ScrollView.imageNameArray = headerimageNameArray;
        self.ScrollView.PageControlShowStyle = UIPageControlShowStyleNone;
        self.ScrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self.ScrollView setAdTitleArray:headerTitleNameArray withShowStyle:AdTitleShowStyleLeft];
        self.ScrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        self.ScrollView.ad_delgate = self;
    }
    //    self.ScrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
}

-(void)AdScrollView:(AdScrollView *)AdScrollView selectIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ADScrollViewCell:AdScrollView:selectIndex:)]) {
        [self.delegate ADScrollViewCell:self AdScrollView:AdScrollView selectIndex:index];
    }    
}
- (void)awakeFromNib {
    // Initialization code
}

@end
