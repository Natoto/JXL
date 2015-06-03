//
//  regMemberModel.m
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "regMemberModel.h"
#import "regMember.h"

@implementation regMemberModel

+(void)regMemberWithPhone:(NSString *)phone block:(void(^)(STATUS * block)) block
{
 
        [API_REGMEMBER_SHOTS cancel];
        API_REGMEMBER_SHOTS * api = [API_REGMEMBER_SHOTS api];
        @weakify(api);
        api.phone = phone;
        api.whenUpdate = ^
        {
            @normalize(api);
            if ( api.sending )
            {
            }
            else
            {
                if ( api.succeed )
                {
                    if ( nil == api.resp || api.resp.status.errorId.integerValue)
                    {
                        api.failed = YES;
                        block(nil);
                    }
                    else
                    {
                        block(api.resp.status);
                    }
                }
                else
                {
                    block(nil);
                }
            }
        };
        
        [api send];
    
}
@end
