//
//  AdvertiseList.m
//  JXL
//
//  Created by 跑酷 on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "AdvertiseList.h"

@implementation AdvertiseList

@end


@implementation AdvertiseListModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * ctrs  = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            AdvertiseList * advertiseList= [[AdvertiseList alloc] init];
            
            advertiseList.m_id =    [obj objectForKey:@"id"];
            advertiseList.m_title = [obj objectForKey:@"title"];
            advertiseList.m_thumb = [obj objectForKey:@"thumb"];
            advertiseList.m_type = [obj objectForKey:@"type"];
            advertiseList.m_catid = [obj objectForKey:@"catid"];
            advertiseList.m_pushid = [obj objectForKey:@"pushid"];
            advertiseList.m_url = [obj objectForKey:@"url"];
            advertiseList.m_is_index = [obj objectForKey:@"is_index"];
            [ctrs addObject:advertiseList];
            
        }];
        return ctrs;
    }
    return nil;
}
@end