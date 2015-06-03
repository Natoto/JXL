//
//  D0_MineProfileTableViewCell.m
//  JXL
//
//  Created by 跑酷 on 15/5/12.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D0_MineProfileTableViewCell.h"
#import "NSString+HBExtension.h"
#import "UIImageView+WebCache.h"
#import "JXL_Define.h"
@implementation D0_MineProfileTableViewCell

- (void)awakeFromNib {
    // Initialization code
    KT_CORNER_PROFILE(self.img_profile)
    KT_CORNER_RADIUS(self.btn_chongzhi, 10);
}

-(void)setcellTitle:(NSString *)title
{
    self.lbl_name.text = title;
}

-(void)setcelldetailtitle:(NSString *)detailtitle
{
    if (detailtitle) {
        [self.btn_type setTitle:detailtitle forState:UIControlStateNormal];
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
