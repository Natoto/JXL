//
//  HomeIndex.h
//  JXL
//
//  Created by BooB on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveObject.h"
#import "JXL_Define.h"


@interface FirstInvestor : ArchiveObject
AS_NSSTRING(_id)
AS_NSSTRING(img)
AS_NSSTRING(title)
@end

@interface firstInvestorModel : NSObject
+(FirstInvestor *)encodeDiction:(NSDictionary *)dictionary;
@end

@interface FirstNews : ArchiveObject
AS_NSSTRING(_id)
AS_NSSTRING(img)
AS_NSSTRING(title)
@end

@interface FirstNewsModel : NSObject
+(FirstNews *)encodeDiction:(NSDictionary *)dictionary;
@end

@interface HotNews : ArchiveObject 
AS_NSSTRING(desc)
AS_NSSTRING(_id)
AS_NSSTRING(img)
AS_NSSTRING(title)
@end

@interface HotNewsModel : NSObject
+(NSArray *)encodeDiction:(NSDictionary *)dictionary;
@end


@interface HotProject : ArchiveObject
AS_NSSTRING(demand)
AS_NSSTRING(_id)
AS_NSSTRING(img)
AS_NSSTRING(school)
AS_NSSTRING(title)
AS_NSSTRING(type)
@end
@interface HotProjectModel : NSObject
+(NSArray *)encodeDiction:(NSDictionary *)dictionary;
@end


@interface RecommInvestor : ArchiveObject
AS_NSSTRING(_id)
AS_NSSTRING(img)
AS_NSSTRING(title)
@end

@interface RecommInvestorModel: NSObject
+(NSArray *)encodeDiction:(NSDictionary *)dictionary;
@end

@interface RecommProjectContent : ArchiveObject
AS_NSSTRING(_id)
AS_NSSTRING(img)
AS_NSSTRING(title)
@end

@interface RecommProjectContentModel : NSObject
+(RecommProjectContent *)encodeDiction:(NSDictionary *)dictionary;
@end


@interface RecommProject : ArchiveObject
AS_NSSTRING(titleName)
AS_NSSTRING(typeId)
AS_NSSTRING(typeName)
AS_ARRAY(content)
@end

//@interface RecommProjectTitlesModel : NSObject
//+(RecommProjectTitles *)encodeDiction:(NSDictionary *)dictionary;
//@end


//@interface RecommProject : ArchiveObject
////AS_ARRAY(content)
//@end

@interface RecommProjectModel : NSObject
+(NSArray *)encodeDiction:(NSDictionary *)dictionary;
@end

@interface HomeIndex : ArchiveObject
AS_CLASS_OBJ(FirstInvestor, firstInvestor)
AS_CLASS_OBJ(FirstNews,firstNews)
AS_ARRAY(hotNews)
AS_ARRAY(hotProject)
AS_ARRAY(recommInvestor)
AS_ARRAY(recommProject)
@end


@interface HomeIndexModel : NSObject
AS_SINGLETON(HomeIndexModel)
AS_CLASS_OBJ(HomeIndex, homeindex)

-(HomeIndex *)encodeDictionary:(NSDictionary *)Dictionary;
@end


