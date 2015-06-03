//
//  CacheCenter.m
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "CacheCenter.h"

@interface CacheCenter()
@property(nonatomic,retain) NSMutableArray * signalNames;
@end

@implementation CacheCenter
DEF_SINGLETON(TopicCacheCenter)

-(id)readNSUserDefaultObjectForKey:(NSString *)key
{
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return object;
}

-(void)setNSUserDefaultObject:(id)object forKey:(NSString *)key
{
    if (object) {
        [[NSUserDefaults standardUserDefaults]  setObject:object forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (object && ![self.signalNames containsObject:key]) {
        [self.signalNames addObject:key];
        [[NSUserDefaults standardUserDefaults] setObject:self.signalNames forKey:@"signalNames"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (!object) {//为空就移除
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults]  synchronize];
         if ([self.signalNames containsObject:key]) {
             [self.signalNames removeObject:key];
             [[NSUserDefaults standardUserDefaults] setObject:self.signalNames forKey:@"signalNames"];
             [[NSUserDefaults standardUserDefaults] synchronize];
         }
    }
}

-(id)readObject:(NSString *)key
{
    key = [CacheCenter fullKey:key fixkey:[CacheCenter curpostfix]];
    NSData *myEncodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return object;
}

-(void)saveObject:(id)object forkey:(NSString *)key
{
    key = [CacheCenter fullKey:key fixkey:[CacheCenter curpostfix]];
    if (object && key) {
        NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:object];
        [[NSUserDefaults standardUserDefaults] setObject:archiveCarPriceData forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (![self.signalNames containsObject:key]) {
        [self.signalNames addObject:key];
        [[NSUserDefaults standardUserDefaults] setObject:self.signalNames forKey:@"signalNames"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (!object && key) {//为空就移除
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        if ([self.signalNames containsObject:key]) {
            [self.signalNames removeObject:key];
            [[NSUserDefaults standardUserDefaults] setObject:self.signalNames forKey:@"signalNames"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
}

-(void)removeObject:(NSString *)key postfix:(NSString *)postfix
{
    key = [CacheCenter fullKey:key fixkey:postfix];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)fullKey:(NSString *)key fixkey:(NSString *)fixkey
{
    NSString * allkey  = nil;
    if (fixkey) {
        allkey = [NSString stringWithFormat:@"%@_%@",key,fixkey];
    }
    else
        allkey = key;
    
    return allkey;
}

+(NSString *)curpostfix
{
    return @"_jxl_";
}


//发送清除历史缓存通知
-(void)removePreUserData:(NSString *)username
{
    if (!username || ![username isEqualToString:[CacheCenter curpostfix]]) {//切换账号的时候清除所有的用户消息
       
        if (!self.signalNames.count) {
            self.signalNames = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"signalNames"]];
        }
        [self.signalNames enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            [self removeObject:obj postfix:username];
        }];
           }
}
@end
