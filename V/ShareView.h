//
//  ShareView.h
//  pengmi
//
//  Created by wei on 15/1/29.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

-(void)setImage:(UIImage*)image content:(NSString*)content fontIndex:(NSUInteger)fontIndex;
@end
