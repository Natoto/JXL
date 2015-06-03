//
//  C1_ProjectInfoCell.m
//  JXL
//
//  Created by BooB on 15-4-23.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "UIViewAdditions.h"
#import "C1_ProjectInfoCell.h"
#import "JXL_Define.h"
#import "UIImageView+WebCache.h"
#import "NSString+HBExtension.h"
@interface C1_ProjectInfoCell()<NIAttributedLabelDelegate>
@end
@implementation C1_ProjectInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self lbl_title];
        [self lbl_content];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)setcelldetailtitle:(NSString *)detailtitle{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setcellTitle:(NSString *)title
{
    self.lbl_title.hidden = !title.length;
    self.lbl_title.text = title;
}
-(void)setcellProfile:(NSString *)profile
{
    self.img_profile.hidden = !profile.length;
    if (profile && [profile isUrl]) {
        [self.img_profile sd_setImageWithURL:[NSURL URLWithString:profile] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
}

#define WIDTH_OF_CONTENT(HAVETITLE) HAVETITLE?(UISCREEN_WIDTH - 100):( UISCREEN_WIDTH - 20)
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.lbl_title.text.length) {
        self.lbl_title.left = 10;
        self.lbl_title.width = 80;
        self.lbl_title.centerY = self.contentView.height/2;
    }
    else
    {
        self.lbl_title.left = 10;
        self.lbl_title.width =0;
    }
    self.img_profile.left = self.lbl_title.right + 10;
    self.lbl_content.width = WIDTH_OF_CONTENT(self.lbl_title.text.length); //UISCREEN_WIDTH - 100;
    self.lbl_content.centerY =self.contentView.height/2;
    self.lbl_content.right = self.contentView.width - 10;
    
}

static UILabel * testLabel;
+(CGFloat)heighofCell:(NSString *)content havetitle:(BOOL)havetitle
{
    if (!testLabel) {
        testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_CONTENT(havetitle), 0)];
        testLabel.numberOfLines = 0;
        testLabel.font = [UIFont systemFontOfSize:13];
    }
    testLabel.text = content;
    CGSize size = [testLabel sizeThatFits:CGSizeMake(WIDTH_OF_CONTENT(havetitle), 0)];
    return fmaxf(size.height + 10, 44);
}

-(void)setcellValue:(NSString *)value
{
    self.lbl_content.text = value;
    if (value.length) {
        CGSize size = [self.lbl_content sizeThatFits:CGSizeMake(WIDTH_OF_CONTENT(self.lbl_title.text.length), 0)];
        self.lbl_content.height = size.height;
    }

//    self.lbl_content.centerY = self.contentView.height/2;
}

-(UILabel *)lbl_title
{
    if(!_lbl_title)
    {
        _lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 30)];
        _lbl_title.textColor = KT_UIColorWithRGB(91, 91, 91);
        _lbl_title.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_lbl_title];
    }
    return _lbl_title;
}

-(NIAttributedLabel *)lbl_content
{
    if (!_lbl_content) {
        _lbl_content = [[NIAttributedLabel alloc] initWithFrame:CGRectMake(10, 5, 200, 30)];
        _lbl_content.autoDetectLinks = YES;
        _lbl_content.delegate = self;
        _lbl_content.numberOfLines = 0;
        _lbl_content.font = [UIFont systemFontOfSize:13];
        _lbl_content.textColor = KT_UIColorWithRGB(94, 93, 96);
        _lbl_content.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_lbl_content];
    }
    return _lbl_content;
}

-(UIImageView *)img_profile
{
    if (!_img_profile) {
        _img_profile = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 40, 40)];
        _img_profile.backgroundColor= [UIColor grayColor];
        KT_CORNER_PROFILE(_img_profile);
        _img_profile.hidden = YES;
    }
    return _img_profile;
}
- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    [[UIApplication sharedApplication] openURL:result.URL];
}
@end
