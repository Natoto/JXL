//
//  D1_TakePartInViewController.m
//  JXL
//
//  Created by BooB on 15/5/10.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "jxl.h"
#import "D1_TakePartInViewController.h"
#import "D1_InputTableViewCell.h"
#import "D2_EditInfoViewController.h"
#import "HTTPSEngine.h"
#import "D4_CollegeSelectorController.h"

#define GET_TAKEPART_CELL_STRUCT(OBJ,TITLE) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [JXL_Common cell_x_x_struct:@#TITLE detailvalue:nil \
footerheight:20 \
selectionStyle:YES  \
accessory:YES \
cellheight:40 \
imageRight:NO \
imageCornerRadius:NO \
picture:nil \
target:self \
selectAction:@selector(selectAction:) \
background:[UIColor whiteColor]];\
_cell_struct_##OBJ.subvalue2 = @#TITLE;\
_cell_struct_##OBJ.titlecolor = @"gray";}\
return _cell_struct_##OBJ;}

@interface D1_TakePartInViewController ()<D4_CollegeSelectorControllerDelegate>
AS_CELL_STRUCT_JXLCOMMON(upload)
AS_CELL_STRUCT_JXLCOMMON(projectname)
AS_CELL_STRUCT_JXLCOMMON(projecttype)
AS_CELL_STRUCT_JXLCOMMON(projectneed)
AS_CELL_STRUCT_JXLCOMMON(projectdetail)
AS_CELL_STRUCT_JXLCOMMON(projectmoney)

AS_CELL_STRUCT_JXLCOMMON(teamname)
AS_CELL_STRUCT_JXLCOMMON(teamids)
AS_CELL_STRUCT_JXLCOMMON(teammanagerid)
AS_CELL_STRUCT_JXLCOMMON(teamdetail)

AS_CELL_STRUCT_JXLCOMMON(school)
AS_CELL_STRUCT_JXLCOMMON(city)
AS_CELL_STRUCT_JXLCOMMON(confirm)
@end

@implementation D1_TakePartInViewController
@synthesize dataDictionary = _dataDictionary ;
GET_TAKEPART_CELL_STRUCT(upload, 上传团队照片)
GET_TAKEPART_CELL_STRUCT(projectname, 项目名称)
GET_TAKEPART_CELL_STRUCT(projecttype, 项目类型)
GET_TAKEPART_CELL_STRUCT(projectneed, 项目需求)
GET_TAKEPART_CELL_STRUCT(projectmoney, 项目金额)
GET_TAKEPART_CELL_STRUCT(projectdetail, 项目描述)
GET_TAKEPART_CELL_STRUCT(teamname, 团队名称)
GET_TAKEPART_CELL_STRUCT(teammanagerid, 队长ID)
GET_TAKEPART_CELL_STRUCT(teamids, 团队成员ID 用半角符号"," 分隔)
GET_TAKEPART_CELL_STRUCT(teamdetail, 团队介绍)
GET_TAKEPART_CELL_STRUCT(school, 所在学校)
GET_TAKEPART_CELL_STRUCT(city, 所在城市)
GET_TAKEPART_CELL_STRUCT(confirm, 提交项目)


-(void)setcellstructs
{
    self.cell_struct_confirm.accessory = NO;
    [self.cell_struct_confirm.dictionary setObject:JXL_COLOR_THEME_NAVIGATIONBAR forKey:key_cellstruct_background];
    [self.cell_struct_confirm.dictionary setObject:value_cellstruct_textAlignment_center forKey:key_cellstruct_textAlignment];
    self.cell_struct_confirm.titlecolor = @"white";
    
    self.cell_struct_projectdetail.cellheight = 60;
    self.cell_struct_teamdetail.cellheight = 60;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setcellstructs];
    
    [self userDefaultConfigWithTitle:@"提交项目"];
  
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D1_InputTableViewCell")
    // Do any additional setup after loading the view.
    ADD_HBSIGNAL_OBSERVER(self, key_d2editInfoviewcontroller_notify_confirm, NSStringFromClass([D2_EditInfoViewController class]))
    
}

-(void)dealloc
{
    REMOVE_HBSIGNAL_OBSERVER(self, key_d2editInfoviewcontroller_notify_confirm, NSStringFromClass ([D2_EditInfoViewController class]))
}

ON_HBSIGNAL(D2_EditInfoViewController, confirm, notify)
{
    NSString * object = notify.object;
    NSArray * compants = [object componentsSeparatedByString:@":"];
    
     if (compants.count >= 2)
     {
         NSString * celltype = compants[0];
         if(celltype.integerValue == edit_type_projectname)
         {
             self.cell_struct_projectname.detailtitle = compants[1];
            
         }
         else if(celltype.integerValue == edit_type_projectneed)
         {
             self.cell_struct_projectneed.detailtitle = compants[1];
         }
         else if(celltype.integerValue == edit_type_projectdesc)
         {
             self.cell_struct_projectdetail.detailtitle = compants[1];
         }
         else if(celltype.integerValue == edit_type_projectmoney)
         {
             self.cell_struct_projectmoney.detailtitle = compants[1];
         }
         else if(celltype.integerValue == edit_type_teamname)
         {
             self.cell_struct_teamname.detailtitle = compants[1];
         }
         else if(celltype.integerValue == edit_type_teamids)
         {
             self.cell_struct_teamids.detailtitle = compants[1];
             if (self.cell_struct_teamids.detailtitle.length) {
                 self.cell_struct_teamids.title = @"成员ID";
             }
             else
             {
                  self.cell_struct_teamids.title = self.cell_struct_projectname.subvalue2;
             }
         }else if(celltype.integerValue == edit_type_teammanagerid)
         {
             self.cell_struct_teammanagerid.detailtitle = compants[1];
         }
         else if(celltype.integerValue == edit_type_teamdesc)
         {
             self.cell_struct_teamdetail.detailtitle = compants[1];
         }
         else if(celltype.integerValue == edit_type_projecttype)
         {
             self.cell_struct_projecttype.detailtitle = compants[1];
             self.cell_struct_projecttype.value = compants[2];
         }
     }
     [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    //demand:项目需求枚举类型(寻求合作，找导师，找员工，寻找资金)
    if (cellstruct == self.cell_struct_confirm) {
        
        [[HTTPSEngine sharedInstance] fetch_uploadprojectWithmid:
         [GlobalData sharedInstance].m_mid
                                                     projectname:self.cell_struct_projectname.detailtitle
                                                          typeId:self.cell_struct_projecttype.value
                                              projectdescription:self.cell_struct_projectdetail.detailtitle
                                                   projectdemand:self.cell_struct_projectneed.detailtitle
                                                           money:self.cell_struct_projectmoney.detailtitle
                                                        schoolId:self.cell_struct_school.value
                                                        teamInfo:self.cell_struct_teamdetail.detailtitle
                                                        teamName:self.cell_struct_teamname.detailtitle
                                                     teamMembers:self.cell_struct_teamids.detailtitle
                                                    teamManageId:self.cell_struct_teammanagerid.detailtitle
                                                        imgdatas:nil
                                                        response:^(NSDictionary *Dictionary) {
                                                          
                                                            if ([Dictionary isErrorObject]) {
                                                                APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
                                                                [self presentMessageTips:error.m_errorMsg];
                                                            }
                                                            else
                                                            {
                                                                [self presentMessageTips_:@"项目提交成功" dismisblock:^{
                                                                    [self backtoparent:nil];
                                                                }];
                                                            }
                                                        } errorHandler:^(NSError *error) {
                                                            
                                                        }];
        
        return;
    }
    
    if (cellstruct == self.cell_struct_school || cellstruct == self.cell_struct_city) {
        
        D4_CollegeSelectorController * ctr = [[D4_CollegeSelectorController alloc] init];
        ctr.selectordelegate = self;
        [self.navigationController pushViewController:ctr animated:YES];
        return;
    }
    
    if (cellstruct == self.cell_struct_upload) {
        return;
    }
    
    D2_EditInfoViewController * ctr = [[D2_EditInfoViewController alloc] init];
    
    if(cellstruct == self.cell_struct_projectname)
    {
        ctr.edit_type = edit_type_projectname;
        ctr.value = self.cell_struct_projectname.detailtitle;
    }
    else if(cellstruct == self.cell_struct_projectneed)
    {
        ctr.edit_type = edit_type_projectneed;
        ctr.value = self.cell_struct_projectneed.detailtitle;
    }
    else if(cellstruct == self.cell_struct_projectmoney)
    {
        ctr.edit_type = edit_type_projectmoney;
        ctr.value = self.cell_struct_projectmoney.detailtitle;
    }
    else if(cellstruct == self.cell_struct_projectdetail)
    {
        ctr.edit_type = edit_type_projectdesc;
        ctr.value = self.cell_struct_projectdetail.detailtitle;
    }
    else if(cellstruct == self.cell_struct_teamname)
    {
        ctr.edit_type = edit_type_teamname;
        ctr.value = self.cell_struct_teamname.detailtitle;
    }
    else if(cellstruct == self.cell_struct_teamids)
    {
        ctr.edit_type = edit_type_teamids;
        ctr.value = self.cell_struct_teamids.detailtitle;
    }
    else if(cellstruct == self.cell_struct_teammanagerid)
    {
        ctr.edit_type = edit_type_teammanagerid;
        ctr.value = self.cell_struct_teammanagerid.detailtitle;
    }
    else if(cellstruct == self.cell_struct_teamdetail)
    {
        ctr.edit_type = edit_type_teamdesc;
        ctr.value = self.cell_struct_teamdetail.detailtitle;
    }
    else if(cellstruct == self.cell_struct_projecttype)
    {
        ctr.edit_type = edit_type_projecttype;
        ctr.value = self.cell_struct_projecttype.detailtitle;
    }
    [self.navigationController pushViewController:ctr animated:YES];
}


-(void)D4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController selectCollageCityName:(NSString *)selectCollegeCityName selectCollegeCityID:(NSString *)selectCollegeCityID selectCollegeName:(NSString *)collegeName collegeID:(NSString *)collegeID
{
    self.cell_struct_school.value = collegeID;
    self.cell_struct_school.detailtitle = collegeName;
    self.cell_struct_city.detailtitle = selectCollegeCityName;
    [self.tableView reloadData];
}


-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        NSDictionary * dic = @{KEY_INDEXPATH(0, 0):self.cell_struct_upload,
                               KEY_INDEXPATH(0, 1):self.cell_struct_projectname,
                               KEY_INDEXPATH(0, 2):self.cell_struct_projecttype,
                               KEY_INDEXPATH(0, 3):self.cell_struct_projectneed,
                               KEY_INDEXPATH(0, 4):self.cell_struct_projectmoney,
                               KEY_INDEXPATH(0, 5):self.cell_struct_projectdetail,
                               
                               KEY_INDEXPATH(1, 0):self.cell_struct_teamname,
                               KEY_INDEXPATH(1, 1):self.cell_struct_teammanagerid,
                               KEY_INDEXPATH(1, 2):self.cell_struct_teamids,
                               KEY_INDEXPATH(1, 3):self.cell_struct_teamdetail,
                               
                               KEY_INDEXPATH(2, 0):self.cell_struct_city,
                               KEY_INDEXPATH(2, 1):self.cell_struct_school,
                               
                               KEY_INDEXPATH(3, 0):self.cell_struct_confirm};
        _dataDictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return _dataDictionary;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
