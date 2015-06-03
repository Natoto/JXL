//
//  regMember.m
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "regMember.h"



@implementation regMember


- (BOOL)validate
{
	return YES;
}
@end

#pragma mark - switch_onoff

@implementation REGMEMBER

- (BOOL)validate
{
	return YES;
}

@end


@implementation API_REGMEMBER_SHOTS

- (id)init
{
    self = [super init];
    if ( self )
    {
        self.resp = nil;
    }
    return self;
}

- (void)dealloc
{
    self.resp = nil;
    //	[super dealloc];
}

- (void)routine
{
    if ( self.sending )
    {
        if ( nil == self.phone )
        {
            self.failed = YES;
            return;
        }
        
        NSString * requestURI =[NSString stringWithFormat:@"%@/api.php?m=App&a=regMember", [ServerConfig sharedInstance].url];
        self.POST(requestURI).PARAM(self.phone);
    }
    else if ( self.succeed )
    {
        NSObject * result = self.responseJSON;
        if ( result && [result isKindOfClass:[NSString class]] )
        {
            self.resp = [[regMember alloc] init];
            self.resp.status.errorId = @1;
        }
        
        if ( nil == self.resp || NO == [self.resp validate] )
        {
           self.resp = [[regMember alloc] init];
            
            
            STATUS * status = [[STATUS alloc] init];
           
            self.failed = YES;
            return;
        }
    }
    else if ( self.failed )
    {
        BeeLog(@"self.description===%@",self.description);
        // TODO:
    }
    else if ( self.cancelled )
    {
        BeeLog(@"self.description %@",self.description);
        // TODO:
    }
}
@end

