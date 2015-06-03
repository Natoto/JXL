//
//  MemberListModel.m
//  JXL
//
//  Created by BooB on 15/5/17.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "MemberListModel.h"
#import "NSObject+ObjectMap.h"
@implementation MemberList
@end

@implementation MemberListModel

+(MemberList *)encodeDiction:(NSString *)jsonstring
{
    MemberList * amember = [[MemberList alloc] initWithJSONData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
    return amember;
}
@end
