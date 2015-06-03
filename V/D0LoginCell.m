//
//  D0LoginCell.m
//  JXL
//
//  Created by BooB on 15-4-21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D0LoginCell.h"

@implementation D0LoginCell

- (void)awakeFromNib {
    // Initialization code
    self.btn_login.layer.borderWidth = 0.6;
    self.btn_login.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setcellTitle:(NSString *)title
{
    
}
-(void)setcellProfile:(NSString *)profile
{
    
}
@end
