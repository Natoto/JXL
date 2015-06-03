//
//  D1_AboutUSHeaderCell.m
//  JXL
//
//  Created by 跑酷 on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_AboutUSHeaderCell.h"

@implementation D1_AboutUSHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setcellTitle:(NSString *)title
{
    if (title.length) {
        self.lbl_title.text = title;
    }
}

-(void)setcelldetailtitle:(NSString *)detailtitle
{
    if (detailtitle.length) {
        self.lbl_detail.text = detailtitle;
    }
}

-(void)setcellProfile:(NSString *)profile
{
    
    if (profile.length) {
        [self.img_profile setImage:[UIImage imageNamed:profile]];
    }
    
}


@end
