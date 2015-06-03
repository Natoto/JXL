//
//  CatListModel.m
//  JXL
//
//  Created by 跑酷 on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "CatListModel.h"

@implementation catList

@end

@implementation CatListModel


+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if ([[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * cats  = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            
            catList *cat    = [[catList alloc] init];
            cat.m_catid     = [obj objectForKey:@"catid"];
            cat.m_catname   = [obj objectForKey:@"catname"];
            [cats addObject:cat];
            
        }];
        return cats;
    }
    return nil;
}
@end
