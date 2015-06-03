//
//  regMember.h
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
#import "jxl.h"

@interface regMember : BeeActiveObject
@property (nonatomic, retain)   STATUS    *           status;
@end


@interface REGMEMBER : BeeActiveObject
;
@end


@interface API_REGMEMBER_SHOTS : BeeAPI
@property (nonatomic, strong)   regMember           * resp;
@property (nonatomic, strong)   NSString            * phone;

@end