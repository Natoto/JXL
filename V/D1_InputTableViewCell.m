//
//  D1_InputTableViewCell.m
//  JXL
//
//  Created by BooB on 15-4-22.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_InputTableViewCell.h"
#import "UIViewAdditions.h"
@implementation D1_InputTableViewCell

- (void)awakeFromNib {
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setcellProfile:(NSString *)profile
{
    
}
-(void)setcellValue:(NSString *)value
{
    if (value.length) {
        self.txt_input.text = value;
    }
}
-(void)setcellTitle:(NSString *)title
{
}
- (IBAction)yanzhengmaTap:(id)sender {
     
    if (self.delegate && [self.delegate respondsToSelector:@selector(D1_InputTableViewCell:sendCheckcode:)]) {
        [self.delegate D1_InputTableViewCell:self sendCheckcode:sender];
    }
   
}

-(void)startdaojishi
{
    
    self.btn_yanzhengma.enabled = NO;
    __block int timeout= 60 ; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSString * yanzhengma = [self.dictionary objectForKey:key_cellstruct_subvalue1];
                [self.btn_yanzhengma setTitle:yanzhengma forState:UIControlStateNormal];
                self.btn_yanzhengma.enabled = YES;
            });
        }else{
//            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.d秒后重新获取",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.btn_yanzhengma setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

/**
 * 支持的配置  key_cellstruct_profile 头像
 *          key_cellstruct_subvalue1  右边按钮文字
 *          key_cellstruct_placehoder 输入框placeholder
 *          key_cellstruct_editing 是否选中
 *          key_cellstruct_active 开始执行任务
 */
-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    [super setcelldictionary:dictionary];
//    self.inputcelldelegate = self.delegate;
    NSString * yanzhengma = [dictionary objectForKey:key_cellstruct_subvalue1];
    if (yanzhengma.length) {
        [self.btn_yanzhengma setTitle:yanzhengma forState:UIControlStateNormal];
        self.btn_yanzhengma.layer.cornerRadius = 5;
        self.btn_yanzhengma.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        UIColor * btncolor = [dictionary objectForKey:key_cellstruct_subvalue2];
        if (btncolor) {
            [self.btn_yanzhengma setBackgroundColor:btncolor];
        }
    }
    
    NSString * imgname =[dictionary objectForKey:key_cellstruct_profile];
    if (imgname) {
        [self.img_icon setImage:[UIImage imageNamed:imgname]];
    }
    self.txt_input.delegate = self;
    self.txt_input.placeholder = [dictionary objectForKey:key_cellstruct_placehoder];
    self.txt_input.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSString * keyboardtype = [dictionary objectForKey:key_cellstruct_txtkeyboardtype];
    self.txt_input.keyboardType = UIKeyboardTypeDefault;
    if (keyboardtype) {
        if ([keyboardtype isEqualToString:value_cellstruct_txtkeyboardtype_number]) {
            self.txt_input.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
    
    NSNumber * secureentry = [dictionary objectForKey:key_cellstruct_txtsecureTextEntry];
    if (secureentry) {
        self.txt_input.secureTextEntry = secureentry.boolValue;
    }
    
    NSNumber * editing = [dictionary objectForKey:key_cellstruct_editing];
    if (editing) {
        self.editing = editing.boolValue;
    }
    
    NSNumber * active = [dictionary objectForKey:key_cellstruct_active];
    if (active && active.boolValue) {
        [self startdaojishi];
    }
//    [NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor],key_cellstruct_placehoder:@"请输入11位有效手机号",key_cellstruct_subvalue1:@"获取验证码",key_cellstruct_profile:@"shouji"}];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSString * yanzhengma = [self.dictionary objectForKey:key_cellstruct_subvalue1];
    NSString * imgname =[self.dictionary objectForKey:key_cellstruct_profile];
    
    if (imgname.length) {
        self.img_icon.frame = CGRectMake(20, 10, 20, 30);
        self.img_icon.center = CGPointMake(30, self.contentView.centerY);
    }
    
    if (yanzhengma.length) {
        self.btn_yanzhengma.frame = CGRectMake(self.width - 100, 10, 94, 30);
        self.btn_yanzhengma.center = CGPointMake(self.width - 60, self.contentView.centerY);
    }
    
    if (imgname.length && yanzhengma.length) {
        self.txt_input.frame = CGRectMake(self.img_icon.right + 5, 0, self.btn_yanzhengma.left -self.img_icon.right - 10, self.height);
    }
    
    if (imgname.length && !yanzhengma.length) {
          self.txt_input.frame = CGRectMake(self.img_icon.right + 5, 0, self.width - self.img_icon.right -5 -10, self.height);
    }
    
    if (!imgname.length && yanzhengma.length) {
        self.txt_input.frame = CGRectMake( 20, 0, self.btn_yanzhengma.left - 10 - 20, self.height);
    }
    
    if (!imgname.length && !yanzhengma.length) {
          self.txt_input.frame = CGRectMake( 20, 0, self.width - 40, self.height);
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boxValueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
//    [self.txt_input addTarget:self action:@selector(boxValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)setEditing:(BOOL)editing
{
    if (!editing) {
        if ([self.txt_input isFirstResponder]) {
            [self.txt_input resignFirstResponder];
        }
    }
}
//
//-(IBAction)boxValueChanged:(id)sender
//{
//    UITextField * textField = self.txt_input;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(D1_InputTableViewCell:textFieldChange:)]) {
////        NSString *resultingString = [textField.text stringByReplacingCharactersInRange:range withString: string];
//        NSLog(@"shouldChangeCharactersInRange: %@", textField.text);
//        [self.delegate D1_InputTableViewCell:self textFieldChange:textField.text];
//    }
//}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{ 
    if (self.delegate && [self.delegate respondsToSelector:@selector(D1_InputTableViewCell:textFieldDidBeginEditing:)]) {
        [self.delegate D1_InputTableViewCell:self textFieldDidBeginEditing:textField];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(D1_InputTableViewCell:textFieldDidEndEditing:)]) {
        [self.delegate D1_InputTableViewCell:self textFieldDidEndEditing:textField];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(D1_InputTableViewCell:textFieldChange:)]) {
        [self.delegate D1_InputTableViewCell:self textFieldChange:textField.text];
    }
} 
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(D1_InputTableViewCell:textFieldChange:)]) {
        NSString *resultingString = [textField.text stringByReplacingCharactersInRange:range withString: string];
        NSLog(@"shouldChangeCharactersInRange: %@", resultingString);
        [self.delegate D1_InputTableViewCell:self textFieldChange:resultingString];
    }
    return YES;
}


-(UIImageView *)img_icon
{
    if (!_img_icon) {
        _img_icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 16)];
        _img_icon.center = CGPointMake(30, self.centerY);
        _img_icon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_img_icon];
    }
    return _img_icon;
}

-(UITextField *)txt_input
{
    if (!_txt_input) {
        _txt_input = [[UITextField alloc] initWithFrame:CGRectMake(45, 10, 200, 40)];
        [self.contentView addSubview:_txt_input];
    }
    return _txt_input;
}

-(UIButton *)btn_yanzhengma
{
    if (!_btn_yanzhengma) {
        _btn_yanzhengma = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_yanzhengma.frame = CGRectMake(self.width - 100, 10, 94, 30);
        _btn_yanzhengma.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btn_yanzhengma addTarget:self action:@selector(yanzhengmaTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn_yanzhengma];
    }
    return _btn_yanzhengma;
}
@end
