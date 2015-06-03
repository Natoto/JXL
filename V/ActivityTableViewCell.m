//
//  NewsTableViewCell.m
//  JXL
//
//  Created by BooB on 15-4-19.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "ActivityModel.h"
#import "UIImageView+WebCache.h"
#import "ActivityTableViewCell.h"
#import "NSString+HBExtension.h"
#import "ToolsFunc.h"
#import "NSString+Reg.h"
@interface ActivityTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title; 
@property (weak, nonatomic) IBOutlet UILabel *lbl_location;
@property (weak, nonatomic) IBOutlet UIButton *btn_canyu;
@property (weak, nonatomic) IBOutlet UILabel *lbl_baomingnumber;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;

@end
@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)heightOfCell
{
    return 122.;
}
-(void)setcellTitle:(NSString *)title
{
    
}

-(void)setcellProfile:(NSString *)profile
{
    
}
//


-(void)setcellobject:(id)object
{
    activitylist * atl = (activitylist *)object;
    if (atl) {
        if ([atl.thumb isUrl]) {
            [self.img_profile sd_setImageWithURL:[NSURL URLWithString:atl.thumb] placeholderImage:[UIImage imageNamed:@"default_activeslist_item"] completed:nil];
        }
        self.lbl_title.text = atl.title;
        self.lbl_time.text =  [NSString stringWithFormat:@"%@至 %@",[atl.startDate getmmddstring],[atl.endDate getmmddstring]];
        self.lbl_baomingnumber.text = [NSString stringWithFormat:@"已有%@人报名",atl.sigNum];
        self.lbl_location.text = [NSString stringWithFormat:@"%@ ",atl.address];
        [self.btn_canyu setTitle:[atl statusOfActivity] forState:UIControlStateNormal];
    }
}
@end





