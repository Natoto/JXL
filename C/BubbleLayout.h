//
//  BubbleLayout.h
//  pengmi
//
//  Created by 星盛 on 15/2/9.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ITEM_WIDTH ([UIScreen mainScreen].bounds.size.width/2 - 5 )
#define ITEM_HEIGHT 108
#define ITEM_SIZE 145
#define ITEM_JIANGE 5

@interface BubbleLayout : UICollectionViewLayout
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;
@end
