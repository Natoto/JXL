//
//  MemberCommnetsModel.h
//  JXL
//
//  Created by BooB on 15/5/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "ArchiveObject.h"
#import <Foundation/Foundation.h>
/**
 *
 [{
 “id” : 评论id,
 “type” : 评论类型(新闻/项目),
 “content”:评论的内容,
 【新闻】
 “title”:标题,
 “thumb”:新闻图片
 【项目】
 “title”:标题,
 },…]
 */
@interface AMemberCommnet:ArchiveObject
@property(nonatomic,retain) NSString *      id;//” : 评论id,
@property(nonatomic,retain) NSString *      type;//” : 评论类型(新闻/项目),
@property(nonatomic,retain) NSString *      content;//”:评论的内容,
//【新闻】
@property(nonatomic,retain) NSString *      title;//”:标题,
@property(nonatomic,retain) NSString *      thumb;//”:新闻图片
@property(nonatomic,retain) NSString *      addtime;
@end
 

@interface MemberCommnetsModel : NSObject

+(NSArray *)encodeDiction:(NSString *)jsonstring;

@end
