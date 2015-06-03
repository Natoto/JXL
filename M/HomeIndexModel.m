//
//  HomeIndex.m
//  JXL
//
//  Created by BooB on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#define IMPLEMENTATION(CLASS) \
@implementation CLASS\
@end

#import "HomeIndexModel.h"

IMPLEMENTATION(FirstNews)
@implementation FirstNewsModel

+(FirstNews *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSDictionary class]]) {
        FirstNews * ftn = [[FirstNews alloc] init];
        OBJECT_SETTER_FROM_DIC(ftn, _id, Dictionary)
        OBJECT_SETTER_FROM_DIC(ftn, img, Dictionary)
        OBJECT_SETTER_FROM_DIC(ftn, title, Dictionary)
        return ftn;
    }
    return nil;
}
@end

IMPLEMENTATION(FirstInvestor)
@implementation firstInvestorModel

+(FirstInvestor *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSDictionary class]]) {
        FirstInvestor * ftn = [[FirstInvestor alloc] init];
        OBJECT_SETTER_FROM_DIC(ftn, _id, Dictionary)
        OBJECT_SETTER_FROM_DIC(ftn, img, Dictionary)
        OBJECT_SETTER_FROM_DIC(ftn, title, Dictionary)
        return ftn;
    }
    return nil;
}

@end

IMPLEMENTATION(HotNews)
@implementation HotNewsModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
       
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * newsarray = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL *stop) {
            
            HotNews * ftn = [[HotNews alloc] init];
            OBJECT_SETTER_FROM_DIC(ftn, _id, obj)
            OBJECT_SETTER_FROM_DIC(ftn, img, obj)
            OBJECT_SETTER_FROM_DIC(ftn, title, obj)
            OBJECT_SETTER_FROM_DIC(ftn, desc, obj)
            [newsarray addObject:ftn];
        }];
        return newsarray;
    }
    return nil;
}

@end

#pragma mark 热门项目

IMPLEMENTATION(HotProject)
@implementation HotProjectModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * newsarray = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL *stop) {
            
            HotProject * ftn = [[HotProject alloc] init];
            OBJECT_SETTER_FROM_DIC(ftn, _id, obj)
            OBJECT_SETTER_FROM_DIC(ftn, img, obj)
            OBJECT_SETTER_FROM_DIC(ftn, title, obj)
            OBJECT_SETTER_FROM_DIC(ftn, demand, obj)
            OBJECT_SETTER_FROM_DIC(ftn, school, obj)
            OBJECT_SETTER_FROM_DIC(ftn, type, obj)
            
            [newsarray addObject:ftn];
        }];
        return newsarray;
    }
    return nil;
}

@end

IMPLEMENTATION(RecommProjectContent)
@implementation RecommProjectContentModel

+(RecommProjectContent *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSDictionary class]]) {
        RecommProjectContent * ftn = [[RecommProjectContent alloc] init];
        OBJECT_SETTER_FROM_DIC(ftn, _id, Dictionary)
        OBJECT_SETTER_FROM_DIC(ftn, img, Dictionary)
        OBJECT_SETTER_FROM_DIC(ftn, title, Dictionary)
        return ftn;
    }
    return nil;
}

@end

//IMPLEMENTATION(RecommProjectTitles)

//@implementation RecommProjectTitlesModel
//
//+(RecommProjectTitles *)encodeDiction:(NSDictionary *)Dictionary
//{
//    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSDictionary class]]) {
//        RecommProjectTitles * ftn = [[RecommProjectTitles alloc] init];
//        OBJECT_SETTER_FROM_DIC(ftn, titleName, Dictionary)
//        OBJECT_SETTER_FROM_DIC(ftn, typeId, Dictionary)
//        OBJECT_SETTER_FROM_DIC(ftn, typeName, Dictionary)
//        return ftn;
//    }
//    return nil;
//}
//
//
//@end

#pragma mark 推荐项目
IMPLEMENTATION(RecommProject)

@implementation RecommProjectModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * newsarray = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL *stop) {
           
            RecommProject * ftn = [[RecommProject alloc] init];
            
            OBJECT_SETTER_FROM_DIC(ftn, titleName, obj)
            OBJECT_SETTER_FROM_DIC(ftn, typeId, obj)
            OBJECT_SETTER_FROM_DIC(ftn, typeName, obj)
            
            if([obj objectForKey:@"content"])
            {
                NSArray * contents = [obj objectForKey:@"content"];
                NSMutableArray * contsary = [NSMutableArray arrayWithCapacity:0];
                if (contents && [[contents class] isSubclassOfClass:[NSArray class]]) {
                    [contents enumerateObjectsUsingBlock:^(NSDictionary * contentdic, NSUInteger idx, BOOL *stop) {
                        RecommProjectContent * arpc = [RecommProjectContentModel encodeDiction:contentdic];
                        [contsary addObject:arpc];
                    }];
                }
                ftn.m_content = contsary;
            }
            [newsarray addObject:ftn];
        }];
        return newsarray;
    }
    return nil;
}

@end

#pragma mark 推荐投资人

IMPLEMENTATION(RecommInvestor)

@implementation RecommInvestorModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * newsarray = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL *stop) {
            
            RecommInvestor * ftn = [[RecommInvestor alloc] init];
            OBJECT_SETTER_FROM_DIC(ftn, _id, obj)
            OBJECT_SETTER_FROM_DIC(ftn, img, obj)
            OBJECT_SETTER_FROM_DIC(ftn, title, obj)
            
            [newsarray addObject:ftn];
        }];
        return newsarray;
    }
    return nil;
}

@end


IMPLEMENTATION(HomeIndex)

@implementation HomeIndexModel
DEF_SINGLETON(HomeIndexModel)

-(HomeIndex *)encodeDictionary:(NSDictionary *)Dictionary
{
    if (Dictionary && [[Dictionary class] isSubclassOfClass:[NSDictionary class]]) {
        HomeIndex * home = [[HomeIndex alloc] init];
        
        home.m_hotNews = [HotNewsModel encodeDiction:[Dictionary objectForKey:@"hotNews"]];
        home.m_firstInvestor = [firstInvestorModel encodeDiction:[Dictionary objectForKey:@"firstInvestor"]];
        home.m_recommInvestor = [RecommInvestorModel encodeDiction:[Dictionary objectForKey:@"recommInvestor"]];
        
        NSDictionary * recdic = [Dictionary objectForKey:@"recommProject"];
        home.m_recommProject = [RecommProjectModel  encodeDiction:recdic];
        home.m_hotProject = [HotProjectModel encodeDiction:[Dictionary objectForKey:@"hotProject"]];
        home.m_firstNews = [FirstNewsModel encodeDiction:[Dictionary objectForKey:@"firstNews"]];
        self.m_homeindex = home;
        return home;
    }
    
    return nil;
}
@end
