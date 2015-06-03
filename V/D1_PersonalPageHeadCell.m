//
//  D1_PersonalPageHeadCell.m
//  JXL
//
//  Created by 跑酷 on 15/5/16.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_PersonalPageHeadCell.h"
#import "UIViewAdditions.h"
#import "JXL_Define.h"
#import "NSString+HBExtension.h"
#import "UIImageView+WebCache.h"
#import "MemberListModel.h"
#import "JXLCommon.h"
#import "perfectMemberModel.h"
#import "UIImage+HBExtension.h"
@implementation D1_PersonalPageHeadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        [self img_profile];
//        [self lbl_title];
//        [self lbl_age_sex];
//        [self lbl_location];
    }
    return self;
}

-(void)layoutSubviews
{
    
    CGFloat LABEL_HEIGHT = 20;
    [super layoutSubviews];
    self.height = [D1_PersonalPageHeadCell heightOfCell];
    if (self.membertype == cell_member_type_normal) {
        self.img_profile.center =CGPointMake(self.width/2, self.height/2);
        self.lbl_title.frame =CGRectMake(self.img_profile.left, self.img_profile.bottom, self.img_profile.width, LABEL_HEIGHT);
        self.lbl_title.textAlignment = NSTextAlignmentCenter;
    }
    else if(self.membertype == cell_member_type_player)
    {
        self.img_profile.frame = CGRectMake(10, 10, self.img_profile.width, self.img_profile.height);
        //CGPointMake(self.width/2, self.height/2);
        self.lbl_title.frame =CGRectMake(self.img_profile.right + 10, self.img_profile.top, 200, 30);
        self.lbl_location.frame = CGRectMake(self.lbl_title.left, self.lbl_title.bottom , 200, LABEL_HEIGHT);
        self.lbl_age_sex.frame = CGRectMake(self.lbl_location.left, self.lbl_location.bottom , 200, LABEL_HEIGHT);
        self.btn_seeproject.center = CGPointMake(self.contentView.width/2, self.contentView.height - 40);
    }
    else if (self.membertype == cell_member_type_vc) {
        self.img_profile.frame = CGRectMake(10, 10, self.img_profile.width, self.img_profile.height);
        //CGPointMake(self.width/2, self.height/2);
        self.lbl_title.frame =CGRectMake(self.img_profile.right+ 10, self.img_profile.top, 200, LABEL_HEIGHT);
        self.lbl_shenfen.frame = CGRectMake(self.lbl_title.left , self.lbl_title.bottom + 5, 200, LABEL_HEIGHT);
        self.lbl_guanzhulingyu.frame = CGRectMake(self.img_profile.right+ 10, self.lbl_shenfen.bottom + 5, 200, LABEL_HEIGHT);
    
        self.lbl_jianjie.frame = CGRectMake(10, self.lbl_guanzhulingyu.bottom + 10, self.width - 20, self.height - self.lbl_guanzhulingyu.bottom - 20);
    }
}


-(void)setcellobject:(id)object {
    
    MemberList * amember = (MemberList *)object;//(MemberList *)[dictionary objectForKey:key_personalpageheadcell_object];
    if (amember) {
        self.lbl_location.text = [NSString stringWithFormat:@"%@ %@",amember.schoolCity,amember.schoolName];
        self.lbl_title.text = amember.nickname;
        self.lbl_age_sex.text = [NSString stringWithFormat:@"%@岁(%@)",amember.age,amember.sex];
        self.lbl_jianjie.text = amember.introduce;
        self.lbl_guanzhulingyu.text = amember.interestTitle;
        self.lbl_shenfen.text = amember.typeName;
        
        NSArray * subview = [self.contentView subviews];
        [subview enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL *stop) {
            if ([[obj class] isSubclassOfClass:[UILabel class]] || [[obj class] isSubclassOfClass:[UIButton class]]) {
                obj.hidden = YES;
            }
        }];
        
        if ([amember.typeId isEqualToString:VALUE_MEMBER_NORMAL]) {
            self.lbl_title.hidden = NO;
            self.membertype = cell_member_type_normal;
        }
        if ([amember.typeId isEqualToString:VALUE_MEMBERTYPE_PLAYER]) {
            self.lbl_title.hidden = NO;
            self.lbl_location.hidden = NO;
            self.lbl_age_sex.hidden = NO;
            self.btn_seeproject.hidden = NO;
            self.membertype = cell_member_type_player;
        }
        
        if ([amember.typeId isEqualToString:VALUE_MEMBERTYPE_VC]) {
            self.lbl_title.hidden = NO;
            self.lbl_guanzhulingyu.hidden = NO;
            self.lbl_jianjie.hidden = NO;
            self.lbl_shenfen.hidden = NO;
            self.membertype = cell_member_type_vc;
        }
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setcellTitle:(NSString *)title
{
    self.lbl_title.text = title;
}

-(void)setcellProfile:(NSString *)profile
{
    if ([profile isUrl]) {//如果是网络图片 就加载网络图片
        [self.img_profile sd_setImageWithURL:[NSURL URLWithString:profile] placeholderImage:[UIImage imageNamed:@"defaultprofile"] options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            UIImage * image =[UIImage imageNamed:@"xuexiaobeijingdatu.png"];
            CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [D1_PersonalPageHeadCell heightOfCell]);
            UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
            [image drawInRect:CGRectMake(0, 0, size.width, size.height)
                    blendMode:kCGBlendModeColor
                        alpha:0.9];
            UIImage *highlighted = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //    [UIColor colorWithPatternImage:image]
            [self setBackgroundColor:[UIColor colorWithPatternImage:highlighted]];
            [self.contentView setBackgroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.6f]];
            
        }];
        return;
    }
    self.img_profile.image = [UIImage imageNamed:profile];
}

+(CGFloat)heightOfCell
{
    return 200.;
}
-(UIImageView *)img_profile
{
    if (!_img_profile) {
        _img_profile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_main_item1"]];
        _img_profile.frame = CGRectMake(0, 0, 60, 60);
        KT_CORNER_PROFILE(_img_profile)
        [self.contentView addSubview:_img_profile];
    }
    return _img_profile;
}

-(UILabel *)lbl_location
{
    if (!_lbl_location) {
        _lbl_location = [[UILabel alloc] init];
        [self set_lable_attr:_lbl_location];
        [self.contentView addSubview:_lbl_location];
    }
    return _lbl_location;
}

-(UILabel *)lbl_age_sex
{
    if (!_lbl_age_sex) {
        _lbl_age_sex = [[UILabel alloc] init];
        [self set_lable_attr:_lbl_age_sex];
        [self.contentView addSubview:_lbl_age_sex];
    }
    return _lbl_age_sex;
}

-(UILabel *)lbl_title
{
    if (!_lbl_title) {
        _lbl_title = [[UILabel alloc] init];
        _lbl_title.textColor = [UIColor whiteColor];
        _lbl_title.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:_lbl_title];
    }
    return _lbl_title;
}

-(void)set_lable_attr:(UILabel *)label
{
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = KT_UIColorWithRGB(180, 182, 177);
}
-(UILabel *)lbl_jianjie
{
//    _lbl_jianjie = [JXL_Common get_label:_lbl_jianjie superview:self.contentView];
    GET_COMMON_LABEL(_lbl_jianjie,
                     self.contentView,
                     _lbl_jianjie.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
                     _lbl_jianjie.textColor = [UIColor whiteColor];
                     _lbl_jianjie.numberOfLines = 4;
                     _lbl_jianjie.layer.masksToBounds = YES;
                     _lbl_jianjie.layer.cornerRadius = 5;
                     _lbl_jianjie.font = [UIFont systemFontOfSize:13];
                     )
    return _lbl_jianjie;
}

-(UILabel *)lbl_guanzhulingyu
{
    GET_COMMON_LABEL(_lbl_guanzhulingyu,
                     self.contentView,
                     _lbl_guanzhulingyu.textColor = KT_UIColorWithRGB(180, 182, 177);
                     [self set_lable_attr:_lbl_guanzhulingyu];
                     )
    return _lbl_guanzhulingyu;
}

-(UILabel *)lbl_shenfen
{
    GET_COMMON_LABEL(_lbl_shenfen,
                     self.contentView,
                     _lbl_shenfen.textColor = KT_UIColorWithRGB(180, 182, 177);
                      [self set_lable_attr:_lbl_shenfen];
                     )
    
    return _lbl_shenfen;
}

-(UIButton *)btn_seeproject
{
    if (!_btn_seeproject) {
        _btn_seeproject = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bottom - 50, 110, 35)];
        [_btn_seeproject setTitle:@"看TA的项目" forState:UIControlStateNormal];
        KT_CORNER_RADIUS(_btn_seeproject, 5);
        [_btn_seeproject setBackgroundColor:KT_UIColorWithRGB(15, 113, 196)];
        [self.contentView addSubview:_btn_seeproject];
    }
    return _btn_seeproject;
}

@end
