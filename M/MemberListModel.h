//
//  MemberListModel.h
//  JXL
//
//  Created by BooB on 15/5/17.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveObject.h"
@interface MemberList : ArchiveObject
@property(nonatomic,retain) NSString *      age;// = 12;
@property(nonatomic,retain) NSString *      email;// = "Fgggh@qq.com";
@property(nonatomic,retain) NSString *      headpic;// = "http://112.74.78.166/d/file/member/554f82b580ae9.jpg";
@property(nonatomic,retain) NSString *      idnumber;// = 2358900756;
@property(nonatomic,retain) NSString *      member_id;//" = 0111;
@property(nonatomic,retain) NSString *      mid ;//= 111;
@property(nonatomic,retain) NSString *      nickname ;//= "Hjjj choice";
@property(nonatomic,retain) NSString *      password;// = 405724d94a9cd3445e01d6d1b244c553;
@property(nonatomic,retain) NSString *      phone ;//= 15920549038;
@property(nonatomic,retain) NSString *      province;// = "<null>";
@property(nonatomic,retain) NSString *      schoolCity;// = "\U8d63\U5dde\U5e02";
@property(nonatomic,retain) NSString *      schoolId;// = 1387;
@property(nonatomic,retain) NSString *      schoolName;// = "\U8d63\U5357\U533b\U5b66\U9662";
@property(nonatomic,retain) NSString *      sex ;//= "\U5973";
@property(nonatomic,retain) NSString *      teacher ;//= Ryun;
@property(nonatomic,retain) NSString *      typeId;// = 2;
@property(nonatomic,retain) NSString *      typeName ;//= "\U521b\U4e1a\U8005";

@property(nonatomic,retain) NSString *      introduce;//": "土豪一个",
@property(nonatomic,retain) NSString *      interest;//": "2,1,3",
@property(nonatomic,retain) NSString *      interestTitle;//": "IT互联网,电商物流,教育培训",
@property(nonatomic,retain) NSString *      support;//": "1,2",
@property(nonatomic,retain) NSString *      supportTitle;//": "股权投资,创业咨询"

@end

@interface MemberListModel : NSObject

+(MemberList *)encodeDiction:(NSString *)jsonstring;

@end
