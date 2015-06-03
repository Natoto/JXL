//
//  GlobalData.h
//  JXL
//
//  Created by BooB on 15/5/3.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXL_Define.h"
#import "perfectMemberModel.h"
@interface GlobalData : NSObject
AS_SINGLETON(GlobalData)

//@property(nonatomic,retain) NSArray * m_advertiseList;
@property(nonatomic,retain) RES_PerfectMember *  m_res_perfectmember;
@property(nonatomic,retain) RES_Login_Info * m_login_info;

@property(nonatomic,retain) NSString * m_mid;
@property(nonatomic,retain) NSString * m_mobile;
@property(nonatomic,retain) NSString * m_email;
@property(nonatomic,retain) NSString * m_password;


@property(nonatomic,assign) BOOL getIsRunGuidance;
#pragma mark - 系统变量
@property(nonatomic,retain,readonly) NSString * m_hostname;
-(NSString *)getSexValueFromKey:(NSString *)key;

-(void)RemoveGlobalData;
-(void)synchronize_m_login_info;
@end
