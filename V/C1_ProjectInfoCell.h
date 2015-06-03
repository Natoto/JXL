//
//  C1_ProjectInfoCell.h
//  JXL
//
//  Created by BooB on 15-4-23.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "NIAttributedLabel.h"
@interface C1_ProjectInfoCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *lbl_title;
@property (strong, nonatomic) NIAttributedLabel *lbl_content;
@property (strong, nonatomic) UIImageView *img_profile;


+(CGFloat)heighofCell:(NSString *)content havetitle:(BOOL)havetitle;
@end
