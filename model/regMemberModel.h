//
//  regMemberModel.h
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee_StreamViewModel.h"
#import "jxl.h"
@interface regMemberModel : BeeStreamViewModel

@property(nonatomic,strong) NSString * phone;

+(void)regMemberWithPhone:(NSString *)phone block:(void(^)(STATUS * block)) block;
@end
