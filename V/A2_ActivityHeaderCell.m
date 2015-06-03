//
//  D2_ActivityHeaderCell.m
//  JXL
//
//  Created by 跑酷 on 15/5/21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A2_ActivityHeaderCell.h"
#import "ActivityModel.h"
#import "NSString+Reg.h"
#import "UIImageView+WebCache.h"
#import "NSString+HBExtension.h"
@implementation A2_ActivityHeaderCell

- (void)awakeFromNib {
    self.btn_location.titleLabel.numberOfLines = 3;
    self.btn_location.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    // Initialization code
}

-(void)setcellTitle:(NSString *)title{}
-(void)setcellProfile:(NSString *)profile{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setcellobject:(id)object
{
    if (object) {
        activitylist * atl = (activitylist *)object;
        self.lbl_title.text = atl.title;
        self.lbl_attentnumber.text = [NSString stringWithFormat:@"已有%@人报名",atl.sigNum];
        [self.btn_location setTitle:[NSString stringWithFormat:@" %@ %@ %@ %@",atl.province,atl.city,atl.area,atl.address] forState:UIControlStateNormal];
        [self.btn_time setTitle:[NSString stringWithFormat:@" %@至 %@",[atl.startDate getmmddmmssstring],[atl.startDate getmmddmmssstring]] forState:UIControlStateNormal];
        [self.btn_type setTitle:[NSString stringWithFormat:@" %@",[atl typeOfActivity]] forState:UIControlStateNormal];
        self.lbl_state.text = [atl statusOfActivity];
        
        if ([atl.thumb isUrl]) {
            [self.img_profile sd_setImageWithURL:[NSURL URLWithString:atl.thumb] placeholderImage:[UIImage imageNamed:@"default_activeslist_item@"] completed:nil];
        }
    }
}

- (IBAction)gotolocation:(id)sender {
    
}

@end
