//
//  NSString+Reg.m
//  JXL
//
//  Created by BooB on 15/5/20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "NSString+Reg.h"

@implementation NSString(Reg)

-(NSString *)getmmddstring
{//2015-04-13 12:33:44 获得时间
    //\[.*\] 匹配【】以及其里面的内容
    NSError *error;
    NSString *regulaStr =  @"\\w\\w-\\w\\w\\s";//@"\\^[.*\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    NSLog(@"%@", arrayOfAllMatches);
    
    NSString *urlStr = nil;
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        urlStr = [self substringWithRange:match.range];
        NSLog(@"%@", urlStr);
    }
    return urlStr;
}

-(NSString *)getmmddmmssstring
{//2015-04-13 12:33:44 获得时间
    //\[.*\] 匹配【】以及其里面的内容
    NSError *error;
    NSString *regulaStr =  @"\\w\\w-\\w\\w\\s\\w\\w:\\w\\w";//@"\\^[.*\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    NSLog(@"%@", arrayOfAllMatches);
    
    NSString *urlStr = nil;
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        urlStr = [self substringWithRange:match.range];
        NSLog(@"%@", urlStr);
    }
    return urlStr;
}

@end
