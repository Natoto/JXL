//
//  D2_EditInfoViewController.h
//  JXL
//
//  Created by 跑酷 on 15/5/8.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewController.h"
static NSString * key_d2editInfoviewcontroller_notify_confirm = @"confirm";
typedef enum : int {
    edit_type_nickname,
    edit_type_sex,
    edit_type_age,
    edit_type_teacher,
    edit_type_location,
    edit_type_idcount,
    edit_type_projecttype,
    edit_type_projectname,
    edit_type_projectneed,
    edit_type_projectmoney,
    edit_type_projectdesc,
    edit_type_teamname,
    edit_type_teammanagerid,
    edit_type_teamids,
    edit_type_teamdesc,
} EDIT_TYPE;

@interface D2_EditInfoViewController : BaseTableViewController

@property(nonatomic,assign) EDIT_TYPE edit_type;
@property(nonatomic,retain) NSString * value;
@end
