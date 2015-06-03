//
//  ProjectSearchModel.h
//  JXL
//
//  Created by 跑酷 on 15/5/21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectSearchModel : NSObject

@end

/*
 首页项目查询
 
 URL	/api.php?m=Home&a=projectSearch
 请求方式	POST
 请求参数说明	page：页码
 schoolId：学校ID
 typeId：项目类型ID
 demand：(‘合作’,’融资’)
 money：资金范围(1,2)
 返回内容	[
 {
 "id": 项目ID,
 "name": 项目标题,
 "demandName": 项目需求,
 "team_photo": 图片,
 "schoolCity": 城市,
 "schoolName": 学校名称,
 "views": 评论数,
 "topNum": 点赞数
 }...
 ]
  
 */