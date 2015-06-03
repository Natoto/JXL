//
//  NewsListModel.m
//  JXL
//
//  Created by 跑酷 on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "NewsListModel.h"

@implementation NewsList

@end

@implementation NewsListModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if ([[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * cats  = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            
            NewsList * news = [[NewsList alloc] init];
            news.m_id = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
            news.m_topNum = [NSString stringWithFormat:@"%@",[obj objectForKey:@"topNum"]] ;
            news.m_title = [NSString stringWithFormat:@"%@",[obj objectForKey:@"title"]];
            news.m_content = [NSString stringWithFormat:@"%@",[obj objectForKey:@"content"]];
            news.m_views = [NSString stringWithFormat:@"%@",[obj objectForKey:@"views"]];
            news.m_thumb = [NSString stringWithFormat:@"%@",[obj objectForKey:@"thumb"]];
            news.m_username = [NSString stringWithFormat:@"%@",[obj objectForKey:@"username"]];
            news.m_addtime = [NSString stringWithFormat:@"%@",[obj objectForKey:@"addtime"]];
            [cats addObject:news];
            
        }];
        return cats;
    }
    return nil;
}
@end


@implementation ANews
@end

@implementation FindNewsByIDModel

+(ANews *)encodeDiction:(NSDictionary *)Dictionary
{
    if ([[Dictionary class] isSubclassOfClass:[Dictionary class]]) {
        
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * cats  = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
            ANews * news = [[ANews alloc] init];
            news.m_id = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
            news.m_topNum = [NSString stringWithFormat:@"%@",[obj objectForKey:@"topNum"]] ;
            news.m_title = [NSString stringWithFormat:@"%@",[obj objectForKey:@"title"]];
            news.m_content = [NSString stringWithFormat:@"%@",[obj objectForKey:@"content"]];
            news.m_views = [NSString stringWithFormat:@"%@",[obj objectForKey:@"views"]];
            news.m_thumb = [NSString stringWithFormat:@"%@",[obj objectForKey:@"thumb"]];
            news.m_username = [NSString stringWithFormat:@"%@",[obj objectForKey:@"username"]];
            news.m_addtime = [NSString stringWithFormat:@"%@",[obj objectForKey:@"addtime"]];
            [cats addObject:news];
            
        }];
        return [cats objectAtIndex:0];
    }
    return nil;
}
@end


@implementation  NewsCommentList
@end

@implementation NewsCommentListModel

//{
//    addtime = 1430369572;
//    cid = 1;
//    content = "\U56db\U529e";
//    id = 144;

//    memberName = "<null>";
//    "memberName_pic" = "";
//    "member_id" = 0;
//    mid = 64;

//    "reply_content" = "<null>";
//    "reply_id" = 0;
//    "reply_name" = "";
//    "reply_pic" = "";

//    "reply_typeName" = "<null>";
//    type = news;
//    typeName = "<null>";
//}

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if ([[Dictionary class] isSubclassOfClass:[Dictionary class]]) {
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * cats  = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            NewsCommentList * news = [[NewsCommentList alloc] init];
            news.m_addtime = [NSString stringWithFormat:@"%@",[obj objectForKey:@"addtime"]];
            news.m_cid = [NSString stringWithFormat:@"%@",[obj objectForKey:@"cid"]];
            news.m_id = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
            news.m_mid = [NSString stringWithFormat:@"%@",[obj objectForKey:@"mid"]];
            news.m_type = [NSString stringWithFormat:@"%@",[obj objectForKey:@"type"]];
            
            news.m_content = [NSString stringWithFormat:@"%@",[obj objectForKey:@"content"]];
            news.m_memberName = [NSString stringWithFormat:@"%@",[obj objectForKey:@"memberName"]];
            news.m_memberName_pic = [NSString stringWithFormat:@"%@",[obj objectForKey:@"memberName_pic"]];
            news.m_typeName = [NSString stringWithFormat:@"%@",[obj objectForKey:@"typeName"]];
            
            news.m_reply_name = [NSString stringWithFormat:@"%@",[obj objectForKey:@"reply_name"]];
            news.m_reply_pic = [NSString stringWithFormat:@"%@",[obj objectForKey:@"reply_pic"]];
            news.m_reply_content = [NSString stringWithFormat:@"%@",[obj objectForKey:@"reply_content"]];
            news.m_reply_typeName = [NSString stringWithFormat:@"%@",[obj objectForKey:@"reply_typeName"]];
            [cats addObject:news];
        }];
        return cats;
    }
    return nil;
}

@end
