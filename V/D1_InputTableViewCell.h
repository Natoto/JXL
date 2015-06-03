//
//  D1_InputTableViewCell.h
//  JXL
//
//  Created by BooB on 15-4-22.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@class D1_InputTableViewCell;
@protocol D1_InputTableViewCellDelegate <NSObject>
@optional
-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldDidBeginEditing:(UITextField *)textField;
-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldDidEndEditing:(UITextField *)textField;

-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell sendCheckcode:(id)sender;
-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldChange:(NSString *)text;
@end

@interface D1_InputTableViewCell : BaseTableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *img_icon;
@property (strong, nonatomic) UITextField *txt_input;
@property (strong, nonatomic) UIButton *btn_yanzhengma;

//@property (nonatomic,assign) id<D1_InputTableViewCellDelegate> inputcelldelegate;
@end
