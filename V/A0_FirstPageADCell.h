//
//  FacialChangeImagesCell.h
//  pengmi
//
//  Created by 星盛 on 15/2/10.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdScrollView.h"
#import "BaseTableViewCell.h"

@protocol A0_FirstPageADCellDelegate;

@interface A0_FirstPageADCell : BaseTableViewCell<AdScrollViewDelegate>
@property (strong, nonatomic) AdScrollView *ScrollView;
//@property (nonatomic,assign) id <A0_FirstPageADCellDelegate> delegate;
+(CGFloat)heightOfCell;
@end


@protocol A0_FirstPageADCellDelegate <NSObject>

-(void)A0_FirstPageADCell:(A0_FirstPageADCell *)A0_FirstPageADCell AdScrollView:(AdScrollView *)AdScrollView selectIndex:(NSInteger)index;

@end