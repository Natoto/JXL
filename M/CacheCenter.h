//
//  CacheCenter.h
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXL_Define.h"


#define GET_OBJECT_OF_USERDEFAULT(KEY)   [[CacheCenter sharedInstance] readNSUserDefaultObjectForKey:KEY];
#define SET_OBJECT_OF_USERDEFAULT(OBJ,KEY)  [[CacheCenter sharedInstance] setNSUserDefaultObject:OBJ forKey:KEY];


@interface CacheCenter : NSObject
AS_SINGLETON(TopicCacheCenter)

/**
 * 使用 NSUserDefault 读key数据
 */
-(id)readNSUserDefaultObjectForKey:(NSString *)key;
/**
 * 使用 NSUserDefault 存储 key的数据
 */
-(void)setNSUserDefaultObject:(id)object forKey:(NSString *)key;

/**
 * 保存archive对象
 */
-(void)saveObject:(id)object forkey:(NSString *)key;
/**
 * 读取缓存数据
 */
-(id)readObject:(NSString *)key;

//-(void)removeObject:(NSString *)key;

//发送清除历史缓存通知
-(void)removePreUserData:(NSString *)username;
@end
