//
//  SqureImageTitleView.h
//  JXL
//
//  Created by BooB on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SqureImageTitleView : UIControl
@property(strong,nonatomic) UIImageView * imageView;
@property(strong,nonatomic) UILabel    *  titleLabel;

-(void)dataChange:(NSString *)title imgurl:(NSString *)imgurl;

@end
