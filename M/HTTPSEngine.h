//
//  AuthTestEngine.h
//  MKNetworkKit-iOS-Demo
//
//  Created by Mugunth Kumar on 4/12/11.
//  Copyright (c) 2011 Steinlogic. All rights reserved.
//



#import "JXL_Define.h"
#import "MKNetworkKit.h"
#import <Foundation/Foundation.h>
#import "APIBaseObject.h"
/*!
 @header HTTPSEngine
 @abstract   Represents a subclassable Network Engine for your app
 */

/*!
 *  @class HTTPSEngine
 *  @abstract  huangbo  Represents a subclassable Network Engine for your app
 *
 *  @discussion
 *	请求网络模块
 *  用到了MKNetworkEngin
 *  主要是注册 登录 请求等操作。。。
 */


//type的选择
static NSString * fetch_messge_type_news = @"news";
static NSString * fetch_messge_type_project = @"project";
static NSString * fetch_messge_type_active=@"active";


@interface HTTPSEngine : MKNetworkEngine
AS_SINGLETON(HTTPSEngine);

-(void)queryNetWorkWithKey:(NSString *)key
                   urlpath:(NSString *)path
                     param:(NSDictionary *)param
                httpMethod:(NSString *)httpMethod
                  usecache:(BOOL)cache
                     photo:(NSData *)photodata
                  photokey:(NSString *)photokey
                jsonstring:(void (^)(NSString * jsonstring))response
              errorHandler:(void (^)(NSError * error))err;


//-(id) initWithDefaultSettings;
-(void) serverTrustTest;
-(void) clientCertTest;


/*!
 * TODO: 注册账号 phone
 */
-(void)fetch_regMember:(NSString *)phone response:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err;

/**
 * 新闻栏目(catList)
 */
-(void)fetch_catList:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err;

/**
 * 得到广告分类
 http://112.74.78.166/api.php?m=App&a=advertiseType
 */
-(void)fetch_advertiseType:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err;

/**
 *TODO: 广告信息列表（advertiseList)
 /api.php?m=App&a=advertiseList
 catid”:广告栏目catid(*) 可选,
 “type”:广告类型(*),
 广告就只有新闻，项目，活动的，所以数据库是type分别是1,2,3，传4就可以得到首页广告
 */
-(void)fetch_advertiseListWithType:(NSString *)type catid:(NSString *)catid response:(void (^)(NSDictionary * Dictionary))response  errorHandler:(void (^)(NSError * error))err;



/*!
 *  @abstract  注册短信验证码（sendMessage)
 /api.php?m=App&a=sendMessage
 phone:手机号码(*)，
 */
-(void)fetch_sendMessageWithPhone:(NSString *)phone response:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err;

/*!
 * @abstract
 */

/*!
 *  @class HTTPSEngine
 *  @abstract
 TODO: 批量完善信息(参赛人、投资人) (perfectMember)
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
 interest : 感兴趣项目(*)
 *
 *  @discussion
 *	请求网络模块
 *  用到了MKNetworkEngin
 *  主要是注册 登录 请求等操作。。。
 */
-(void)fetch_perfectMemberWith:(NSString *)mid
                      password:(NSString *)password
                       headpic:(NSData *)headpic
                      nickname:(NSString *)nickname
                         email:(NSString *)email
                           age:(NSString *)age
                           sex:(NSString *)sex
                          type:(NSString *)type
                      schoolid:(NSString *)schoolId
                       teacher:(NSString *)teacher
                            id:(NSString *)_id
                      interest:(NSString *)interest
                       support:(NSString *)support
                      response:(void (^)(NSDictionary * Dictionary))response
                  errorHandler:(void (^)(NSError * error))err;

/**
 * 选择性修改某一项
 */
-(void)fetch_perfectMemberByParamWith:(NSString *)mid
                             password:(NSString *)password
                              headpic:(NSData *)headpic
                             nickname:(NSString *)nickname
                                email:(NSString *)email
                                  age:(NSString *)age
                                  sex:(NSString *)sex
                                 type:(NSString *)type
                             schoolid:(NSString *)schoolId
                              teacher:(NSString *)teacher
                                   id:(NSString *)_id
                             interest:(NSString *)interest
                              support:(NSString *)support
                             response:(void (^)(NSDictionary * Dictionary))response
                         errorHandler:(void (^)(NSError * error))err;

/**
 * 会员登录 (loginMember)
 /api.php?m=App&a= loginMember
 phone : 手机号(*)
 email:邮箱,(邮箱或者手机号码二选一)
 password : 密码(*)
 */

-(void)fetch_loginMemberWithPhone:(NSString *)phone
                            email:(NSString *)email
                         password:(NSString *)password
                         response:(void (^)(NSDictionary * Dictionary))response
                     errorHandler:(void (^)(NSError * error))err;



/**
 * 新闻列表(newsList)
 /api.php?m=App&a= newsList
 catid:新闻栏目id(*)
 “page”:第几页数
 “pagesize”:页数大小
 */
-(void)fetch_newsListWithcatid:(NSString *)catid
                          page:(NSInteger )page
                      pagesize:(NSInteger )pagesize
                      response:(void (^)(NSDictionary * Dictionary))response
                  errorHandler:(void (^)(NSError * error))err;

/**
 * 项目类型列表(projectTypeList)
 * projectTypeList
 * /api.php?m=App&a=projectTypeList
 */
-(void)fetch_projectTypeList:(void (^)(NSDictionary * Dictionary))response
                errorHandler:(void (^)(NSError * error))err;


/**
 * 项目列表(projectList)
 * /api.php?m=App&a=projectList
 *  typeid:项目类型id(*)
 */

-(void)fetch_projectList:(NSString *)typeid
                response:(void (^)(NSDictionary * Dictionary))response
            errorHandler:(void (^)(NSError * error))err;

/**
 *指定ID查找单条新闻(findNewsById)
 /api.php?m=App&a= findNewsById
 news_id:新闻id(*)
 mid:会员id.
 */

-(void)fetch_findNewsByIdWithID:(NSString *)news_id
                            mid:(NSString *)mid
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err;


/**
 * 新闻评论列表(newsCommentList)
 * /api.php?m=App&a=newsCommentList
 “cid”:新闻栏目id（*）,
 “type”:类型名称(*)(news表示新闻);
 “pagesize”:每页大小;
 “page”:第几页;
 */

-(void)fetch_newsCommentListWithcid:(NSString *)cid
                               type:(NSString *)type
                               page:(NSInteger)page
                           pagesize:(NSInteger)pagesize
                           response:(void (^)(NSDictionary * Dictionary))response
                       errorHandler:(void (^)(NSError * error))err;


/**
 新闻评论操作(newsComment)
 /api.php?m=App&a= newsComment
 * “cid”:项目id(*),
 “mid”:会员id(*),
 “content”:评论内容(*),
 “type”:类型名称为项目project(*),
 “reply_id”:回复评论id(*)(回复的是哪条评论),
 “reply_mid”:回复人的会员id(*)
 */
-(void)fetch_newscommentWithCid:(NSString *)cid
                            mid:(NSString *)mid
                        content:(NSString *)content
                           type:(NSString *)type
                       reply_id:(NSString *)reply_id
                      reply_mid:(NSString *)reply_mid
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err;

/**
 * 指定ID查找单个项目(findProjectById)
 * /api.php?m=App&a=findProjectById
 *  id:项目id(*),
 */
//-(void)fetch_findProjectById:(NSString *)m_id\
                         mid:(NSString *)m_mid\
                    response:(void (^)(NSDictionary * Dictionary))response\
                errorHandler:(void (^)(NSError * error))err; 

-(void)fetch_findProjectById:(NSString *)m_id
                         mid:(NSString *)m_mid
                  jsonstring:(void (^)(NSString * jsonstring))jsonsresponse
                errorHandler:(void (^)(NSError * error))err;
/**
 * 资助类型列表(supportTypeList)
/api.php?m=App&a=supportTypeList
 * 返回{
 “id” : 资助类型ID,
 “name” : 资助类型名称,
 },…]
 */
-(void)fetch_supportTypeList:(void (^)(NSDictionary * Dictionary))response
                errorHandler:(void (^)(NSError * error))err;


///**
// * 首页项目查询
// /api.php?m=Home&a=projectSearch
// page：页码
// schoolId：学校ID
// typeId：项目类型ID
// demand：(‘合作’,’融资’)
// money：资金范围(1,2)
// */
//-(void)fetch_projectSearchWith:(NSString *)page
//                      schoolId:(NSString *)schoolId
//                        typeId:(NSString *)typeId
//                        demand:(NSString *)demand
//                         money:(NSString *)money
//                      response:(void (^)(NSDictionary * Dictionary))response
//                  errorHandler:(void (^)(NSError * error))err;


/**
 *  首页数据
 /api.php?m=Home&a=index
 */
-(void)fetch_homeIndex:(void (^)(NSDictionary * Dictionary))response
errorHandler:(void (^)(NSError * error))err;


/**
 *项目提交(project)
 /api.php?m=App&a=project
 img图片数组,
 mid:会员id(*),
 name：项目名称(*)
 typeId：项目类型id(*)
 description:项目描述
 schoolId:学校id(*)
 demand:项目需求枚举类型(寻求合作，找导师，找员工，寻找资金).
 money:项目资金(*),
 teamInfo:团队信息,
 teamName:团队名称(*),
 teamMembers:团队成员id(id之间以逗号隔开),
 teamManageId:团队负责人id(当前提交项目的会员id)
 */

-(void)fetch_uploadprojectWithmid:(NSString *)mid
                      projectname:(NSString *)name
                           typeId:(NSString *)typeId
               projectdescription:(NSString *)description
                    projectdemand:(NSString *)demand
                            money:(NSString *)money
                         schoolId:(NSString *)schoolId
                         teamInfo:(NSString *)teamInfo
                         teamName:(NSString *)teamName
                      teamMembers:(NSString *)teamMembers
                     teamManageId:(NSString *)teamManageId
                         imgdatas:(NSArray  *)imgs
                         response:(void (^)(NSDictionary * Dictionary))response
                     errorHandler:(void (^)(NSError * error))err;

#pragma mark - 请求方式升级了  返回json。。。
/**
 *  会员基本信息(memberList)
 * /api.php?m=App&a=memberList
 * 请求参数说明	 “mid”:会员id(*),
 *
 */
-(void)fetch_memberList:(NSString *)mid
                  response:(void (^)(NSString * responsejson))response
              errorHandler:(void (^)(NSError * error))err;
 


/**
 *
 会员评论信息(memberCommnets)
 /api.php?m=App&a=memberCommnets 
 “mid”:会员id(*),
 */
-(void)fetch_memberCommnets:(NSString *)mid
               response:(void (^)(NSString * responsejson))response
           errorHandler:(void (^)(NSError * error))err;





/**
 * 意见反馈（feedback)
 /api.php?m=App&a=feedback
 “mid”:会员mid(*),
 “phone”:电话号码(*),
 “content”:内容(*),
 */
-(void)fetch_feedbackWithmid:(NSString *)mid
                       phone:(NSString *)phone
                     content:(NSString *)content
                    response:(void (^)(NSString * responsejson))response
                errorHandler:(void (^)(NSError * error))err;


/**
 *  活动栏目(activityType)
 /api.php?m=App&a=activityType
 */
-(void)fetch_activityType:(void (^)(NSString * responsejson))response
                errorHandler:(void (^)(NSError * error))err;



/**
 * 活动列表(activityList)
 /api.php?m=App&a=activityList
 “catid”:活动栏目catid(*),
 “mid”:会员ID,
 “pagesize”:每页显示数,
 “page”:当前页
 */
-(void)fetch_activityListWithcatid:(NSString *)catid
                               mid:(NSString *)mid
                              page:(NSNumber *)page
                          pagesize:(NSNumber *)pagesize
                          response:(void (^)(NSString * responsejson))response
                      errorHandler:(void (^)(NSError * error))err;


/**
 * 活动报名(registActivity)  
 * /api.php?m=App&a=registActivity
 “id”:活动id(*),
 “mid”:会员ID(*),
 */
-(void)fetch_registActivityWithid:(NSString *)_id
                               mid:(NSString *)mid
                          response:(void (^)(NSString * responsejson))response
                      errorHandler:(void (^)(NSError * error))err;

/**
 * 取消活动(cancelActivity) 
 /api.php?m=App&a=cancelActivity
 “id”:活动id(*),
 “mid”:会员ID(*),
 */
-(void)fetch_cancelActivityWithid:(NSString *)_id
                              mid:(NSString *)mid
                         response:(void (^)(NSString * responsejson))response
                     errorHandler:(void (^)(NSError * error))err;


/**
 * 判断会员是否报名活动(isRegist) 
 /api.php?m=App&a=isRegist
 “id”:活动id(*),
 “mid”:会员ID(*),
 */
-(void)fetch_isRegistWithid:(NSString *)_id
                              mid:(NSString *)mid
                         response:(void (^)(NSString * responsejson))response
                     errorHandler:(void (^)(NSError * error))err;

/**
 * 会员（我）报名的活动信息(memberRegActivity)
 /api.php?m=App&a=memberRegActivity
 “mid”:会员id(*),
 */
-(void)fetch_memberRegActivityWithid:(NSString *)mid
                            response:(void (^)(NSString * responsejson))response
                        errorHandler:(void (^)(NSError * error))err;


/**
 * 首页项目查询
 
 URL	/api.php?m=Home&a=projectSearch
 请求方式	POST
 请求参数说明	page：页码
 schoolId：学校ID
 typeId：项目类型ID
 demand：需求(字符串) 找员工 找导师 寻找资金 寻求合作
 money：资金范围(1,2)
 keyword ：关键词
 */
-(void)fetch_projectSearchWithKey:(NSString *)keyword
                             page:(NSNumber *)page
                              schoolId:(NSString *)schoolId
                                typeId:(NSString *)typeId
                                demand:(NSString *)demand
                                 money:(NSString *)money
                            response:(void (^)(NSString * responsejson))response
                        errorHandler:(void (^)(NSError * error))err;


@end
