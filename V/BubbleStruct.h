//
//  BubbleStruct.h
//  pengmi
//
//  Created by 星盛 on 15/2/10.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BubbleStruct : NSObject
@property(nonatomic,retain) NSNumber * m_id;
@property(nonatomic,retain) NSString * m_image;
@property(nonatomic,retain) NSString * m_title;
@property(nonatomic,retain) NSNumber * m_money;
@property(nonatomic,retain) NSNumber * m_select;

-(id)initWithid:(NSNumber *)m_id m_image:(NSString *)m_image m_title:(NSString *)m_title m_money:(NSNumber *)m_money;
@end