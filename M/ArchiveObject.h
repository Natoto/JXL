//
//  ArchiveObject.h
//  tabOption
//
//  Created by 星盛 on 15/1/12.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AS_NSSTRING(OBJ) @property(nonatomic,retain) NSString * m_##OBJ;
#define AS_NSNUMBER(OBJ)  @property(nonatomic,retain) NSNumber * m_##OBJ;
#define AS_ARRAY(OBJ)  @property(nonatomic,retain) NSArray * m_##OBJ;
#define AS_CLASS_OBJ(__CLASS, __OBJ) @property(nonatomic,retain) __CLASS * m_##__OBJ;
 
#define OBJECT_SETTER_FROM_DIC(OBJ,PARA,DIC) OBJ.m_##PARA=[NSString stringWithFormat:@"%@",[DIC objectForKey:[@#PARA stringByReplacingOccurrencesOfString:@"_" withString:@""]]];
#define DIC_KEY(DIC,PARA) [DIC objectForKey:@#PARA]


@interface ArchiveObject : NSObject <NSCoding>

@end
