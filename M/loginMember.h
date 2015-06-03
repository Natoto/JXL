//
//  loginMember.h
//  JXL
//
//  Created by BooB on 15-4-27.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import <Foundation/Foundation.h>
/**
 *{
 “member_id”:会员ID,
 “phone”:手机号,
 “headpic”:头像,
 “nickname”:姓名,
 “sex”:性别,
 “typeId”:会员类型ID,
 “typeName”:会员类型名称,
 “status”:是否上传了项目（1表示有,0表示没有）;
 “annex”:是否上传了附件（有项目返回是否有附件，有附件   返回1没有返回0）;
 【参赛人】
 “age”:年龄,
 “schoolId”:学校ID,
 “schoolCity”:学校所在城市,
 “schoolName”:学校名称,
 “teacher”:指导教师,
 “id”:身份证
 【投资人】
 “interest”:感兴趣的项目类别,
 “support”:提供资助类型
 }
 
 */
@interface loginMember : NSObject
@property(nonatomic,retain) NSString * m_member_id;
@property(nonatomic,retain) NSString * m_phone;
@property(nonatomic,retain) NSString * m_headpic;
@property(nonatomic,retain) NSString * m_nickname;
@property(nonatomic,retain) NSString * m_sex;
@property(nonatomic,retain) NSString * m_typeId;
@property(nonatomic,retain) NSString * m_typeName;
@property(nonatomic,retain) NSString * m_status;
@property(nonatomic,retain) NSString * m_annex;
@property(nonatomic,retain) NSString * m_age;
@property(nonatomic,retain) NSString * m_schoolId;
@property(nonatomic,retain) NSString * m_schoolCity;
@property(nonatomic,retain) NSString * m_schoolName;
@property(nonatomic,retain) NSString * m_teacher;
@property(nonatomic,retain) NSString * m_id;
@property(nonatomic,retain) NSString * m_interest;
@property(nonatomic,retain) NSString * m_support;

@end

@interface loginMemberModel:NSObject
+(loginMember *)encodeDiction:(NSDictionary *)Dictionary;
@end