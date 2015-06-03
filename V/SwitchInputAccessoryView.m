//
//  InputAccessoryView.m
//  JXL
//
//  Created by BooB on 15-5-1.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "SwitchInputAccessoryView.h"
#import "JXL_Define.h"
#import "jxl.h"
@interface SwitchInputAccessoryView()


@property(nonatomic,strong) UIButton * lastButton;
@property(nonatomic,strong) UIButton * nextButton;
@property(nonatomic,strong) UIButton * doneButton;

@end

@implementation SwitchInputAccessoryView 

+(id)defalutAccessoryView
{
    static dispatch_once_t once; \
    static SwitchInputAccessoryView * __singleton__;
    
    dispatch_once( &once, ^{ __singleton__ = [[SwitchInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH,30)];
    });
    return __singleton__;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.2;
        [self lastButton];
        [self nextButton];
        [self doneButton];
    }
    return self;
}


-(IBAction)buttonTap:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(InputAccessoryView:last:next:done:)]) {
        BOOL last = NO;
        BOOL next = NO;
        BOOL done = NO;
        switch (button.tag) {
            case 10:
                last = YES;
                break;
            case 11:
                next = YES;
                break;
            case 12:
                done = YES;
                break;
            default:
                break;
        }
        [self.delegate InputAccessoryView:self last:last next:next done:done];
    }
}

-(UIButton *)lastButton
{
    if (!_lastButton) {
        _lastButton =  [ToolsFunc CreateButtonWithFrame:CGRectMake(5, 5, 60, 20)
                                                 andTxt:@"上一项"
                                                andTxtSize:12
                                               andImage:nil
                                            andTXTColor:[UIColor blackColor]
                                                 target:self
                                               selector:@selector(buttonTap:)
                                              superview:self
                                                    tag:10];
    }
    return _lastButton;
}


-(UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton =  [ToolsFunc CreateButtonWithFrame:CGRectMake(70, 5, 60, 20)
                                                 andTxt:@"下一项"
                                             andTxtSize:12
                                               andImage:nil
                                            andTXTColor:[UIColor blackColor]
                                                 target:self
                                               selector:@selector(buttonTap:)
                                              superview:self
                                                    tag:11];
    }
    return _nextButton;
}


-(UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton =  [ToolsFunc CreateButtonWithFrame:CGRectMake(UISCREEN_WIDTH - 75, 5, 60, 20)
                                                 andTxt:@"完成"
                                             andTxtSize:12
                                               andImage:nil
                                            andTXTColor:[UIColor blackColor]
                                                 target:self
                                               selector:@selector(buttonTap:)
                                              superview:self
                                                    tag:12];
    }
    return _doneButton;
}


@end
