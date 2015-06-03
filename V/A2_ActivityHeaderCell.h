//
//  D2_ActivityHeaderCell.h
//  JXL
//
//  Created by 跑酷 on 15/5/21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface A2_ActivityHeaderCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UIButton *btn_time;
@property (weak, nonatomic) IBOutlet UIButton *btn_location;
@property (weak, nonatomic) IBOutlet UIButton *btn_type;
@property (weak, nonatomic) IBOutlet UILabel *lbl_state;
@property (weak, nonatomic) IBOutlet UILabel *lbl_attentnumber;

@end
