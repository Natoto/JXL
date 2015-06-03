//
//  jxl.h
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

#define MODELOBJECTKEY(...)  [@[__VA_ARGS__] componentsJoinedByString:@"_"]


@interface STATUS : NSObject
@property (nonatomic, retain) NSNumber *		status;
@property (nonatomic, retain) NSNumber *		errorId;
@property (nonatomic, retain) NSString *        errorMsg;
//+(NSString *)errmessage:(ERROR_CODE)error_code;
@end

#pragma mark - config

@interface ServerConfig : NSObject

AS_SINGLETON( ServerConfig )

@property (nonatomic, retain) NSString          *	url;
@property (nonatomic, strong) NSString          *   urlpostfix;
@end