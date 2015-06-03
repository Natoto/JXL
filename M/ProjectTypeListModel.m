//
//  ProjectTypeListModel.m
//  JXL
//
//  Created by BooB on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "ProjectTypeListModel.h"
#import "HTTPSEngine.h"
#import "NSObject+ObjectMap.h"

@implementation ProjectTypeList

@end

@implementation ProjectTypeListModel
DEF_SINGLETON(ProjectTypeList)

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if ([[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * cats  = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            
            ProjectTypeList *cat    = [[ProjectTypeList alloc] init];
            cat.m_id     = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
            cat.m_name   = [NSString stringWithFormat:@"%@",[obj objectForKey:@"name"]];
            cat.m_sort   = [NSString stringWithFormat:@"%@",[obj objectForKey:@"sort"]];
            [cats addObject:cat];
        }];
        return cats;
    }
    return nil;
}

-(void)projectTypeList:(void (^)(NSDictionary *))response errorHandler:(void (^)(NSError *))err
{
    [[HTTPSEngine sharedInstance] fetch_projectTypeList:^(NSDictionary *Dictionary) {
        
        if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
            NSArray * array = [ProjectTypeListModel encodeDiction:Dictionary];
            self.projectTypeList = array;
            response(Dictionary);
        }
    } errorHandler:^(NSError *error) {
        err(error);
    }];
}
@end


@implementation ProjectList



@end

@implementation ProjectListModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    
    if ([[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * cats  = [NSMutableArray arrayWithCapacity:0];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            
            ProjectList *cat    = [[ProjectList alloc] init];
            cat.m_id            = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
            cat.m_name          = [NSString stringWithFormat:@"%@",[obj objectForKey:@"name"]];
            cat.m_demandName    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"demandName"]];
            cat.m_schoolCity    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"schoolCity"]];
            cat.m_schoolName    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"schoolName"]];
            cat.m_team_photo    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"team_photo"]];
            cat.m_views         = [NSString stringWithFormat:@"%@",[obj objectForKey:@"views"]];
            cat.m_topNum        = [NSString stringWithFormat:@"%@",[obj objectForKey:@"topNum"]];
            [cats addObject:cat];
        }];
        return cats;
    }
    return nil;
}

@end

@implementation ProjectInfo_New

-(id)init
{
    self = [super init];
    if (self) {
        HBOBJ_SETVALUE_FORPATH(self, @"NSString", @"team_photo_array")
        HBOBJ_SETVALUE_FORPATH(self, @"NSString", @"team_member_headpic")
    }
    return self;
}
@end

//@implementation ProjectInfo
//
//@end
/**
 * findProjectById
 *{
 id:项目id,
 name:项目名称,
 demandName:需求名称,
 typeName:项目类型,
 “schoolCity”:学校所在城市,
 “schoolName”:学校名称,
 “money”:资金额度,
 “team_name”:团队名称,
 “team_photo”:团队封面照片,
 “team_member_headpic”:团队成员头像,
 “leader_headpic”:负责人头像
 “team_info”:团队简介,
 “description”:项目描述
 “topNum”:点赞数,
 “views”:评论数,
 “annexNum”:附件下载次数，
 “annexSize”:附件的大小,
 “annexCode”下载码,
 “chargeMember”:1表示VIP充值用户,0表示非VIP充值用户.2表示非投资人.
 }
 */
@implementation FindProjectByIdModel
//
//+(ProjectInfo *)encodeDiction:(NSDictionary *)Dictionary
//{
//    
//    if (Dictionary && [[Dictionary class] isSubclassOfClass:[Dictionary class]]) {
//        NSArray * array = (NSArray *)Dictionary;
//        NSMutableArray * cats  = [NSMutableArray arrayWithCapacity:0];
//        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
////        NSDictionary * obj = Dictionary;
//            
//            ProjectInfo *cat    = [[ProjectInfo alloc] init];
//            cat.m_id            = [NSString stringWithFormat:@"%@",[obj objectForKey:@"id"]];
//            cat.m_name          = [NSString stringWithFormat:@"%@",[obj objectForKey:@"name"]];
//            cat.m_demandName    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"demandName"]];
//            cat.m_schoolCity    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"schoolCity"]];
//            cat.m_schoolName    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"schoolName"]];
//            cat.m_money         = [NSString stringWithFormat:@"%@",[obj objectForKey:@"money"]];
//            cat.m_team_name     = [NSString stringWithFormat:@"%@",[obj objectForKey:@"team_name"]];
//            cat.m_team_photo    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"team_photo"]];
//            cat.m_team_member_headpic    = [NSString stringWithFormat:@"%@",[obj objectForKey:@"team_member_headpic"]];
//            cat.m_team_info         = [NSString stringWithFormat:@"%@",[obj objectForKey:@"team_info"]];
//            cat.m_description       = [NSString stringWithFormat:@"%@",[obj objectForKey:@"description"]];
//            
//            cat.m_views             = [NSString stringWithFormat:@"%@",[obj objectForKey:@"views"]];
//            cat.m_topNum            = [NSString stringWithFormat:@"%@",[obj objectForKey:@"topNum"]];
//            
//            cat.m_annexNum          = [NSString stringWithFormat:@"%@",[obj objectForKey:@"annexNum"]];
//            cat.m_annexCode         = [NSString stringWithFormat:@"%@",[obj objectForKey:@"annexCode"]];
//            cat.m_chargeMember      = [NSString stringWithFormat:@"%@",[obj objectForKey:@"chargeMember"]];
//            [cats addObject:cat];
//        }];
//        return [cats objectAtIndex:0];
//    }
//    return nil;
//}

+(ProjectInfo_New *)encodeJsonString:(NSString *)jsonstring
{
    jsonstring = [jsonstring stringByReplacingOccurrencesOfString:@"description" withString:@"_description"];
    NSArray * array =  [NSArray arrayOfType:[ProjectInfo_New class] FromJSONData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
    if (array.count == 1) {
        return [array objectAtIndex:0];
    }
    return nil;
}
@end
