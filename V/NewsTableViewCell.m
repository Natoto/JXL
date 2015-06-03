//
//  NewsTableViewCell.m
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"
#import "NSString+HBExtension.h"
#import "JXL_Define.h"
@interface NewsTableViewCell()
//新闻模块
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;
@property (weak, nonatomic) IBOutlet UIButton *btn_comment;
//项目模块需要
@property (strong, nonatomic) UILabel * lbl_location;
@property (strong, nonatomic) UILabel * lbl_state;
@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)heightOfCell
{
    return 80;
}
 
-(void)setcellTitle:(NSString *)title
{
    
}

-(void)setcellProfile:(NSString *)profile
{ 
    
}

-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    [super setcelldictionary:dictionary];
    
    self.lbl_title.textColor = KT_UIColorWithRGB(0, 55, 104);
    
    self.lbl_title.text = [dictionary objectForKey:key_newstableviewcell_title];
    
    NSString * zanstr = [NSString stringWithFormat:@" %@",[dictionary objectForKey:key_newstableviewcell_dianzan]];
    [self.btn_zan setTitle:zanstr forState:UIControlStateNormal];
    
    NSString * viewstr = [NSString stringWithFormat:@" %@",[dictionary objectForKey:key_newstableviewcell_views]];
    [self.btn_comment setTitle:viewstr forState:UIControlStateNormal];
    
    NSString * profile = [dictionary objectForKey:key_newstableviewcell_photo];
    if ( profile &&  [profile isUrl]) {
        [self.img_profile sd_setImageWithURL:[NSURL URLWithString:profile] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    
    NSNumber * isproject = [dictionary objectForKey:key_newstableviewcell_isproject];
    if (isproject && isproject.boolValue) {
        self.lbl_location.text = [dictionary objectForKey:key_newstableviewcell_projectlocation];
        self.lbl_state.text = [dictionary objectForKey:key_newstableviewcell_projectstate];
    }
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size1 = [self.lbl_title sizeThatFits:CGSizeMake(self.lbl_title.width, CGFLOAT_MAX)];
    self.lbl_title.height = size1.height;
    
    NSNumber * isproject = [self.dictionary objectForKey:key_newstableviewcell_isproject];
    if (isproject && isproject.boolValue) {
        CGSize size2 = [self.lbl_location sizeThatFits:CGSizeMake(self.lbl_location.width, CGFLOAT_MAX)];
        CGSize size3 = [self.lbl_state sizeThatFits:CGSizeMake(self.lbl_state.width, CGFLOAT_MAX)];
        self.lbl_location.top = self.lbl_title.bottom + 5;
        self.lbl_location.height = size2.height;
        self.lbl_state.top = self.lbl_location.bottom + 5;
        self.lbl_state.height = size3.height;
    }
}
-(void)setcellValue:(NSString *)value
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)lbl_location
{
    if (!_lbl_location) {
        _lbl_location = [[UILabel alloc] initWithFrame:CGRectMake(self.lbl_title.left, self.lbl_title.bottom + 2, self.lbl_title.width, 0)];
        _lbl_location.textColor =[UIColor grayColor];
        [self.contentView addSubview:_lbl_location];
    }
    return _lbl_location;
}

-(UILabel *)lbl_state
{
    if (!_lbl_state) {
        _lbl_state = [[UILabel alloc] initWithFrame:CGRectMake(self.lbl_location.left, self.lbl_location.bottom + 2, 80, 0)];
        _lbl_state.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_lbl_state];
    }
    return _lbl_state;
}

@end
