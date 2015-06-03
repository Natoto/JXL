//
//  ReplyInputAccessoryView.m
//  JXL
//
//  Created by 跑酷 on 15/5/6.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "UIViewAdditions.h"
#import "JXL_Define.h"
#import "ReplyInputAccessoryView.h"
#import "ToolsFunc.h"
@interface ReplyInputAccessoryView()
@property(nonatomic,retain) UIButton * btn_close;
@property(nonatomic,retain) UIButton * btn_confirm;
@property(nonatomic,retain) UITextView * txt_input;
@property(nonatomic,retain) UILabel  * lbl_title;
@end

@implementation ReplyInputAccessoryView
@synthesize content = _content;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self btn_confirm];
        [self btn_close];
        [self txt_input];
        self.backgroundColor = JXL_COLOR_THEME;
    }
    return self;
}

-(void)addConfirmTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.btn_confirm addTarget:target action:action forControlEvents:controlEvents];
}

-(void)addCloseTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.btn_close addTarget:target action:action forControlEvents:controlEvents];
}


-(void)setContent:(NSString *)content
{
    _content = content;
    if (content) {
        self.txt_input.text = content;
    }
}

-(NSString *)content
{
    _content = self.txt_input.text;
    return _content;
}

-(BOOL)resignFirstResponder
{
    return [self.txt_input resignFirstResponder];
}

-(BOOL)becomeFirstResponder
{
   return [self.txt_input becomeFirstResponder];
    
}

-(void)setTitle:(NSString *)title
{
    _title = title?title:@"";
    self.lbl_title.text = title;
}
#pragma mark - getter setter

-(UIButton *)btn_confirm
{
    if (!_btn_confirm) {
        _btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_confirm setImage:[UIImage imageNamed:@"item_red_confirm"] forState:UIControlStateNormal];
        _btn_confirm.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 10, 25, 25);
        _btn_confirm.showsTouchWhenHighlighted = YES;
        [self addSubview:_btn_confirm];
    }
    return _btn_confirm;
}

-(UIButton *)btn_close
{
    if (!_btn_close) {
        _btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_close setImage:[UIImage imageNamed:@"item_red_close"] forState:UIControlStateNormal];
        _btn_close.frame = CGRectMake(5, 10, 25, 25);
        _btn_close.showsTouchWhenHighlighted = YES;
        [self addSubview:_btn_close];
    }
    return _btn_close;
}

-(UITextView *)txt_input
{
    if (!_txt_input) {
        _txt_input = [[UITextView alloc] initWithFrame:CGRectMake(5, self.btn_confirm.bottom + 5, self.width - 10, self.height - self.btn_confirm.bottom - 20)];
        [self addSubview:_txt_input];
        _txt_input.backgroundColor = [UIColor whiteColor];
    }
    return _txt_input;
}

-(UILabel *)lbl_title
{
    if (!_lbl_title) {
        _lbl_title = [ToolsFunc CreateLabelWithFrame:CGRectMake(50, 5, 150, 30) andTxt:@"" fontsize:12];
        _lbl_title.center = CGPointMake(self.frame.size.width/2, 20);
        [self addSubview:_lbl_title];
    }
    return _lbl_title;
}

@end
