//
//  ProjectTypeListModel.h
//  JXL
//
//  Created by BooB on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveObject.h"
#import "JXL_Define.h"
@interface ProjectTypeList :ArchiveObject
@property(nonatomic,retain) NSString * m_id;
@property(nonatomic,retain) NSString * m_name;
@property(nonatomic,retain) NSString * m_sort;
@end

/**
 *{
 id:项目id,
 name:项目名称,
 demandName:需求名称,
 “schoolCity”:学校所在城市,
 “schoolName”:学校名称,
 “team_photo”:团队照片,
 “topNum”:点赞数,
 “views”:评论数,
 }
 */
@interface ProjectList : ArchiveObject

@property(nonatomic,retain) NSString * m_id;
@property(nonatomic,retain) NSString * m_name;
@property(nonatomic,retain) NSString * m_demandName;
@property(nonatomic,retain) NSString * m_schoolCity;
@property(nonatomic,retain) NSString * m_schoolName;
@property(nonatomic,retain) NSString * m_team_photo;
@property(nonatomic,retain) NSString * m_topNum;
@property(nonatomic,retain) NSString * m_views;
@end

@interface ProjectTypeListModel : NSObject
AS_SINGLETON(ProjectTypeListModel)
@property(nonatomic,retain) NSArray * projectTypeList;

-(void)projectTypeList:(void (^)(NSDictionary * Dictionary))response
                errorHandler:(void (^)(NSError * error))err;

+(NSArray *)encodeDiction:(NSDictionary *)Dictionary;
@end

@interface ProjectListModel : NSObject
+(NSArray *)encodeDiction:(NSDictionary *)Dictionary;
@end



/**
 * findProjectById
 *{
 id:项目id,
 name:项目名称,
 demandName:需求名称,
 typeName:项目类型,
 “schoolCity”:学校所在城市,
 “schoolName”:学校名称,
 “money”:资金额度,
 “team_name”:团队名称,
 “team_photo”:团队封面照片,
 “team_member_headpic”:团队成员头像,
 “leader_headpic”:负责人头像
 “team_info”:团队简介,
 “description”:项目描述
 “topNum”:点赞数,
 “views”:评论数,
 “annexNum”:附件下载次数，
 “annexSize”:附件的大小,
 “annexCode”下载码,
 “chargeMember”:1表示VIP充值用户,0表示非VIP充值用户.2表示非投资人.
 }
 
 {
 annexCode = "<null>";
 annexSize = "<null>";
 annexnNum = "<null>";
 chargeMember = 1;
 demandName = "\U627e\U5bfc\U5e08";
 description = "\U3000\U3000\U201c\U4e09\U4e2a\U7238\U7238\U201d\U54c1\U724c\U8d77\U6e90\U4e8e\U521b\U59cb\U4eba\U6234\U8d5b\U9e70\U3001\U9648\U6d77\U6ee8\U548c\U5b8b\U4e9a\U5357\U201c\U7ed9\U5b69\U5b50\U63d0\U4f9b\U66f4\U52a0\U5b89\U5168\U3001\U653e\U5fc3\U7684\U7a7a\U6c14\U201d\U8fd9\U4e00\U7f8e\U597d\U613f\U671b\U3002\U4e09\U4eba\U5bf9\U5e02\U9762\U4e0a\U7684\U7a7a\U6c14\U51c0\U5316\U5668\U5931\U671b\U4e4b\U4f59\Uff0c\U51b3\U5b9a\U4e3a\U4e86\U5b69\U5b50\U5065\U5eb7\U201c\U91cd\U65b0\U5b9a\U4e49\U7a7a\U6c14\U201d\U3002\U968f\U540e\U627e\U5230\U4e86\U6709\U7740\U4e94\U5e74\U51c0\U5316\U5668\U7814\U53d1\U5236\U9020\U7ecf\U9a8c\U7684\U5408\U4f19\U4eba\U674e\U6d2a\U6bc5\Uff0c\U5e76\U8fc5\U901f\U7ec4\U5efa\U8d77\U4e86\U4e00\U652f\U725b\U4eba\U56e2\U961f\U3002\U81f4\U529b\U4e8e\U9020\U4e00\U6b3e\U771f\U6b63\U80fd\U591f\U4fdd\U62a4\U513f\U7ae5\U547c\U5438\U7cfb\U7edf\U7684\U7a7a\U6c14\U51c0\U5316\U5668\U3002\U54c1\U724c\U540d\U5b9a\U4e3a\U201c\U4e09\U4e2a\U7238\U7238\U201d\Uff0c\U201c\U4e09\U8005\U4e3a\U4f17\U201d\Uff0c\U8fd9\U91cc\U7684\U201c\U4e09\U201d\U65e2\U6307\U6700\U521d\U7684\U4e09\U4f4d\U521b\U59cb\U4eba\U7238\U7238\Uff0c\U66f4\U662f\U4ee3\U8868\U4e86\U5343\U5343\U4e07\U4e07\U7238\U7238\U5bf9\U5b69\U5b50\U7684\U5173\U7231\U3002";
 "financ_amount" = "0.00";
 id = 40;
 "invest_rate" = "10%";
 "leader_headpic" = "";
 name = "\U201c\U4e09\U4e2a\U7238\U7238\U201d3";
 schoolCity = "\U5357\U660c\U5e02";
 schoolName = "\U6c5f\U897f\U8d22\U7ecf\U5927\U5b66";
 "team_info" = b;
 "team_member_headpic" =     (
 );
 "team_name" = "\U4e09\U4e2a\U7238\U7238";
 "team_phone" = "<null>";
 "team_photo" = "";
 "team_photo_array" =     (
 );
 topNum = 2;
 typeName = "IT\U4e92\U8054\U7f51";
 views = 2;
 }
 )
 */

//@interface ProjectInfo : ArchiveObject
//@property(nonatomic,retain) NSString * m_id;//:项目id,
//@property(nonatomic,retain) NSString * m_name;//:项目名称,
//@property(nonatomic,retain) NSString * m_demandName;//:需求名称,
//@property(nonatomic,retain) NSString * m_typeName;//:项目类型,
//@property(nonatomic,retain) NSString * m_schoolCity;//”:学校所在城市,
//@property(nonatomic,retain) NSString * m_schoolName;//”:学校名称,
//@property(nonatomic,retain) NSString * m_money;//”:资金额度,
//@property(nonatomic,retain) NSString * m_team_name;//”:团队名称,
//@property(nonatomic,retain) NSString * m_team_photo;//”:团队封面照片,
//@property(nonatomic,retain) NSString * m_team_member_headpic;//”:团队成员头像,
//@property(nonatomic,retain) NSString * m_leader_headpic;//”:负责人头像
//@property(nonatomic,retain) NSString * m_team_info;//”:团队简介,
//@property(nonatomic,retain) NSString * m_description;//”:项目描述
//@property(nonatomic,retain) NSString * m_topNum;//”:点赞数,
//@property(nonatomic,retain) NSString * m_views;//”:评论数,
//@property(nonatomic,retain) NSString * m_annexNum;//”:附件下载次数，
//@property(nonatomic,retain) NSString * m_annexSize;//”:附件的大小,
//@property(nonatomic,retain) NSString * m_annexCode;//”下载码,
//@property(nonatomic,retain) NSString * m_chargeMember;//”:1表示VIP充值用户,0表示非VIP充值用户.2表示非投资人.
//@end

@interface ProjectInfo_New : NSObject

@property(nonatomic,retain) NSString * annexNum;
@property(nonatomic,retain) NSString * annexnNum;
@property(nonatomic,retain) NSString * annexSize;
@property(nonatomic,retain) NSString * chargeMember;
@property(nonatomic,retain) NSString * annexCode;
@property(nonatomic,retain) NSString * demandName;
@property(nonatomic,retain) NSString * _description;
@property(nonatomic,retain) NSString * financ_amount;
@property(nonatomic,retain) NSString * id;
@property(nonatomic,retain) NSString * invest_rate;
@property(nonatomic,retain) NSString * leader_headpic;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * schoolCity;
@property(nonatomic,retain) NSString * schoolName;
@property(nonatomic,retain) NSString * team_info;
@property(nonatomic,retain) NSArray  * team_member_headpic;
@property(nonatomic,retain) NSString * team_name;
@property(nonatomic,retain) NSString * team_phone;
@property(nonatomic,retain) NSString * team_photo;
@property(nonatomic,retain) NSArray  * team_photo_array;
@property(nonatomic,retain) NSString * topNum;
@property(nonatomic,retain) NSString * typeName;
@property(nonatomic,retain) NSString * views;
@end

@interface FindProjectByIdModel : NSObject

+(ProjectInfo_New *)encodeJsonString:(NSString *)jsonstring;
//+(ProjectInfo *)encodeDiction:(NSDictionary *)Dictionary;
@end


