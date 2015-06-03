//
//  MemberCommnetsModel.m
//  JXL
//
//  Created by BooB on 15/5/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "MemberCommnetsModel.h"
#import "NSObject+ObjectMap.h"

@implementation AMemberCommnet

@end
 

@implementation MemberCommnetsModel

+(NSArray *)encodeDiction:(NSString *)jsonstring
{
    return [NSArray arrayOfType:[AMemberCommnet class] FromJSONData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
}
@end
