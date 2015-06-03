//
//  A0_HotProjectCell.m
//  JXL
//
//  Created by BooB on 15/5/12.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A0_HotProjectCell.h"
#import "NSString+HBExtension.h"
#import "UIImageView+WebCache.h"
#import "JXL_Define.h"
@implementation A0_HotProjectCell

- (void)awakeFromNib {
    // Initialization code
    self.lbl_state.backgroundColor = KT_UIColorWithRGB(148, 194, 28);
    self.lbl_type.backgroundColor = KT_UIColorWithRGB(15, 112, 196);    
}

-(void)setcellTitle:(NSString *)title
{
    if (title) {
        self.lbl_title.text = title;
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


-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    [super setcelldictionary:dictionary];
    
    NSString * type = [dictionary objectForKey:key_a0_hotprojectcell_type];
    NSString * location = [dictionary objectForKey:key_a0_hotprojectcell_location];
    NSString * state = [dictionary objectForKey:key_a0_hotprojectcell_state];
    
    if (type) {
        self.lbl_type.text = type;
    }
    self.lbl_state.text = state;
    self.lbl_location.text = location;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
