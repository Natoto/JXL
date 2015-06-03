//
//  A0_HotNewsCell.m
//  JXL
//
//  Created by BooB on 15/5/12.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A0_HotNewsCell.h"
#import "NSString+HBExtension.h"
#import "UIImageView+WebCache.h"
@implementation A0_HotNewsCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setcellTitle:(NSString *)title
{
    if (title) {
        self.lbl_title.text = title;
    }
}

-(void)setcelldetailtitle:(NSString *)detailtitle
{
    if (detailtitle) {
        self.lbl_detail.text = detailtitle;
    }
}

-(void)setcellProfile:(NSString *)profile
{
    if ([profile isUrl]) {//如果是网络图片 就加载网络图片
        [self.img_profile sd_setImageWithURL:[NSURL URLWithString:profile] placeholderImage:[UIImage imageNamed:@"defaultprofile"] options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        return;
    }
    self.img_profile.image = [UIImage imageNamed:profile];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
