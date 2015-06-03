//
//  RegisterModel.m
//  JXL
//
//  Created by BooB on 15-5-2.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "perfectMemberModel.h"
#import "NSData+MKBase64.h"
#import "GlobalData.h"

@implementation Req_PerfectMember
DEF_SINGLETON(Req_PerfectMember)

-(id)init
{
    self = [super init];
    if (self) {
        self.m_mid = @"";
        self.m_member_id = @"";
        self.m_is_password = @"";
        self.m_nickname = @"";
        self.m_password = @"";
        self.m_headpic = nil;
        self.m_name = @"";
        self.m_email = @"";
        self.m_age = @"22";
        self.m_sex = @"3";
        self.m_type = @"1";
        self.m_schoolid = @"";
        self.m_teacher = @"";
        self.m_id = @"";
    }
    return self;
}
@end

@implementation RES_PerfectMember

@end

@implementation perfectMemberModel

/**
 *   age = 77;
 email = "787038442@qq.com";
 headpic = "<null>";
 id = 87;
 "is_password" = 123456;
 "member_id" = 0087;
 nickname = nonato;
 password = 405724d94a9cd3445e01d6d1b244c553;
 sex = 1;
 type = 1;
 typeName = "\U666e\U901a\U7528\U6237";
 
 age = 77;
 email = "787038442@qq.com";
 headpic = NULL;
 id = "<null>";
 "is_project" = 0;
 memberId = 0087;
 mid = 87;
 nickname = nonato;
 phone = 15920549038;
 typeId = 2;
 typeName = "\U53c2\U8d5b\U9009\U624b";
 
 
 province = "<null>";
 schoolCity = "<null>";
 schoolId = "<null>";
 schoolName = "<null>";
 sex = "\U5973";
 teacher = "<null>";
 
 }
 
 //图片上传后返回的东东
 {
 "headpic": {
 "headpic": {
 "name": ".jpg",
 "type": "application/x-jpg",
 "tmp_name": "/tmp/php9q3yeF",
 "error": 0,
 "size": 67100
 },
 "status": 1,
 "url": "/d/file/member/554c2e776c895.jpg"
 },
 "id": "111"
 }
 
 */

+(RES_PerfectMember *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSDictionary class]]) {
        RES_PerfectMember * object= [[RES_PerfectMember alloc] init];
        object.m_age            =  [Dictionary objectForKey:@"age"];
        object.m_email          = [Dictionary objectForKey:@"email"];
//        NSDictionary      * headpicdic = [Dictionary objectForKey:@"headpic"];
//        object.m_headpic        = [headpicdic objectForKey:@"url"];//得到图片路径
        OBJECT_SETTER_FROM_DIC(object, headpic, Dictionary)
        object.m_id             = [Dictionary objectForKey:@"id"];
        object.m_is_password    = [Dictionary objectForKey:@"is_password"];
        
        object.m_nickname       = [Dictionary objectForKey:@"nickname"];
        object.m_password       = [Dictionary objectForKey:@"password"];
        object.m_sex            = [Dictionary objectForKey:@"sex"];
        object.m_type           = [Dictionary objectForKey:@"type"];
        object.m_typeName       = [Dictionary objectForKey:@"typeName"];
        object.m_province       = [Dictionary objectForKey:@"province"];
        object.m_schoolCity     = [Dictionary objectForKey:@"schoolCity"];
        object.m_schoolId       = [Dictionary objectForKey:@"schoolId"];
        object.m_schoolName     = [Dictionary objectForKey:@"schoolName"];
        object.m_teacher        = [Dictionary objectForKey:@"teacher"];
        object.m_interest       = [Dictionary objectForKey:@"interest"];
        object.m_support        = [Dictionary objectForKey:@"support"];
//
        
        return object;
    }
    return nil;
}

+(void)perfectMemberWith:(NSString *)mid
                password:(NSString *)password
                 headpic:(NSData *)headpic
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
            errorHandler:(void (^)(NSError * error))err
{
    
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                 password:password
                                                  headpic:headpic
                                                 nickname:nickname
                                                    email:email
                                                      age:age
                                                      sex:sex
                                                     type:type
                                                 schoolid:schoolid
                                                  teacher:teacher
                                                       id:identify
                                                 interest:interest
                                                  support:support
                                                 response:response
                                             errorHandler:err];
}

+(void)perfectMemberWithchoolid:(NSString *)schoolid
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                        password:nil
                                                         headpic:nil
                                                        nickname:nil
                                                           email:nil
                                                             age:nil
                                                             sex:nil
                                                            type:type
                                                        schoolid:schoolid
                                                         teacher:nil
                                                              id:nil
                                                        interest:nil
                                                         support:nil
                                                        response:response
                                                    errorHandler:err];
}
+(void)perfectMemberWithNickName:(NSString *)nickname
                        response:(void (^)(NSDictionary * Dictionary))response
                    errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                 password:nil
                                                  headpic:nil
                                                 nickname:nickname
                                                    email:nil
                                                      age:nil
                                                      sex:nil
                                                     type:type
                                                 schoolid:nil
                                                  teacher:nil
                                                       id:nil
                                                 interest:nil
                                                  support:nil
                                                 response:response
                                             errorHandler:err];
}


+(void)perfectMemberWithteacher:(NSString *)teacher
                   response:(void (^)(NSDictionary * Dictionary))response
               errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                        password:nil
                                                         headpic:nil
                                                        nickname:nil
                                                           email:nil
                                                             age:nil
                                                             sex:nil
                                                            type:type
                                                        schoolid:nil
                                                         teacher:teacher
                                                              id:nil
                                                        interest:nil
                                                         support:nil
                                                        response:response
                                                    errorHandler:err];
}

+(void)perfectMemberWithheadpic:(NSData *)headpic
                        response:(void (^)(NSDictionary * Dictionary))response
                    errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    NSString * password = [GlobalData sharedInstance].m_password;
    
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                 password:password
                                                  headpic:headpic
                                                 nickname:nil
                                                    email:nil
                                                      age:nil
                                                      sex:nil
                                                     type:type
                                                 schoolid:nil
                                                  teacher:nil
                                                       id:nil
                                                 interest:nil
                                                  support:nil
                                                 response:response
                                             errorHandler:err];
}

+(void)perfectMemberWithsex:(NSString *)sex
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                 password:nil
                                                  headpic:nil
                                                 nickname:nil
                                                    email:nil
                                                      age:nil
                                                      sex:sex
                                                     type:type
                                                 schoolid:nil
                                                  teacher:nil
                                                       id:nil
                                                 interest:nil
                                                  support:nil
                                                 response:response
                                             errorHandler:err];
}

+(void)perfectMemberWithage:(NSString *)age
                   response:(void (^)(NSDictionary * Dictionary))response
               errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                 password:nil
                                                  headpic:nil
                                                 nickname:nil
                                                    email:nil
                                                      age:age
                                                      sex:nil
                                                     type:type
                                                 schoolid:nil
                                                  teacher:nil
                                                       id:nil
                                                 interest:nil
                                                  support:nil
                                                 response:response
                                             errorHandler:err];
}

//普通会员升级到参赛选手
+(void)perfectMemberWithTypeID:(NSString *)type
                   response:(void (^)(NSDictionary * Dictionary))response
               errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
//    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                        password:nil
                                                         headpic:nil
                                                        nickname:nil
                                                           email:nil
                                                             age:nil
                                                             sex:nil
                                                            type:type
                                                        schoolid:nil
                                                         teacher:nil
                                                              id:nil
                                                        interest:nil
                                                         support:nil
                                                        response:response
                                                    errorHandler:err];
}


+(void)perfectMemberWithidentify:(NSString *)identify
                   response:(void (^)(NSDictionary * Dictionary))response
               errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                        password:nil
                                                         headpic:nil
                                                        nickname:nil
                                                           email:nil
                                                             age:nil
                                                             sex:nil
                                                            type:type
                                                        schoolid:nil
                                                         teacher:nil
                                                              id:identify
                                                        interest:nil
                                                         support:nil
                                                        response:response
                                                    errorHandler:err];
}


+(void)perfectMemberWithinterest:(NSString *)interest
                   response:(void (^)(NSDictionary * Dictionary))response
               errorHandler:(void (^)(NSError * error))err
{
    NSString * mid = [GlobalData sharedInstance].m_mid;
    NSString * type = [GlobalData sharedInstance].m_login_info.m_typeId;
    [[HTTPSEngine sharedInstance] fetch_perfectMemberByParamWith:mid
                                                 password:nil
                                                  headpic:nil
                                                 nickname:nil
                                                    email:nil
                                                      age:nil
                                                      sex:nil
                                                     type:type
                                                 schoolid:nil
                                                  teacher:nil
                                                       id:nil
                                                 interest:interest
                                                  support:nil
                                                 response:response
                                             errorHandler:err];
}


+(NSString *)imageBase64:(UIImage *)imgage
{
    NSData * data = UIImageJPEGRepresentation(imgage, 0.5);
    return [data base64EncodedString];
}

+(NSData *)imagedata:(UIImage *)imgage
{
    NSData * data = UIImageJPEGRepresentation(imgage, 0.5);
    return data;
}

@end

@implementation RES_Login_Info
@end

@implementation LoginModel

/**
  {"mid":"113","memberId":"0113","is_project":0,"phone":"15920549036","headpic":"NULL","nickname":"Ghg","sex":"","age":"22","typeId":"1","typeName":"\u666e\u901a\u7528\u6237","email":"Rr@qq.com"}
 AS_NSSSTRING(email)
 AS_NSSSTRING(province)
 AS_NSSSTRING(schoolId)
 AS_NSSSTRING(schoolCity)
 AS_NSSSTRING(schoolName)
 AS_NSSSTRING(_id)
 AS_NSSSTRING(teacher)
 
 AS_NSSTRING(interest)
 AS_NSSTRING(introduce)
 AS_NSSTRING(support)
 */

+(RES_Login_Info *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[Dictionary class]]) {
        RES_Login_Info * object= [[RES_Login_Info alloc] init];
        
        NSLog(@"%@",DIC_KEY(Dictionary,mid));
        OBJECT_SETTER_FROM_DIC(object, mid,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, memberId,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, is_project,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, phone,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, headpic,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, nickname,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, sex,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, age,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, typeId,Dictionary)
        
        OBJECT_SETTER_FROM_DIC(object,typeName,Dictionary)
        OBJECT_SETTER_FROM_DIC(object, email, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, province, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, schoolId, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, schoolCity, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, schoolName, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, _id, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, teacher, Dictionary)
        
        OBJECT_SETTER_FROM_DIC(object, interest, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, introduce, Dictionary)
        OBJECT_SETTER_FROM_DIC(object, support, Dictionary)
        return object;
    }
    return nil;
}

@end

@implementation SupportType
@end

@implementation SupportTypeModel

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary
{
    if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
        
        NSArray * array = (NSArray *)Dictionary;
        NSMutableArray * ctrs  = [NSMutableArray arrayWithCapacity:0];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            SupportType * su= [[SupportType alloc] init];
            OBJECT_SETTER_FROM_DIC(su, _id, obj)
            OBJECT_SETTER_FROM_DIC(su, name, obj)
            [ctrs addObject:su];
        }];
        return ctrs;
    }
    return nil;
}

@end