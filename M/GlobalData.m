//
//  GlobalData.m
//  JXL
//
//  Created by BooB on 15/5/3.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "GlobalData.h"
#import "CacheCenter.h"

@implementation GlobalData
@synthesize m_res_perfectmember = _m_res_perfectmember;
@synthesize m_password = _m_password;
@synthesize m_mobile = _m_mobile;
@synthesize m_email = _m_email;
@synthesize m_mid = _m_mid;
@synthesize m_login_info = _m_login_info;
@synthesize getIsRunGuidance = _getIsRunGuidance;
DEF_SINGLETON(GlobalData)

-(void)RemoveGlobalData
{
    self.m_mid = nil;
    self.m_password = nil;
    self.m_mobile = nil;
    self.m_email = nil;
    self.m_login_info = nil;
    self.m_res_perfectmember = nil;
}

-(NSString *)m_hostname
{
    return @"112.74.78.166";
}

-(NSString *)getSexValueFromKey:(NSString *)key
{
    NSString * membervalue;
    if ([key isEqualToString:KEY_SEX_MAN]) {
        membervalue = VALUE_SEX_MAN;
    }
    else if([key isEqualToString:KEY_SEX_WOMAN])
    {
        membervalue = VALUE_SEX_WOMAN;
    }
    else membervalue = VALUE_SEX_UNKNOW;
    
    return membervalue;
}



#pragma mark - getter setter
-(void)setGetIsRunGuidance:(BOOL)getIsRunGuidance
{
    _getIsRunGuidance = getIsRunGuidance;
    [[NSUserDefaults standardUserDefaults]  setBool:getIsRunGuidance forKey:@"IsRunGuidance"];
}
-(BOOL)getIsRunGuidance
{
    BOOL ret = [[NSUserDefaults standardUserDefaults] boolForKey:@"IsRunGuidance"];
    return ret;
}

-(NSString *)m_mobile
{
    if (!_m_mobile) {
        _m_mobile = GET_OBJECT_OF_USERDEFAULT(@"user_mobile");
    }
    return _m_mobile;
}

-(void)setM_mobile:(NSString *)m_mobile
{
    _m_mobile = m_mobile;
    SET_OBJECT_OF_USERDEFAULT(_m_mobile, @"user_mobile");
}

-(NSString *)m_email
{
    if (!_m_email) {
        _m_email = GET_OBJECT_OF_USERDEFAULT(@"user_email");
    }
    return _m_email;
}

-(void)setM_email:(NSString *)m_email
{
    _m_email = m_email;
    SET_OBJECT_OF_USERDEFAULT(m_email, @"user_email");
}

-(NSString *)m_password
{
    if (!_m_password) {
        _m_password = GET_OBJECT_OF_USERDEFAULT(@"user_password");
    }
    return _m_password;
}

-(void)setM_password:(NSString *)m_password
{
    _m_password = m_password;
    SET_OBJECT_OF_USERDEFAULT(m_password, @"user_password");
}

-(NSString *)m_mid
{
    if (!_m_mid) {
        _m_mid = GET_OBJECT_OF_USERDEFAULT(@"user_mid");
    }
    return _m_mid;
}

-(void)setM_mid:(NSString *)m_mid
{
    _m_mid = m_mid;
    SET_OBJECT_OF_USERDEFAULT(m_mid, @"user_mid");
}

-(RES_PerfectMember *)m_res_perfectmember
{
    if (!_m_res_perfectmember) {
        id object = [[CacheCenter sharedInstance] readObject:NSStringFromClass([RES_PerfectMember class])];
        if (object) {
            _m_res_perfectmember = object;
        }
    }
    return _m_res_perfectmember;
}

//保存
-(void)setM_res_perfectmember:(RES_PerfectMember *)m_res_perfectmember
{
    _m_res_perfectmember = m_res_perfectmember;
    if (m_res_perfectmember) {
        [[CacheCenter sharedInstance] saveObject:m_res_perfectmember forkey:NSStringFromClass([m_res_perfectmember class])];
    }
}



-(void)setM_login_info:(RES_Login_Info *)m_login_info
{
    _m_login_info = m_login_info;
    if (m_login_info) {
         [[CacheCenter sharedInstance] saveObject:m_login_info forkey:NSStringFromClass([RES_Login_Info class])];
    }
}

-(RES_Login_Info *)m_login_info
{
    if (!_m_login_info) {
        id object = [[CacheCenter sharedInstance] readObject:NSStringFromClass([RES_Login_Info class])];
        if (object) {
            _m_login_info = object;
        }
    }
    return _m_login_info;
}

-(void)synchronize_m_login_info
{
     [[CacheCenter sharedInstance] saveObject:self.m_login_info forkey:NSStringFromClass([RES_Login_Info class])];
}
@end
