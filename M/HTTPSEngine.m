//
//  AuthTestEngine.m
//  MKNetworkKit-iOS-Demo
//
//  Created by Mugunth Kumar on 4/12/11.
//  Copyright (c) 2011 Steinlogic. All rights reserved.
//

/*!
 @header HTTPSEngine
 @abstract   Represents a subclassable Network Engine for your app
 */

/*!
 *  @class HTTPSEngine
 *  @abstract Represents a subclassable Network Engine for your app
 *
 *  @discussion
 *	This class is the heart of HTTPSEngine
 *  You create network operations and enqueue them here
 *  MKNetworkEngine encapsulates a Reachability object that relieves you of managing network connectivity losses
 *  MKNetworkEngine also allows you to provide custom header fields that gets appended automatically to every request
 */

#import "HTTPSEngine.h"
#import "NSDictionary_JSONExtensions.h"
#import "CacheCenter.h"
#import "GlobalData.h"
#import "HBSignalBus.h"
@implementation HTTPSEngine
DEF_SINGLETON(HTTPSEngine);

-(id)init
{
    self = [super initWithHostName:[GlobalData sharedInstance].m_hostname customHeaderFields:@{@"x-client-identifier" : @"iOS"}];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self\
                                                 selector:@selector(reachabilityChanged:)\
                                                     name:kReachabilityChangedNotification\
                                                   object:nil];
        ADD_NOTIFY_OBSERVER(self, kReachabilityChangedNotification)
    }
    return self;
}
//
ON_HANDEL_NOTIFY(kReachabilityChangedNotification, notify)
{
    Reachability * reachability = notify.object;
    if([reachability currentReachabilityStatus] == ReachableViaWiFi)
    {
    }
    else if([reachability currentReachabilityStatus] == ReachableViaWWAN)
    {
        if(self.wifiOnlyMode) {
        
        }
       
    }
    else if([reachability currentReachabilityStatus] == NotReachable)
    {
        DLog(@"%s Server  is not reachable",__func__);
    }
}

-(void)dealloc
{
    REMOVE_NOTIFY_OBSERVER(self, kReachabilityChangedNotification);
}
//整体的方法
-(void)queryNetWorkWithKey:(NSString *)key
                   urlpath:(NSString *)path
                     param:(NSDictionary *)param
                httpMethod:(NSString *)httpMethod
                  response:(void (^)(NSDictionary * Dictionary))response
              errorHandler:(void (^)(NSError * error))err
{
    
    [self queryNetWorkWithKey:key urlpath:path param:param httpMethod:httpMethod usecache:NO response:response errorHandler:err];
}

-(void)queryNetWorkWithKey:(NSString *)key
                   urlpath:(NSString *)path
                     param:(NSDictionary *)param
                httpMethod:(NSString *)httpMethod
                  usecache:(BOOL)cache
                     photo:(NSData *)photodata
                  photokey:(NSString *)photokey
                  response:(void (^)(NSDictionary * Dictionary))response
              errorHandler:(void (^)(NSError * error))err
{
    // [op addData:imageData forKey:@"Photo" mimeType:photoMimiType fileName:[NSString stringWithFormat:@"%d.%@",i,photoType]];
    MKNetworkOperation *op = [self operationWithPath:path params:param httpMethod:httpMethod ssl:NO];
    NSString * responsestring = nil;
    if (cache) {//TODO:一级缓存 如果后面没有写缓存机制可以用这个
        responsestring = GET_OBJECT_OF_USERDEFAULT(key);
        NSDictionary *cachedic = [NSDictionary dictionaryWithJSONString:responsestring error:nil];
        response(cachedic);
    }
    if (photodata && photokey) {
        [op addData:photodata forKey:photokey mimeType:@"application/x-jpg" fileName:@".jpg"];
    }
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        if (cache) {
            [self saveCache:operation.responseString key:key];
        }
        NSDictionary *dic = [NSDictionary dictionaryWithJSONString:operation.responseString error:nil];
        response(dic);
        DLog(@"%@", [operation responseString]);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        err(error);
        SEND_HBSIGNAL(NSStringFromClass([HTTPSEngine class]), @"networkerror", error.localizedDescription);
        DLog(@"%@", [error localizedDescription]);
    }];
    [self enqueueOperation:op];
}
//返回jsonstring
-(void)queryNetWorkWithKey:(NSString *)key
                   urlpath:(NSString *)path
                     param:(NSDictionary *)param
                httpMethod:(NSString *)httpMethod
                  usecache:(BOOL)cache
                     photo:(NSData *)photodata
                  photokey:(NSString *)photokey
                jsonstring:(void (^)(NSString * jsonstring))response
              errorHandler:(void (^)(NSError * error))err
{
    // [op addData:imageData forKey:@"Photo" mimeType:photoMimiType fileName:[NSString stringWithFormat:@"%d.%@",i,photoType]];
    MKNetworkOperation *op = [self operationWithPath:path params:param httpMethod:httpMethod ssl:NO];
    NSString * responsestring = nil;
    if (cache) {//TODO:一级缓存 如果后面没有写缓存机制可以用这个
        responsestring = GET_OBJECT_OF_USERDEFAULT(key);
        response(responsestring);
    }
    if (photodata && photokey) {
        [op addData:photodata forKey:photokey mimeType:@"application/x-jpg" fileName:@".jpg"];
    }
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        if (cache) {
            [self saveCache:operation.responseString key:key];
        }
        response(operation.responseString);
        DLog(@"%@", [operation responseString]);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        err(error);
        SEND_HBSIGNAL(NSStringFromClass([HTTPSEngine class]), @"networkerror", error.localizedDescription);
        DLog(@"%@", [error localizedDescription]);
    }];
    [self enqueueOperation:op];
}

//整体的方法 带有缓存的
-(void)queryNetWorkWithKey:(NSString *)key
                   urlpath:(NSString *)path
                     param:(NSDictionary *)param
                httpMethod:(NSString *)httpMethod
                  usecache:(BOOL)cache
                  response:(void (^)(NSDictionary * Dictionary))response
              errorHandler:(void (^)(NSError * error))err
{
    [self queryNetWorkWithKey:key urlpath:path param:param httpMethod:httpMethod usecache:cache photo:nil photokey:nil response:response errorHandler:err];
}

-(void)saveCache:(NSString *)responstring key:(NSString *)key
{
    DLog(@"保存数据 %@",key);
    SET_OBJECT_OF_USERDEFAULT(responstring, key);
}

-(void) clientCertTest {
    
    MKNetworkOperation *op = [self operationWithPath:@"/" params:nil httpMethod:nil ssl:YES];
    op.clientCertificate = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"client.p12"];
    op.clientCertificatePassword = @"test";
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        
        DLog(@"%@", [operation responseString]);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        DLog(@"%@", [error localizedDescription]);
    }];
    [self enqueueOperation:op];
}

-(void) serverTrustTest {
  
  MKNetworkOperation *op = [self operationWithPath:@"/api.php?m=App&a=supportTypeList" params:nil httpMethod:@"POST" ssl:NO];
  
  [op addCompletionHandler:^(MKNetworkOperation *operation) {
    
    DLog(@"%@", [operation responseString]); 
  } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
    
    DLog(@"%@", [error localizedDescription]);         
  }];
  [self enqueueOperation:op];
}


/**
 * TODO: 注册账号 phone
 */
-(void)fetch_regMember:(NSString *)phone response:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err
{
    [self queryNetWorkWithKey:@"regMember" urlpath:@"/api.php?m=App&a=regMember"  param:@{@"phone":phone}  httpMethod:@"POST" usecache:NO response:response errorHandler:err];
}


/**
 * TODO: 注册短信验证码（sendMessage)
 /api.php?m=App&a=sendMessage
 phone:手机号码(*)，
 */
-(void)fetch_sendMessageWithPhone:(NSString *)phone response:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err
{
    [self queryNetWorkWithKey:@"sendMessage" urlpath:@"/api.php?m=App&a=sendMessage"  param:@{@"phone":phone} httpMethod:@"POST" usecache:NO response:response errorHandler:err];
}


/**
 * TODO: 批量完善信息(参赛人、投资人) (perfectMember)
 mid : 会员ID(*)
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
 
 return
 //完善信息
 //
 //例子
 [[HTTPSEngine sharedInstance] fetch_perfectMemberWith:@"89"
 password:@"123456"
 headpic:@""
 nickname:@"nonato"
 email:@"787038442@qq.com"
 age:@"77"
 sex:@"1"
 type:@"2"
 schoolid:@"2724"
 teacher:@"谭浩强"
 id:@"362201198899995555"
 interest:@"2"
 response:^(NSDictionary *Dictionary) {
 
 NSString * errorstr = [Dictionary objectForKey:@"errorId"];
 if (errorstr) {
  }
 else
 {
 }
 NSLog(@"%@",Dictionary);
 
 } errorHandler:^(NSError *error) {
 
 }];
 */
#define OBJ_NOT_NULL_ADD_DIC(OBJ,DIC)  if(OBJ) {[DIC setObject:OBJ forKey:[@#OBJ  stringByReplacingOccurrencesOfString:@"_" withString:@""]];}
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
            errorHandler:(void (^)(NSError * error))err
{
    
    if (!mid  || !type ) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
     }
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
    ;
    OBJ_NOT_NULL_ADD_DIC(type,params)
    OBJ_NOT_NULL_ADD_DIC(mid,params)
    OBJ_NOT_NULL_ADD_DIC(password,params)
    
    OBJ_NOT_NULL_ADD_DIC(email,params)
    OBJ_NOT_NULL_ADD_DIC(sex,params)
    OBJ_NOT_NULL_ADD_DIC(age,params)
    OBJ_NOT_NULL_ADD_DIC(nickname,params)
//    OBJ_NOT_NULL_ADD_DIC(headpic,params)
    
    OBJ_NOT_NULL_ADD_DIC(schoolId,params)
    OBJ_NOT_NULL_ADD_DIC(teacher,params)
    OBJ_NOT_NULL_ADD_DIC(_id,params)
    OBJ_NOT_NULL_ADD_DIC(interest,params)
    OBJ_NOT_NULL_ADD_DIC(support,params)
    
    [self queryNetWorkWithKey:@"perfectMember" urlpath:@"/api.php?m=App&a=perfectMember"  param:params httpMethod:@"POST" usecache:NO  photo:headpic photokey:@"headpic"  response:response errorHandler:err];
}

/**
 * 带参数的完善消息
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
                  errorHandler:(void (^)(NSError * error))err
{
    
    if (!mid  || !type ) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
    ;
    OBJ_NOT_NULL_ADD_DIC(type,params)
    OBJ_NOT_NULL_ADD_DIC(mid,params)
    OBJ_NOT_NULL_ADD_DIC(password,params)
    
    OBJ_NOT_NULL_ADD_DIC(email,params)
    OBJ_NOT_NULL_ADD_DIC(sex,params)
    OBJ_NOT_NULL_ADD_DIC(age,params)
    OBJ_NOT_NULL_ADD_DIC(nickname,params)
//    OBJ_NOT_NULL_ADD_DIC(headpic,params)
    
    OBJ_NOT_NULL_ADD_DIC(schoolId,params)
    OBJ_NOT_NULL_ADD_DIC(teacher,params)
    OBJ_NOT_NULL_ADD_DIC(_id,params)
    OBJ_NOT_NULL_ADD_DIC(interest,params)
    OBJ_NOT_NULL_ADD_DIC(support,params)
    
    [self queryNetWorkWithKey:@"perfectMemberByParam" urlpath:@"/api.php?m=App&a=perfectMemberByParam"  param:params  httpMethod:@"POST" usecache:NO photo:headpic photokey:@"headpic" response:response errorHandler:err];
}




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
                     errorHandler:(void (^)(NSError * error))err

{
    if (!phone || ! password) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSDictionary * params = @{\
                              @"phone":phone,\
                              @"password":password,\
                              };
    if (email) {
        params = @{\
                   @"phone":phone,\
                   @"password":password,\
                   @"email":email};
    }
    
    [self queryNetWorkWithKey:@"loginMember" urlpath:@"/api.php?m=App&a=loginMember"  param:params httpMethod:@"POST" usecache:NO response:response errorHandler:err];
    
}

-(NSMutableDictionary *)stringcompantsToDiction:(NSArray *)array
{
      NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    for (int index = 0; index < array.count; index=index + 2) {
        NSString * akey = [NSString stringWithFormat:@"%@",[array objectAtIndex:index]];
        NSString * avalue = [array objectAtIndex:index + 1];
        if (akey.length && avalue.length) {
            [dict setObject:avalue forKey:akey];
        }
    }
    return dict;
}

/**
 * TODO: 新闻栏目(catList)
 */
-(void)fetch_catList:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err
{
    [self queryNetWorkWithKey:@"catList" urlpath:@"/api.php?m=App&a=catList"  param:nil  httpMethod:@"POST" usecache:YES   response:response errorHandler:err];
}
 
/**
 *TODO: 广告信息列表（advertiseList)
 /api.php?m=App&a=advertiseList
 catid”:广告栏目catid(*) 可选,
 “type”:广告类型(*),
 广告就只有新闻，项目，活动的，所以数据库是type分别是1,2,3，传4就可以得到首页广告
 */
-(void)fetch_advertiseListWithType:(NSString *)type catid:(NSString *)catid response:(void (^)(NSDictionary * Dictionary))response  errorHandler:(void (^)(NSError * error))err
{
    if (!type) {  response(nil); return;}
    NSDictionary * param = @{@"type":type};
    if (catid) param = @{@"type":type,@"catid":catid};
    
    [self queryNetWorkWithKey:@"advertiseList" urlpath:@"/api.php?m=App&a=advertiseList" param:param httpMethod:@"POST" usecache:NO  response:response errorHandler:err];
    
}

/**
 * 得到所有广告分类
 http://112.74.78.166/api.php?m=App&a=advertiseType
 */
-(void)fetch_advertiseType:(void (^)(NSDictionary * Dictionary))response errorHandler:(void (^)(NSError * error))err
{
     [self queryNetWorkWithKey:@"advertiseType" urlpath:@"/api.php?m=App&a=advertiseType"  param:nil httpMethod:@"POST" response:response errorHandler:err];
}


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
                  errorHandler:(void (^)(NSError * error))err
{
    if (!catid) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSDictionary * param = @{@"catid":catid};
    if (page && pagesize) {
        param = @{@"page":[NSNumber numberWithInteger:page],@"pagesize":[NSNumber numberWithInteger:pagesize],@"catid":catid};
    }
    [self queryNetWorkWithKey:@"newsList" urlpath:@"/api.php?m=App&a=newsList" param:param httpMethod:@"POST" usecache:YES  response:response errorHandler:err];
    
}

/**
 * 项目类型列表(projectTypeList)
 * projectTypeList
 * /api.php?m=App&a=projectTypeList
 */
-(void)fetch_projectTypeList:(void (^)(NSDictionary * Dictionary))response
                errorHandler:(void (^)(NSError * error))err
{
    [self queryNetWorkWithKey:@"projectTypeList" urlpath:@"/api.php?m=App&a=projectTypeList"  param:nil  httpMethod:@"GET" usecache:YES   response:response errorHandler:err];

}


/**
 * 项目列表(projectList)
 * /api.php?m=App&a=projectList
 *  typeid:项目类型id(*)
 */
-(void)fetch_projectList:(NSString *)typeid
                response:(void (^)(NSDictionary * Dictionary))response
            errorHandler:(void (^)(NSError * error))err
{
    if (!typeid) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSDictionary * param = @{@"typeid":typeid};
    NSString * key = [NSString stringWithFormat:@"projectList%@",typeid];
    [self queryNetWorkWithKey:key urlpath:@"/api.php?m=App&a=projectList" param:param httpMethod:@"POST" usecache:YES  response:response errorHandler:err];
}


/**
 *指定ID查找单条新闻(findNewsById)
 /api.php?m=App&a= findNewsById
 news_id:新闻id(*)
 mid:会员id.
 */

-(void)fetch_findNewsByIdWithID:(NSString *)news_id
                            mid:(NSString *)mid
                       response:(void (^)(NSDictionary * Dictionary))response
                   errorHandler:(void (^)(NSError * error))err
{
    if (!news_id) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSDictionary * param = @{@"news_id":news_id};
    if (mid) {
        param = @{@"news_id":news_id,@"mid":mid};
    }
    NSString * key = [NSString stringWithFormat:@"findNewsById%@",news_id];
   [self queryNetWorkWithKey:key urlpath:@"/api.php?m=App&a=findNewsById" param:param httpMethod:@"POST" usecache:YES  response:response errorHandler:err];
    
}

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
                       errorHandler:(void (^)(NSError * error))err
{
    if (!cid || !type) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSDictionary * param = @{@"cid":cid,@"type":type};
    if (page && pagesize) {
        param = @{@"page":[NSNumber numberWithInteger:page],@"pagesize":[NSNumber numberWithInteger:pagesize],@"cid":cid,@"type":type};
    }
    [self queryNetWorkWithKey:@"newsCommentList" urlpath:@"/api.php?m=App&a=newsCommentList" param:param httpMethod:@"POST" usecache:NO  response:response errorHandler:err];
}


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
                   errorHandler:(void (^)(NSError * error))err
{
    if (!cid || !type ||!mid || !content) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSDictionary * param = @{@"cid":cid,@"mid":mid,@"content":content,@"type":type};
    if (reply_mid && reply_id) {
        //|| !reply_id ||!reply_mid
        param = @{@"cid":cid,@"mid":mid,@"content":content,@"type":type,@"reply_cid":reply_id,@"reply_mid":reply_mid};
    }
    [self queryNetWorkWithKey:@"newscomment" urlpath:@"/api.php?m=App&a=newscomment" param:param httpMethod:@"POST" usecache:NO  response:response errorHandler:err];
}


/**
 * 指定ID查找单个项目(findProjectById)
 * /api.php?m=App&a=findProjectById
 *  id:项目id(*),
 */
-(void)fetch_findProjectById:(NSString *)m_id
                         mid:(NSString *)m_mid
                    response:(void (^)(NSDictionary * Dictionary))response
                errorHandler:(void (^)(NSError * error))err
{
    if (!m_id && !m_mid) {
        NSDictionary * errdic = @{HTTP_ERROR_KEY:HTTP_ERROR_PARMA};
        response(errdic);
        return;
    }
    NSDictionary * param = @{@"id":m_id,@"mid":m_mid};
   [self queryNetWorkWithKey:@"findProjectById" urlpath:@"/api.php?m=App&a=findProjectById" param:param httpMethod:@"POST" usecache:NO  response:response errorHandler:err];
    
}

-(void)fetch_findProjectById:(NSString *)m_id
                         mid:(NSString *)m_mid
                    jsonstring:(void (^)(NSString * jsonstring))jsonsresponse
                errorHandler:(void (^)(NSError * error))err
{
    if (!m_id || !m_mid) {
        jsonsresponse(@"error");
        return;
    }
    NSDictionary * param = @{@"id":m_id,@"mid":m_mid};
    [self queryNetWorkWithKey:@"findProjectById" urlpath:@"/api.php?m=App&a=findProjectById" param:param  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        jsonsresponse(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}

/**
 * 资助类型列表(supportTypeList)
 /api.php?m=App&a=supportTypeList
 * 返回{
 “id” : 资助类型ID,
 “name” : 资助类型名称,
 },…]
 */
-(void)fetch_supportTypeList:(void (^)(NSDictionary * Dictionary))response
                errorHandler:(void (^)(NSError * error))err
{
     [self queryNetWorkWithKey:@"supportTypeList" urlpath:@"/api.php?m=App&a=supportTypeList" param:nil httpMethod:@"POST" usecache:NO  response:response errorHandler:err];
}

///**
// * 首页项目查询 搜索
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
//                   errorHandler:(void (^)(NSError * error))err
//{
//    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
//    OBJ_NOT_NULL_ADD_DIC(schoolId,params);
//    OBJ_NOT_NULL_ADD_DIC(page,params);
//    OBJ_NOT_NULL_ADD_DIC(schoolId,params)
//    OBJ_NOT_NULL_ADD_DIC(demand,params)
//    OBJ_NOT_NULL_ADD_DIC(money,params)
//     [self queryNetWorkWithKey:@"projectSearch" urlpath:@"/api.php?m=App&a=projectSearcht" param:params httpMethod:@"POST" usecache:NO  response:response errorHandler:err];
//}

/**
 *  首页数据
 /api.php?m=Home&a=index
 */
-(void)fetch_homeIndex:(void (^)(NSDictionary * Dictionary))response
          errorHandler:(void (^)(NSError * error))err
{
     [self queryNetWorkWithKey:@"projectSearch" urlpath:@"/api.php?m=Home&a=index" param:nil httpMethod:@"GET" usecache:NO  response:response errorHandler:err];
}


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
                     errorHandler:(void (^)(NSError * error))err
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(mid,params);
    OBJ_NOT_NULL_ADD_DIC(name,params);
    OBJ_NOT_NULL_ADD_DIC(typeId,params);
    OBJ_NOT_NULL_ADD_DIC(description,params);
    OBJ_NOT_NULL_ADD_DIC(money,params);
    OBJ_NOT_NULL_ADD_DIC(schoolId,params);
    OBJ_NOT_NULL_ADD_DIC(teamInfo,params);
    OBJ_NOT_NULL_ADD_DIC(teamName,params);
    OBJ_NOT_NULL_ADD_DIC(teamMembers,params);
    OBJ_NOT_NULL_ADD_DIC(teamManageId,params);
    //TODO:图片暂时未上传
    [self queryNetWorkWithKey:@"project" urlpath:@"/api.php?m=App&a=project" param:params httpMethod:@"POST" usecache:NO  response:response errorHandler:err];

}

/**
 *  会员基本信息(memberList)
 * /api.php?m=App&a=memberList
 * 请求参数说明	 “mid”:会员id(*),
 */
-(void)fetch_memberList:(NSString *)mid
               response:(void (^)(NSString * responsejson))response
           errorHandler:(void (^)(NSError * error))err
{
    [self queryNetWorkWithKey:@"memberList" urlpath:@"/api.php?m=App&a=memberList" param:@{@"mid":mid} httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}


/**
 *
 会员评论信息(memberCommnets)
 /api.php?m=App&a=memberCommnets
 “mid”:会员id(*),
 */
-(void)fetch_memberCommnets:(NSString *)mid
                   response:(void (^)(NSString * responsejson))response
               errorHandler:(void (^)(NSError * error))err
{
    [self queryNetWorkWithKey:@"memberCommnets" urlpath:@"/api.php?m=App&a=memberComments" param:@{@"mid":mid} httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}


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
                errorHandler:(void (^)(NSError * error))err
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(mid,params);
    OBJ_NOT_NULL_ADD_DIC(phone,params);
    OBJ_NOT_NULL_ADD_DIC(content,params);
    
    [self queryNetWorkWithKey:@"feedback" urlpath:@"/api.php?m=App&a=feedback" param:params  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];

}



/**
 *  活动栏目(activityType)
 /api.php?m=App&a=activityType
 */
-(void)fetch_activityType:(void (^)(NSString * responsejson))response
             errorHandler:(void (^)(NSError * error))err
{ 
    [self queryNetWorkWithKey:@"activityType" urlpath:@"/api.php?m=App&a=activityType" param:nil  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}

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
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(catid,params);
    OBJ_NOT_NULL_ADD_DIC(mid,params);
    OBJ_NOT_NULL_ADD_DIC(pagesize,params);
    OBJ_NOT_NULL_ADD_DIC(page,params);
    [self queryNetWorkWithKey:@"activityList" urlpath:@"/api.php?m=App&a=activityList" param:params  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}


/**
 * 活动报名(registActivity)
 * /api.php?m=App&a=registActivity
 “id”:活动id(*),
 “mid”:会员ID(*),
 */
-(void)fetch_registActivityWithid:(NSString *)_id
                              mid:(NSString *)mid
                         response:(void (^)(NSString * responsejson))response
                     errorHandler:(void (^)(NSError * error))err
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(_id,params);
    OBJ_NOT_NULL_ADD_DIC(mid,params);
    [self queryNetWorkWithKey:@"registActivity" urlpath:@"/api.php?m=App&a=registActivity" param:params  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}

/**
 * 取消活动(cancelActivity)
 /api.php?m=App&a=cancelActivity
 “id”:活动id(*),
 “mid”:会员ID(*),
 */
-(void)fetch_cancelActivityWithid:(NSString *)_id
                              mid:(NSString *)mid
                         response:(void (^)(NSString * responsejson))response
                     errorHandler:(void (^)(NSError * error))err
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(_id,params);
    OBJ_NOT_NULL_ADD_DIC(mid,params);
    [self queryNetWorkWithKey:@"cancelActivity" urlpath:@"/api.php?m=App&a=cancelActivity" param:params  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}


/**
 * 判断会员是否报名活动(isRegist)
 /api.php?m=App&a=isRegist
 “id”:活动id(*),
 “mid”:会员ID(*),
 */
-(void)fetch_isRegistWithid:(NSString *)_id
                        mid:(NSString *)mid
                   response:(void (^)(NSString * responsejson))response
               errorHandler:(void (^)(NSError * error))err
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(_id,params);
    OBJ_NOT_NULL_ADD_DIC(mid,params);
    [self queryNetWorkWithKey:@"isRegist" urlpath:@"/api.php?m=App&a=isRegist" param:params  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}
/**
 * 会员（我）报名的活动信息(memberRegActivity)
 /api.php?m=App&a=memberRegActivity
 “mid”:会员id(*),
 */
-(void)fetch_memberRegActivityWithid:(NSString *)mid
                            response:(void (^)(NSString * responsejson))response
                        errorHandler:(void (^)(NSError * error))err
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(mid,params);
    [self queryNetWorkWithKey:@"memberRegActivity" urlpath:@"/api.php?m=App&a=memberRegActivity" param:params  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}



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
                     errorHandler:(void (^)(NSError * error))err
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:0];
    OBJ_NOT_NULL_ADD_DIC(page,params);
    OBJ_NOT_NULL_ADD_DIC(schoolId,params);
    OBJ_NOT_NULL_ADD_DIC(typeId,params);
    OBJ_NOT_NULL_ADD_DIC(demand,params);
    OBJ_NOT_NULL_ADD_DIC(money,params);
    OBJ_NOT_NULL_ADD_DIC(keyword, params);
    [self queryNetWorkWithKey:@"projectSearch" urlpath:@"/api.php?m=Home&a=projectSearch" param:params  httpMethod:@"POST" usecache:NO  photo:nil photokey:nil jsonstring:^(NSString *jsonstring) {
        response(jsonstring);
    } errorHandler:^(NSError *error) {
        
    }];
}

@end



