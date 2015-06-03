//
//  D1_PersonalCenterController.m
//  JXL
//
//  Created by 跑酷 on 15/5/7.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_PersonalCenterController.h"
#import "GlobalData.h"
#import "jxl.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
#import "UIActionSheet+MKBlockAdditions.h"
#import "ImagePicker+Camera.h"
#import "UIViewController+QBImagePicker.h"
#import "D2_EditInfoViewController.h"
#import "D4_CollegeSelectorController.h"
#import "JXLCommon.h"

#define AS_CELL_STRUCT_(OBJ) @property(nonatomic,retain) CELL_STRUCT * cell_struct_##OBJ;

#define GET_CELL_STRUCT_(OBJ,TITLE) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [self cell_x_x_struct:@#TITLE detailvalue:nil];\
}\
return _cell_struct_##OBJ;}

#define GET_CELL_STRUCT_1(OBJ,TITLE,SELECTENABLE,ACCESSORY,HEIGHT,IMAGEHEIGHT,CORNER) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [self cell_x_x_struct:@#TITLE detailvalue:nil footerheight:20 selectionStyle:SELECTENABLE  accessory:ACCESSORY cellheight:HEIGHT imageRight:IMAGEHEIGHT imageCornerRadius:CORNER];\
}\
return _cell_struct_##OBJ;}


#define GET_CELL_STRUCT_2(OBJ,TITLE) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [self cell_x_x_struct:@#TITLE detailvalue:nil footerheight:20 selectionStyle:YES  accessory:NO];\
}\
return _cell_struct_##OBJ;}

#define GET_CELL_STRUCT_3(OBJ,TITLE,SELECTENABLE,ACCESSORY) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [self cell_x_x_struct:@#TITLE detailvalue:nil footerheight:20 selectionStyle:SELECTENABLE  accessory:ACCESSORY];\
}\
return _cell_struct_##OBJ;}
//

// footerheight:(CGFloat)footerheight selectionStyle:(BOOL)selectionStyle

@interface D1_PersonalCenterController ()<QBImagePickerControllerCameraDelegate,UIViewControllerQBImagePickerDelegate,D4_CollegeSelectorControllerDelegate>
AS_CELL_STRUCT_(profile)
AS_CELL_STRUCT_(ID)
AS_CELL_STRUCT_(mail)
AS_CELL_STRUCT_(name)
AS_CELL_STRUCT_(sex)
AS_CELL_STRUCT_(age)
AS_CELL_STRUCT_(exit)

AS_CELL_STRUCT_(location)
AS_CELL_STRUCT_(school)
AS_CELL_STRUCT_(teacher)
AS_CELL_STRUCT_(shenfenzheng)

AS_CELL_STRUCT_(interest)
//AS_CELL_STRUCT_(introduce)
AS_CELL_STRUCT_(support)
@end

@implementation D1_PersonalCenterController
@synthesize dataDictionary = _dataDictionary;

GET_CELL_STRUCT_1(profile, 头像,NO,YES,60,YES,YES)
GET_CELL_STRUCT_3(ID, 会员ID号,NO,NO)
GET_CELL_STRUCT_3(mail, 邮箱地址,NO,NO)
GET_CELL_STRUCT_(name, 姓名)
GET_CELL_STRUCT_(sex, 性别)
GET_CELL_STRUCT_(age, 年龄)

GET_CELL_STRUCT_(location, 地区)
GET_CELL_STRUCT_(school, 高校)
GET_CELL_STRUCT_(teacher, 指导老师)
GET_CELL_STRUCT_(shenfenzheng, 身份证)

GET_CELL_STRUCT_(interest, 感兴趣类别)
GET_CELL_STRUCT_(support, 资助类型)


GET_CELL_STRUCT_DICTIONARY(exit, (@{key_cellstruct_delegate:self,
                                    key_cellstruct_selector:@"selectAction:",
                                    key_cellstruct_title:@"切换角色",
                                    key_cellstruct_background:KT_UIColorWithRGB(252, 64, 78),
                                    key_cellstruct_titlecolor:value_cellstruct_write,
                                    key_cellstruct_sectionfooterheight:@20,
                                    key_cellstruct_textAlignment:value_cellstruct_textAlignment_center,
                                    key_cellstruct_accessory:@0}))

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self userDefaultBackground];
    [self.navigationbar setTitle:@"个人中心"];
    [self showhbnavigationbarBackItem:YES];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    
    RES_Login_Info * loginfo = [GlobalData sharedInstance].m_login_info;
    
    self.cell_struct_profile.picture = loginfo.m_headpic;
    self.cell_struct_ID.detailtitle = loginfo.m_mid;
    self.cell_struct_mail.detailtitle = loginfo.m_email;
    self.cell_struct_name.detailtitle = loginfo.m_nickname;
    self.cell_struct_sex.detailtitle = loginfo.m_sex;
    self.cell_struct_age.detailtitle = loginfo.m_age;
    
    self.cell_struct_location.detailtitle = loginfo.m_schoolCity;
    self.cell_struct_school.detailtitle = loginfo.m_schoolName;
    self.cell_struct_teacher.detailtitle = loginfo.m_teacher;
    self.cell_struct_shenfenzheng.detailtitle = loginfo.m__id;
    
    self.cell_struct_interest.detailtitle = loginfo.m_interest;
    self.cell_struct_support.detailtitle = loginfo.m_support;
    
    [self loadDataDictionary:loginfo];
    
    [self setQBImagePickerControllerCameraDelegate:self];
    [self setUIViewControllerQBImagePickerDelegate:self];
    
    ADD_HBSIGNAL_OBSERVER(self, @"confirm", NSStringFromClass([D2_EditInfoViewController class]))
}

-(void)dealloc
{
    REMOVE_HBSIGNAL_OBSERVER(self, @"confirm", NSStringFromClass([D2_EditInfoViewController class]))
}

-(void)loadDataDictionary:(RES_Login_Info *)loginfo
{
    if ([loginfo.m_typeId isEqualToString:VALUE_MEMBER_NORMAL]) {
        self.dataDictionary = [self normalMemberDic];
    }
    else if ([loginfo.m_typeId isEqualToString:VALUE_MEMBERTYPE_PLAYER]) {
        self.dataDictionary = [self playerMemberDic];
    }
    else if ([loginfo.m_typeId isEqualToString:VALUE_MEMBERTYPE_VC]) {
        self.dataDictionary = [self vcMemberDic];
    }
    else
    {
       self.dataDictionary = [self normalMemberDic];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 行选处理


ON_HBSIGNAL(D2_EditInfoViewController , confirm, notify)
{
    NSString * object = notify.object; 
    NSArray * compants = [object componentsSeparatedByString:@":"];
    if (compants.count == 2) {
        NSString * celltype = compants[0];
        if (celltype.integerValue == edit_type_nickname) {//昵称
            self.cell_struct_name.detailtitle = compants[1];
            [GlobalData sharedInstance].m_login_info.m_nickname = compants[1];
            
            [perfectMemberModel perfectMemberWithNickName:compants[1] response:^(NSDictionary *Dictionary) {
                [self loadDataDictionary:[GlobalData sharedInstance].m_login_info];
                [[GlobalData sharedInstance] synchronize_m_login_info];
                [self.tableView reloadData]; 
                SEND_HBSIGNAL(@"User", @"loginfochange", nil)
            } errorHandler:^(NSError *error) {
            }];
        }
        else if (celltype.integerValue == edit_type_teacher) {
            self.cell_struct_teacher.detailtitle = compants[1];
            [GlobalData sharedInstance].m_login_info.m_teacher = compants[1];
            [perfectMemberModel perfectMemberWithteacher:compants[1] response:^(NSDictionary *Dictionary) {
                [self loadDataDictionary:[GlobalData sharedInstance].m_login_info];
                [[GlobalData sharedInstance] synchronize_m_login_info];
                [self.tableView reloadData];
            } errorHandler:^(NSError *error) {
            }];
        }
        else if(celltype.integerValue == edit_type_sex )
        {
            self.cell_struct_sex.detailtitle = compants[1];
            [GlobalData sharedInstance].m_login_info.m_sex = compants[1];
            NSString * membervalue = [[GlobalData sharedInstance] getSexValueFromKey:compants[1]] ;
            [perfectMemberModel perfectMemberWithsex:membervalue response:^(NSDictionary *Dictionary) {
                [self loadDataDictionary:[GlobalData sharedInstance].m_login_info];
                [[GlobalData sharedInstance] synchronize_m_login_info];
                [self.tableView reloadData];
            } errorHandler:^(NSError *error) {
                
            }];
        }
        else if(celltype.integerValue == edit_type_age )
        {
            self.cell_struct_age.detailtitle = compants[1];
            [GlobalData sharedInstance].m_login_info.m_age = compants[1];
            [perfectMemberModel perfectMemberWithage:compants[1] response:^(NSDictionary *Dictionary) {
                [self loadDataDictionary:[GlobalData sharedInstance].m_login_info];
                [[GlobalData sharedInstance] synchronize_m_login_info];
                [self.tableView reloadData];
            } errorHandler:^(NSError *error) {
                
            }];
        }
        else if(celltype.integerValue == edit_type_idcount)
        {
            self.cell_struct_shenfenzheng.detailtitle = compants[1];
            [GlobalData sharedInstance].m_login_info.m__id = compants[1];
            [perfectMemberModel perfectMemberWithidentify:compants[1] response:^(NSDictionary *Dictionary) {
                [self loadDataDictionary:[GlobalData sharedInstance].m_login_info];
                [[GlobalData sharedInstance] synchronize_m_login_info];
                [self.tableView reloadData];
            } errorHandler:^(NSError *error) {
                
            }];
        }
    }
}


-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    if (cellstruct == self.cell_struct_exit) {
        
       PXAlertView * alert = [PXAlertView showAlertWithTitle:@"提示" message:@"您目前有一次机会可以升级到参赛选手角色，是否升级？" cancelTitle:@"取消" otherTitle:@"确定" buttonsShouldStack:NO completion:^(BOOL cancelled, NSInteger buttonIndex) {
           
            if (buttonIndex == 1) {
            
                [perfectMemberModel perfectMemberWithTypeID:VALUE_MEMBERTYPE_PLAYER response:^(NSDictionary *Dictionary) {
                    
                    [GlobalData sharedInstance].m_login_info.m_typeId = VALUE_MEMBERTYPE_PLAYER;
                    [[GlobalData sharedInstance] synchronize_m_login_info];
                    [self loadDataDictionary: [GlobalData sharedInstance].m_login_info];
                    [self.tableView reloadData];
                    
                } errorHandler:^(NSError *error) {
                    
                }];
            }
        }];
        [alert useDefaultIOS7Style];
    }
    else if(cellstruct == self.cell_struct_profile)
    {//TODO:选照片
        [UIActionSheet actionSheetWithTitle:nil message:@"请选择" buttons:@[@"拍照",@"从手机相册选择"] showInView:self.view onDismiss:^(int buttonIndex) {
           
            if (buttonIndex == 0) {
                [self presentCameraViewControllerWithAnimated:YES completion:nil];
            }
            else
            {
                [self presentAblumViewControllerWithAnimated:YES completion:nil];
            }
        } onCancel:^{
            
        }];
    }
    else if(cellstruct == self.cell_struct_sex)
    {
        D2_EditInfoViewController * ctr = [[D2_EditInfoViewController alloc] init];
        ctr.edit_type = edit_type_sex;
        ctr.value = self.cell_struct_sex.detailtitle;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_name)
    {
        D2_EditInfoViewController * ctr = [[D2_EditInfoViewController alloc] init];
        ctr.edit_type = edit_type_nickname;
        ctr.value = self.cell_struct_name.detailtitle;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_age)
    {
        D2_EditInfoViewController * ctr = [[D2_EditInfoViewController alloc] init];
        ctr.edit_type = edit_type_age;
        ctr.value = self.cell_struct_age.detailtitle;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_location || cellstruct == self.cell_struct_school)
    {
//        D2_EditInfoViewController * ctr = [[D2_EditInfoViewController alloc] init];
//        ctr.edit_type = edit_type_location;
//        ctr.value = self.cell_struct_location.detailtitle;
        D4_CollegeSelectorController * ctr = [[D4_CollegeSelectorController alloc] init];
        ctr.selectordelegate = self;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_teacher)
    {
        D2_EditInfoViewController * ctr = [[D2_EditInfoViewController alloc] init];
        ctr.edit_type = edit_type_teacher;
        ctr.value = self.cell_struct_teacher.detailtitle;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_shenfenzheng)
    {
        D2_EditInfoViewController * ctr = [[D2_EditInfoViewController alloc] init];
        ctr.edit_type = edit_type_idcount;
        ctr.value = self.cell_struct_shenfenzheng.detailtitle;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    
}

#pragma mark - delegate

-(void)D4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController selectCollageCityName:(NSString *)selectCollegeCityName selectCollegeCityID:(NSString *)selectCollegeCityID selectCollegeName:(NSString *)collegeName collegeID:(NSString *)collegeID
{
    [perfectMemberModel perfectMemberWithchoolid:collegeID response:^(NSDictionary *Dictionary) {
        if ([Dictionary isErrorObject]) {
            
        }
        else
        { 
            self.cell_struct_location.detailtitle = selectCollegeCityName;
            self.cell_struct_school.detailtitle = collegeName;
            [GlobalData sharedInstance].m_login_info.m_schoolName = collegeName;
            [GlobalData sharedInstance].m_login_info.m_schoolCity = selectCollegeCityName;
            
            [self loadDataDictionary:[GlobalData sharedInstance].m_login_info];
            [[GlobalData sharedInstance] synchronize_m_login_info];
            [self.tableView reloadData];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

-(void)hb_imagePickerController:(UIViewController *)imagePickerController didSelectImage:(UIImage *)image
{
    NSLog(@"%s",__func__);
    [self loadHeadPic:image];
    
}

-(void)loadHeadPic:(UIImage *)image
{
    NSLog(@"%s",__func__);
    [self presentLoadingTips:@"正在上传..."];
    [perfectMemberModel perfectMemberWithheadpic:[perfectMemberModel imagedata:image] response:^(NSDictionary *Dictionary) {
        
        if ([Dictionary isErrorObject]) {
            APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips_:error.m_errorMsg];
        }
        else
        {
            [self dismissAllTips];
            RES_PerfectMember * res = [perfectMemberModel encodeDiction:Dictionary];
            NSLog(@"%@",res.m_headpic);
            [GlobalData sharedInstance].m_login_info.m_headpic = res.m_headpic;
            [[GlobalData sharedInstance] synchronize_m_login_info];
            self.cell_struct_profile.picture = res.m_headpic;
            [self.tableView reloadData];
            SEND_HBSIGNAL(@"User", @"loginfochange", nil)
        }
    } errorHandler:^(NSError *error) {
        
    }];
}


-(void)hb_imagePickerController:(UIViewController *)viewController cameraDidFinishPickingMediaWithImage:(UIImage *)image
{
    NSLog(@"%s",__func__);
    [self loadHeadPic:image];
}


#pragma mark -

-(NSMutableDictionary *)playerMemberDic
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.cell_struct_profile,KEY_INDEXPATH(0, 0),
                                 self.cell_struct_ID,KEY_INDEXPATH(0, 1),
                                 self.cell_struct_mail,KEY_INDEXPATH(0, 2),
                                 self.cell_struct_name,KEY_INDEXPATH(0, 3),
                                 self.cell_struct_sex,KEY_INDEXPATH(0, 4),
                                 self.cell_struct_age,KEY_INDEXPATH(0, 5),
                                 self.cell_struct_location,KEY_INDEXPATH(1, 0),
                                 self.cell_struct_school,KEY_INDEXPATH(1, 1),
                                 self.cell_struct_teacher,KEY_INDEXPATH(1, 2),
                                 self.cell_struct_shenfenzheng,KEY_INDEXPATH(1, 3)
                                 , nil];
    return dic;
}


-(NSMutableDictionary *)normalMemberDic
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.cell_struct_profile,KEY_INDEXPATH(0, 0),self.cell_struct_ID,KEY_INDEXPATH(0, 1),self.cell_struct_mail,KEY_INDEXPATH(0, 2),self.cell_struct_name,KEY_INDEXPATH(0, 3),self.cell_struct_sex,KEY_INDEXPATH(0, 4),self.cell_struct_age,KEY_INDEXPATH(0, 5),self.cell_struct_exit,KEY_INDEXPATH(1, 0), nil];
    return dic;
}

-(NSMutableDictionary *)vcMemberDic
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 self.cell_struct_profile,KEY_INDEXPATH(0, 0),
                                 self.cell_struct_ID,KEY_INDEXPATH(0, 1),
                                 self.cell_struct_mail,KEY_INDEXPATH(0, 2),
                                 self.cell_struct_name,KEY_INDEXPATH(0, 3),
                                 self.cell_struct_sex,KEY_INDEXPATH(0, 4),
                                 self.cell_struct_age,KEY_INDEXPATH(0, 5),
                                 self.cell_struct_interest,KEY_INDEXPATH(1, 0),
                                 self.cell_struct_support,KEY_INDEXPATH(1, 1),nil];
    return dic;
}


-(CELL_STRUCT *)cell_x_x_struct:(NSString *)title detailvalue:(NSString *)detailvalue
{
    return [self cell_x_x_struct:title detailvalue:detailvalue footerheight:0 selectionStyle:YES accessory:YES];
}

-(CELL_STRUCT *)cell_x_x_struct:(NSString *)title detailvalue:(NSString *)detailvalue footerheight:(CGFloat)footerheight selectionStyle:(BOOL)selectionStyle accessory:(BOOL)accessory 
{
    return [self cell_x_x_struct:title detailvalue:detailvalue footerheight:0 selectionStyle:selectionStyle accessory:accessory cellheight:40 imageRight:NO imageCornerRadius:NO];
}


-(CELL_STRUCT *)cell_x_x_struct:(NSString *)title detailvalue:(NSString *)detailvalue footerheight:(CGFloat)footerheight selectionStyle:(BOOL)selectionStyle accessory:(BOOL)accessory cellheight:(CGFloat)cellheight imageRight:(BOOL)imageRight imageCornerRadius:(BOOL)imageCornerRadius
{
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:title cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell1_0.selectionStyle = selectionStyle;
    cell1_0.cellheight = cellheight;
    cell1_0.detailtitle = detailvalue?detailvalue:@"";
    cell1_0.sectionheight = footerheight;
    cell1_0.imageCornerRadius = imageCornerRadius;
    cell1_0.sectionfooterheight = footerheight;
    cell1_0.accessory = accessory;
    cell1_0.imageRight = imageRight;
    cell1_0.titlecolor = @"black";
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
    return cell1_0;
}



@end
