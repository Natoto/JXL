//
//  RegisterModel.h
//  JXL
//
//  Created by BooB on 15-5-2.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXL_Define.h"
#import "ArchiveObject.h"
#import "HTTPSEngine.h"
/**
 * mid : 会员ID(*)
 【公共基础信息】
 password : 密码(*)
 headpic : 头像(*)
 nickname : 姓名(*)
 email : 邮箱(*)
 age : 年龄
 sex : 性别
 type : 会员类型(*)(1普通、2参赛选手、3投资人)
 【参赛人】
 schoolid : 学校ID(*)
 teacher : 指导教师(*)
 id : 身份证号(*)
 【投资人】
 【公共基础信息】
 mid:会员id,
 member_id://展示会员id,
 password://已经加密的密码,
 is_password://未加密的密码
 headpic : //头像,
 nickname : //姓名,
 email :// 邮箱,
 age : //年龄,
 sex : //性别(1男、2女、3未知),
 type : //会员类型(*)(1普通、2参赛选手、3投资人)
 【参赛人】
 schoolid : //学校ID,
 teacher : //指导教师,
 id : //身份证号,
 【投资人】
 interest : //感兴趣项目,
 support :// 资助类型,interest : 感兴趣项目(*)
 support : //资助类型(*)
 */

#define REQ_MEMBERTYPE_NORMAL @"1"
#define REQ_MEMBERTYPE_PLAYER @"2"
#define REQ_MEMBERTYPE_VC     @"3"
 
#define KEY_MEMBERTYPE_NORMAL @"普通会员"
#define KEY_MEMBERTYPE_PLAYER @"参赛选手"
#define KEY_MEMBERTYPE_VC     @"投资人"

#define VALUE_MEMBER_NORMAL @"1"
#define VALUE_MEMBERTYPE_PLAYER @"2"
#define VALUE_MEMBERTYPE_VC @"3"

//@"出力",@"出钱",@"出钱又出力"
#define KEY_ZIZHUTYPE_CHULI @"出力"
#define KEY_ZIZHUTYPE_CHUQIAN @"出钱"
#define KEY_ZIZHUTYPE_CHULIANDQIAN @"出钱又出力"

#define KEY_SEX_MAN @"男"
#define KEY_SEX_WOMAN @"女"
#define KEY_SEX_UNKNOW @"保密"

#define VALUE_SEX_MAN @"1"
#define VALUE_SEX_WOMAN @"2"
#define VALUE_SEX_UNKNOW @"3"

@interface Req_PerfectMember : NSObject
AS_SINGLETON(Req_PerfectMember)
//公共信息
@property(nonatomic,strong) NSString * m_mid; ////
@property(nonatomic,strong) NSString * m_member_id;     //展示会员id,
@property(nonatomic,strong) NSString * m_is_password;   //已经加密的密码,
@property(nonatomic,strong) NSString * m_nickname;      //姓名,                   1

@property(nonatomic,strong) NSString * m_password;       //未加密密码
@property(nonatomic,strong) NSData   * m_headpic;       //头像                    1
@property(nonatomic,strong) NSString * m_name;          //姓名,
@property(nonatomic,strong) NSString * m_email;         //邮箱                    1
@property(nonatomic,strong) NSString * m_age;           //年龄
@property(nonatomic,strong) NSString * m_sex;           //性别 性别(1男、2女、3未知)
@property(nonatomic,strong) NSString * m_type;          //会员类型(*)(1普通、2参赛选手、3投资人)   1

//参赛人
@property(nonatomic,strong) NSString * m_schoolid;      //学校ID
@property(nonatomic,strong) NSString * m_teacher;       //指导教师,
@property(nonatomic,strong) NSString * m_id;            //身份证号(*)

//投资人
@property(nonatomic,strong) NSString * m_interest;
@property(nonatomic,strong) NSString * m_support;

@end


@class RES_PerfectMember;

@interface perfectMemberModel : NSObject

+(RES_PerfectMember *)encodeDiction:(NSDictionary *)Dictionary;


+(void)perfectMemberWith:(NSString *)mid
                      password:(NSString *)password
                       headpic:(NSData   *)headpic
                      nickname:(NSString *)nickname
                         email:(NSString *)email
                           age:(NSString *)age
                           sex:(NSString *)sex
                          type:(NSString *)type
                      schoolid:(NSString *)schoolid
                       teacher:(NSString *)teacher
                            id:(NSString *)identify
                      interest:(NSString *)interest
                       support:(NSString *)support
                      response:(void (^)(NSDictionary * Dictionary))response
                  errorHandler:(void (^)(NSError * error))err;


+(void)perfectMemberWithNickName:(NSString *)nickname
                        response:(void (^)(NSDictionary * Dictionary))response
                    errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithheadpic:(NSData *)headpic
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithsex:(NSString *)sex
                   response:(void (^)(NSDictionary * Dictionary))response
               errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithage:(NSString *)age
                   response:(void (^)(NSDictionary * Dictionary))response
               errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithinterest:(NSString *)interest
                        response:(void (^)(NSDictionary * Dictionary))response
                    errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithteacher:(NSString *)teacher
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithchoolid:(NSString *)teacher
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithidentify:(NSString *)identify
                        response:(void (^)(NSDictionary * Dictionary))response
                    errorHandler:(void (^)(NSError * error))err;

+(void)perfectMemberWithTypeID:(NSString *)type
                      response:(void (^)(NSDictionary * Dictionary))response
                  errorHandler:(void (^)(NSError * error))err;

+(NSString *)imageBase64:(UIImage *)imgage;
+(NSData *)imagedata:(UIImage *)imgage;
@end


@interface RES_PerfectMember : ArchiveObject
@property(nonatomic,retain) NSNumber * m_age;// = 77;
@property(nonatomic,retain) NSString * m_email;// = "787038442@qq.com";
@property(nonatomic,retain) NSString * m_headpic;// = "<null>";
@property(nonatomic,retain) NSString * m_id;// = 87;
@property(nonatomic,retain) NSString * m_is_password;//" = 123456;
@property(nonatomic,retain) NSString * m_member_id;//" = 0087;
@property(nonatomic,retain) NSString * m_nickname;// = nonato;
@property(nonatomic,retain) NSString * m_password;// = 405724d94a9cd3445e01d6d1b244c553;
@property(nonatomic,retain) NSNumber * m_sex;// = 1;
@property(nonatomic,retain) NSNumber * m_type;// = 1;
@property(nonatomic,retain) NSString * m_typeName;// = "\U666e\U901a\U7528\U6237";


@property(nonatomic,retain) NSString * m_province;
@property(nonatomic,retain) NSString * m_schoolCity;
@property(nonatomic,retain) NSString * m_schoolId;
@property(nonatomic,retain) NSString * m_schoolName;
@property(nonatomic,retain) NSString * m_teacher;

@property(nonatomic,retain) NSString * m_interest;
@property(nonatomic,retain) NSString * m_support;
@end

// {"mid":"113","memberId":"0113","is_project":0,"phone":"15920549036","headpic":"NULL","nickname":"Ghg","sex":"","age":"22","typeId":"1","typeName":"\u666e\u901a\u7528\u6237","email":"Rr@qq.com"}

//{"mid":"111","memberId":"0111","is_project":0,"phone":"15920549038","headpic":"NULL","nickname":"Ooo","sex":"\u7537","age":"12","typeId":"2","typeName":"\u53c2\u8d5b\u9009\u624b","email":"Fgggh@qq.com","province":null,"schoolId":"1199","teacher":"Dfgg","id":"2277322455","schoolCity":"\u5de2\u6e56\u5e02","schoolName":"\u5408\u80a5\u804c\u4e1a\u6280\u672f\u5b66\u9662"}

//{"mid":"115","memberId":"0115","is_project":0,"phone":"15920549039","headpic":"NULL","nickname":"\u4e52\u4e52\u4e53\u4e53","sex":"\u7537","age":"36","typeId":"3","typeName":"\u6295\u8d44\u4eba","email":"gkooo@qq.cn","interest":null,"introduce":null,"support":null}

@interface RES_Login_Info : ArchiveObject

AS_NSSTRING(mid);
AS_NSSTRING(memberId);
AS_NSSTRING(is_project);
AS_NSSTRING(phone);
AS_NSSTRING(headpic);
AS_NSSTRING(nickname);
AS_NSSTRING(sex);
AS_NSSTRING(age);
AS_NSSTRING(typeId) // type : 会员类型(*)(1普通、2参赛选手、3投资人)
AS_NSSTRING(typeName)
AS_NSSTRING(email)
AS_NSSTRING(province)
AS_NSSTRING(schoolId)
AS_NSSTRING(schoolCity)
AS_NSSTRING(schoolName)
AS_NSSTRING(_id)
AS_NSSTRING(teacher)
 
AS_NSSTRING(interest)
AS_NSSTRING(introduce)
AS_NSSTRING(support)

@end

@interface LoginModel : NSObject

+(RES_Login_Info *)encodeDiction:(NSDictionary *)Dictionary;
@end

@interface SupportType : ArchiveObject
AS_NSSTRING(_id)
AS_NSSTRING(name)
@end

@interface SupportTypeModel : NSObject
+(NSArray *)encodeDiction:(NSDictionary *)Dictionary;

@end

