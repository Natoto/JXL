//
//  jxl.m
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "jxl.h"

@implementation STATUS


@end

@implementation ServerConfig

DEF_SINGLETON( ServerConfig )
-(id)init
{
    self = [super init];
    if (self) {
        //获取系统当前的时间戳
        NSTimeZone *zone = [NSTimeZone defaultTimeZone];//获得当前应用程序默认的时区
        NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];//以秒为单位返回当前应用程序与世界标准时间（格林威尼时间）的时差
        NSDate *localeDate = [[NSDate date] dateByAddingTimeInterval:interval];
        NSTimeInterval timeInterval2 = [localeDate timeIntervalSince1970];
        NSString * tokenid =@"654321";
        NSString * dztoapp = @"dztoapp";
        NSString * tokenkey =[NSString stringWithFormat:@"%@%d%@",tokenid,(NSInteger)timeInterval2,dztoapp];
        tokenkey=[tokenkey MD5].lowercaseString;
        
        NSString *tokenstr =[NSString stringWithFormat:@"tokenid=%@&time=%d&tokenkey=%@",tokenid,(NSInteger)timeInterval2,tokenkey];
        tokenstr = [tokenstr MD5].lowercaseString;
        
        NSString * urlkey =[NSString stringWithFormat:@"&ostype=2&time=%d&tokenid=%@&token=%@",(NSInteger)timeInterval2,tokenid,tokenstr.URLEncoding];
        _urlpostfix = urlkey;
        BeeLog(@"%@",_urlpostfix);
        
        _url = @"http://112.74.78.166";
        
    }
    return self;
}

@end;