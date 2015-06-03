//
//  ActivityModel.m
//  JXL
//
//  Created by 跑酷 on 15/5/20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "ActivityModel.h"
#import "NSObject+ObjectMap.h"
@implementation ActivityType
@end


@implementation activitylist

@synthesize address = _address;
@synthesize area = _area;
@synthesize catid = _catid;
@synthesize city = _city;
@synthesize content = _content;
@synthesize endDate = _endDate;
@synthesize id = _id;
@synthesize is_regist = _is_regist; //:当前用户是否报名(1表示已报名,0表示未报名),

@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize province = _province;
@synthesize sigNum = _sigNum;
@synthesize startDate = _startDate;
@synthesize status = _status; //活动状态(0预开始,1进行中,2已结束),
@synthesize thumb = _thumb;
@synthesize title = _title;
@synthesize topicName = _topicName;
@synthesize type = _type;// 活动类型(1表示官方活动,0表示非官方活动),
@synthesize views = _views;

-(NSString *)typeOfActivity
{
    NSString * typestr = nil;
    switch (self.type.integerValue) {
        case 0:
            typestr = @"非官方活动";
            break;
        case 1:
            typestr = @"官方活动";
            break;
    }
    return typestr;
}
-(NSString *)statusOfActivity
{
    NSString * states = nil;
    switch (self.status.integerValue) {
        case 0:
            states = @"预开始";
            break;
        case 1:
            states = @"进行中";
            break;
        case 2:
            states = @"已结束";
            break;
        default:
            states = @"未知";
            break;
    }
    return states;
}
- (BOOL)validate
{
    return YES;
}

@end

@implementation ActivityModel

+(NSArray *)encodeActivityTypeWithJsonstring:(NSString *)json
{
    return [NSArray arrayOfType:[ActivityType class] FromJSONData:[json dataUsingEncoding:NSUTF8StringEncoding]];
}

+(NSArray *)encodeactivitylistWithJsonstring:(NSString *)json
{
    return [NSArray arrayOfType:[activitylist class] FromJSONData:[json dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
