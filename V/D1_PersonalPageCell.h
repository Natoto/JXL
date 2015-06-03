//
//  D1_PersonalPageCell.h
//  JXL
//
//  Created by BooB on 15/5/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewCell.h"
@class EXUILabel;
@interface D1_PersonalPageCell : BaseTableViewCell
@property(nonatomic,retain) UILabel * lbl_comment;
@property(nonatomic,retain) EXUILabel * lbl_yinyong;
@property(nonatomic,retain) UILabel * lbl_time;
@end
