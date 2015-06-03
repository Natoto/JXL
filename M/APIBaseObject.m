//
//  ErrorObject.m
//  JXL
//
//  Created by BooB on 15-4-26.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "APIBaseObject.h"
#import "NSObject+ObjectMap.h"
@implementation ErrorObject
@end

@implementation NSObject(APIBaseObject)

-(BOOL)isErrorObject
{
    if ([[self class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary * dictionary = (NSDictionary *)self;
        if ([dictionary objectForKey:@"errorId"]) {
            
            return YES;
        }
        if ([dictionary objectForKey:@"ERROR"]) {
            return YES;
        }
    } 
    return NO;
}
@end
@implementation APIBaseObject

-(id)init
{
    self = [super init];
    if (self) {
        self.m_status = @1;
        self.m_errorId = @-1;
        self.m_errorMsg = @"";
    }
    return self;
}

+(APIBaseObject *)encodeDiction:(id)Dictionary
{
    if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[Dictionary class]]) {
        APIBaseObject * object= [[APIBaseObject alloc] init];
        if ([Dictionary objectForKey:@"ERROR"]) {
            object.m_errorMsg = [Dictionary objectForKey:@"ERROR"];
        }else
        {
            object.m_status =  [Dictionary objectForKey:@"status"];
            object.m_errorId = [Dictionary objectForKey:@"errorId"];
            object.m_errorMsg = [Dictionary objectForKey:@"errorMsg"];
        }
        return object;
    }
    if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSString class]]) {
        APIBaseObject * object= [[APIBaseObject alloc] init];
        object.m_status = @0;
        object.m_errorId = @-1;
        object.m_errorMsg = [NSString stringWithFormat:@"%@",Dictionary];
    }
    return nil;
}


+(ErrorObject *)encodeJsonResponse:(NSString *)jsonstring
{
    return [[ErrorObject alloc] initWithJSONData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
}
@end
