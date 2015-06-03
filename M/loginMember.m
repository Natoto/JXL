//
//  loginMember.m
//  JXL
//
//  Created by BooB on 15-4-27.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "loginMember.h"

@implementation loginMember

@end

@implementation loginMemberModel
/**
 * “member_id”:会员ID,
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
 */
+(loginMember *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[Dictionary class]]) {
        loginMember * object= [[loginMember alloc] init];
        object.m_member_id =  [Dictionary objectForKey:@"member_id"];
        object.m_phone = [Dictionary objectForKey:@"phone"];
        object.m_headpic = [Dictionary objectForKey:@"headpic"];
        object.m_nickname = [Dictionary objectForKey:@"nickname"];
        object.m_sex = [Dictionary objectForKey:@"sex"];
        object.m_typeId = [Dictionary objectForKey:@"typeId"];
        object.m_typeName = [Dictionary objectForKey:@"typeName"];
        object.m_status = [Dictionary objectForKey:@"status"];
        object.m_annex = [Dictionary objectForKey:@"annex"];
        object.m_age = [Dictionary objectForKey:@"age"];
        object.m_schoolId = [Dictionary objectForKey:@"schoolId"];
        object.m_schoolCity = [Dictionary objectForKey:@"schoolCity"];
        object.m_schoolName = [Dictionary objectForKey:@"schoolName"];
        object.m_teacher = [Dictionary objectForKey:@"teacher"];
        object.m_id = [Dictionary objectForKey:@"id"];
        object.m_interest = [Dictionary objectForKey:@"interest"];
        object.m_teacher = [Dictionary objectForKey:@"teacher"];
        object.m_support = [Dictionary objectForKey:@"support"];
        
        return object;
    }
    return nil;
}

@end