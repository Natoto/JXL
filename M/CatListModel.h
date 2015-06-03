//
//  CatListModel.h
//  JXL
//
//  Created by 跑酷 on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveObject.h"
@interface catList : ArchiveObject
//catid” : 新闻栏目id,
//“catname” : 栏目名称,
@property(nonatomic,retain) NSString * m_catid;
@property(nonatomic,retain) NSString * m_catname;
@end

@interface CatListModel : NSObject

+(NSArray *)encodeDiction:(NSDictionary *)dictionary;
@end
