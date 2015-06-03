//
//  NewsListModel.h
//  JXL
//
//  Created by 跑酷 on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIBaseObject.h"
/**
 * {
 id:新闻id,
 topNum:点赞数,
 title:标题,
 “content”:内容,
 “views”:评论数,
 thumb:缩略图,
 “username”:作者
 addtime:添加时间
 }
 */
@interface ANews : ArchiveObject
@property(nonatomic,retain) NSString * m_id;//:新闻id,
@property(nonatomic,retain) NSString * m_topNum;//:点赞数,
@property(nonatomic,retain) NSString * m_title;//:标题,
@property(nonatomic,retain) NSString * m_content;//”:内容,
@property(nonatomic,retain) NSString * m_views;//”:评论数,
@property(nonatomic,retain) NSString * m_thumb;//:缩略图,
@property(nonatomic,retain) NSString * m_username;//”:作者
@property(nonatomic,retain) NSString * m_addtime;//:添加时间

@end

@interface NewsList :ArchiveObject
@property(nonatomic,retain) NSString * m_id;
@property(nonatomic,retain) NSString * m_topNum;
@property(nonatomic,retain) NSString * m_title;
@property(nonatomic,retain) NSString * m_content;
@property(nonatomic,retain) NSString * m_views;
@property(nonatomic,retain) NSString * m_thumb;
@property(nonatomic,retain) NSString * m_username;
@property(nonatomic,retain) NSString * m_addtime;
@end

@interface NewsListModel : NSObject

+(NSArray *)encodeDiction:(NSDictionary *)dictionary;
@end

@interface FindNewsByIDModel : NSObject
+(ANews *)encodeDiction:(NSDictionary *)Dictionary;
@end


/**
 *  新闻评论列表(newsCommentList)
 {
 content:评论或回复的内容
 memberName:评论者姓名,
 memberName_pic:评论者的头像
 typeName:评论者身份
 reply_name:被回复人的姓名,
 reply_pic:被回复人的头像,
 reply_content:被回复的内容,
 reply_typeName:被回复者的身份
 
 }
 */
@interface NewsCommentList:ArchiveObject
@property(nonatomic,retain) NSString * m_addtime;
@property(nonatomic,retain) NSString * m_cid;
@property(nonatomic,retain) NSString * m_mid;
@property(nonatomic,retain) NSString * m_id;
@property(nonatomic,retain) NSString * m_type;
@property(nonatomic,retain) NSString * m_content;
@property(nonatomic,retain) NSString * m_memberName;
@property(nonatomic,retain) NSString * m_memberName_pic;
@property(nonatomic,retain) NSString * m_typeName;
@property(nonatomic,retain) NSString * m_reply_name;
@property(nonatomic,retain) NSString * m_reply_pic;
@property(nonatomic,retain) NSString * m_reply_content;
@property(nonatomic,retain) NSString * m_reply_typeName;
@end


@interface NewsCommentListModel : NSObject
+(NSArray *)encodeDiction:(NSDictionary *)Dictionary;
@end

