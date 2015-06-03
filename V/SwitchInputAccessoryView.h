//
//  InputAccessoryView.h
//  JXL
//
//  Created by BooB on 15-5-1.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXL_Define.h"

@class SwitchInputAccessoryView;

@protocol InputAccessoryViewDelegate <NSObject>

-(void)InputAccessoryView:(SwitchInputAccessoryView *)InputAccessoryView last:(BOOL)last next:(BOOL)next done:(BOOL)done;

@end

@interface SwitchInputAccessoryView : UIView

@property(nonatomic,assign) id<InputAccessoryViewDelegate> delegate;

+(id)defalutAccessoryView;
@property(nonatomic,assign) UITextField * cur_textfield;
@property(nonatomic,assign) id object;
@property(nonatomic,assign) id inputview;
@end
