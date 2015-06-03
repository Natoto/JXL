//
//  ActivityModel.h
//  JXL
//
//  Created by 跑酷 on 15/5/20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "ArchiveObject.h"
#import <Foundation/Foundation.h>
//[{"catid":"4","catname":"\u521b\u4e1a\u8bb2\u5ea7"},{"catid":"9","catname":"\u521b\u4e1a\u805a\u4f1a"}]
@interface ActivityType : ArchiveObject
@property(nonatomic,retain) NSString * catid;
@property(nonatomic,retain) NSString * catname;
@end


@interface activitylist : ArchiveObject
@property (nonatomic, retain) NSString *			address;
@property (nonatomic, retain) NSString *			area;
@property (nonatomic, retain) NSString *			catid;
@property (nonatomic, retain) NSString *			city;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			endDate;
@property (nonatomic, retain) NSString *			id;
@property (nonatomic, retain) NSString *			is_regist;
@property (nonatomic, retain) NSString *			lat;
@property (nonatomic, retain) NSString *			lng;
@property (nonatomic, retain) NSString *			province;
@property (nonatomic, retain) NSNumber *			sigNum;
@property (nonatomic, retain) NSString *			startDate;
@property (nonatomic, retain) NSNumber *			status;
@property (nonatomic, retain) NSString *			thumb;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			topicName;
@property (nonatomic, retain) NSString *			type;
@property (nonatomic, retain) NSString *			views;


-(NSString *)statusOfActivity;
-(NSString *)typeOfActivity;
@end


@interface ActivityModel : NSObject
+(NSArray *)encodeActivityTypeWithJsonstring:(NSString *)json;

+(NSArray *)encodeactivitylistWithJsonstring:(NSString *)json;
@end
