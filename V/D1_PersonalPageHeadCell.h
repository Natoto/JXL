//
//  D1_PersonalPageHeadCell.h
//  JXL
//
//  Created by 跑酷 on 15/5/16.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
typedef enum : NSUInteger {
    cell_member_type_normal,
    cell_member_type_vc,
    cell_member_type_player,
} cell_member_type;

static NSString * key_personalpageheadcell_object;
@interface D1_PersonalPageHeadCell : BaseTableViewCell
@property(nonatomic,retain) UIImageView * img_profile;
@property(nonatomic,retain) UILabel     * lbl_title;
@property(nonatomic,retain) UILabel     * lbl_location;
@property(nonatomic,retain) UILabel     * lbl_age_sex;

@property(nonatomic,retain) UILabel     * lbl_shenfen;
@property(nonatomic,retain) UILabel     * lbl_jianjie;
@property(nonatomic,retain) UILabel     * lbl_guanzhulingyu;
@property(nonatomic,retain) UIButton    * btn_seeproject;

@property(nonatomic,assign) cell_member_type membertype;

+(CGFloat)heightOfCell;
@end
