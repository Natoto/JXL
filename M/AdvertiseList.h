//
//  AdvertiseList.h
//  JXL
//
//  Created by 跑酷 on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "APIBaseObject.h"
#import "ArchiveObject.h"
#import <Foundation/Foundation.h>
/*
 “id” : 广告id,
 “title” : 名称,
 “content” :广告内容,
 “thumb” :广告图片,
 “type” :广告类型,
 “catid” :栏目id,
 “pushid”:推送id(例如栏目是新闻，则id是新闻id)
 “url”:链接;
 “is_index”:是否在首页(1表示首页,0表示不在)
 */
@interface AdvertiseList : APIBaseObject

@property(nonatomic,strong) NSString * m_id;
@property(nonatomic,strong) NSString * m_title;
@property(nonatomic,strong) NSString * m_content;
@property(nonatomic,strong) NSString * m_thumb;
@property(nonatomic,strong) NSString * m_type;
@property(nonatomic,strong) NSString * m_catid;
@property(nonatomic,strong) NSString * m_pushid;
@property(nonatomic,strong) NSString * m_url;
@property(nonatomic,strong) NSString * m_is_index;

@end

@interface AdvertiseListModel:NSObject

+(NSArray *)encodeDiction:(NSDictionary *)dictionary;


//-(void) toElement:(DDXMLElement*)element;
//-(void) fromElement:(DDXMLElement*)element;
//+(NSString*) escapeNode:(NSString*) node;
//+(NSString*) unescapeNode:(NSString*) node;

@end