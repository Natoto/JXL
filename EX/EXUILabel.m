
//
//  EXUILabel.m
//  JXL
//
//  Created by 跑酷 on 15/5/19.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "EXUILabel.h"

@implementation EXUILabel

-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
