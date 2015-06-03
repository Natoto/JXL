//
//  A0_HotProjectCell.h
//  JXL
//
//  Created by BooB on 15/5/12.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

static NSString * key_a0_hotprojectcell_location = @"key_a0_hotprojectcell_location";
static NSString * key_a0_hotprojectcell_state = @"key_a0_hotprojectcell_state";
static NSString * key_a0_hotprojectcell_type = @"key_a0_hotprojectcell_type";

@interface A0_HotProjectCell : BaseTableViewCell    
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_location;
@property (weak, nonatomic) IBOutlet UILabel *lbl_state;
@property (weak, nonatomic) IBOutlet UILabel *lbl_type;

@end
