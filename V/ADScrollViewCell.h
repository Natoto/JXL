//
//  ADScrollViewCell.h
//  JXL
//
//  Created by BooB on 15-4-16.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdScrollView.h"
@protocol AdScrollViewCellDelegate;

@interface ADScrollViewCell : UICollectionViewCell<AdScrollViewDelegate>
@property (assign, nonatomic) id<AdScrollViewCellDelegate>  delegate;
@property (strong, nonatomic) AdScrollView *ScrollView;

-(void)dataChange:(NSMutableDictionary *)dictionary;

@end

@protocol AdScrollViewCellDelegate <NSObject>

-(void)ADScrollViewCell:(ADScrollViewCell *)ADScrollViewCell AdScrollView:(AdScrollView *)AdScrollView selectIndex:(NSInteger)index;

@end