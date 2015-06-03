//
//  BubbleStruct.m
//  pengmi
//
//  Created by 星盛 on 15/2/10.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "BubbleStruct.h"

@implementation BubbleStruct

-(id)initWithid:(NSNumber *)m_id m_image:(NSString *)m_image m_title:(NSString *)m_title m_money:(NSNumber *)m_money
{
    self = [super init];
    if (self) {
        _m_id = m_id;
        _m_image = m_image;
        _m_title = m_title;
        _m_money = m_money;
    }
    return self;
}
@end