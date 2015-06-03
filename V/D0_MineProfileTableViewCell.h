//
//  D0_MineProfileTableViewCell.h
//  JXL
//
//  Created by 跑酷 on 15/5/12.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface D0_MineProfileTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name; 
@property (weak, nonatomic) IBOutlet UIButton *btn_type;
@property (weak, nonatomic) IBOutlet UIButton *btn_chongzhi;

@end
