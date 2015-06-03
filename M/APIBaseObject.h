//
//  ErrorObject.h
//  JXL
//
//  Created by BooB on 15-4-26.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "ArchiveObject.h"
#import "JXL_Define.h"
#import <Foundation/Foundation.h>
#import "CacheCenter.h"
/*
 “status”:0 表示失败
 errorId:错误id   （自己定义个错误数组 001 代表不存在 002代表参数未填写……..)
 errorMsg：错误内容
 */
 
#define HTTP_ERROR_PARMA     @"参数错误"
#define HTTP_ERROR_KEY       @"ERROR"
//{"status":0,"errorId":403,"errorMsg":"\u91cd\u590d\u62a5\u540d"}
@interface ErrorObject : NSObject
@property(nonatomic,retain) NSString * status;
@property(nonatomic,retain) NSString * errorId;
@property(nonatomic,retain) NSString * errorMsg;
@end

@class ArchiveObject;
@interface NSObject(APIBaseObject)
-(BOOL)isErrorObject;
@end

@interface APIBaseObject : NSObject

@property(nonatomic,strong) NSNumber * m_status;
@property(nonatomic,strong) NSNumber * m_errorId;
@property(nonatomic,strong) NSString * m_errorMsg;

+(APIBaseObject *)encodeDiction:(id)Dictionary;

+(ErrorObject *)encodeJsonResponse:(NSString *)jsonstring;

@end
