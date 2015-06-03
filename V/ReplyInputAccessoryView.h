//
//  ReplyInputAccessoryView.h
//  JXL
//
//  Created by 跑酷 on 15/5/6.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplyInputAccessoryView : UIControl

-(void)addCloseTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)addConfirmTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@property(nonatomic,retain) NSString * content;
@property(nonatomic,retain) NSString * title;
@end
