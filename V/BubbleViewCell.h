//
//  BubbleViewCell.h
//  pengmi
//
//  Created by 星盛 on 15/2/9.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleViewCell : UICollectionViewCell
@property(nonatomic,assign) BOOL isselected;
-(void)dataChange:(id)object;

-(void)selectBubbleCell:(BOOL)select;
@end
