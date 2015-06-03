//
//  TelephoneButtonCell.m
//  JXL
//
//  Created by BooB on 15/5/19.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "TelephoneButtonCell.h"
#import "UIViewAdditions.h"
#import "UIImage+HBExtension.h"
#import "JXL_Define.h"
#import <objc/runtime.h>
@implementation TelephoneButtonCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setcelldetailtitle:(NSString *)detailtitle{}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.btn_call.frame = CGRectMake(20, 10, self.width - 40, self.height - 20);
}

-(void)setcellTitle:(NSString *)title
{
    [self.btn_call setTitle:title forState:UIControlStateNormal];
}

-(UIButton *)btn_call
{
    if (!_btn_call) {
        _btn_call = [UIButton buttonWithType:UIButtonTypeCustom];
//        _btn_call.userInteractionEnabled = NO;
        _btn_call.layer.masksToBounds = YES;
        _btn_call.layer.cornerRadius = 10;
        [_btn_call setBackgroundImage:[UIImage buttonImageFromColor:KT_UIColorWithRGB(239, 239, 239) frame:CGRectMake(0, 0, 320, 44)] forState:UIControlStateSelected];
        [_btn_call setBackgroundImage:[UIImage buttonImageFromColor:KT_UIColorWithRGB(250, 250, 250) frame:CGRectMake(0, 0, 320, 44)] forState:UIControlStateNormal];
        [_btn_call addTarget:self action:@selector(calltelephone:) forControlEvents:UIControlEventTouchUpInside];
        _btn_call.layer.borderColor = [UIColor grayColor].CGColor;
        _btn_call.layer.borderWidth = 0.6;
        _btn_call.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn_call setTitleColor:KT_UIColorWithRGB(109, 185, 253) forState:UIControlStateNormal];
        [self.contentView addSubview:_btn_call];
    }
    return _btn_call;
}

-(IBAction)calltelephone:(id)sender
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAction:)]) {
////        [self.delegate selectAction:nil];
//        [self.delegate performSelector:@selector(selectAction:) withObject:nil afterDelay:0];
//    } 
    if ( self.delegate &&  [self.delegate respondsToSelector:NSSelectorFromString(@"selectAction:")] )
    {
        [self.delegate performSelector:NSSelectorFromString(@"selectAction:") withObject:self.cellstruct];
    }
} 

@end
