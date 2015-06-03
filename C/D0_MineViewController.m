//
//  D0_MineViewController.m
//  JXL
//
//  Created by BooB on 15-4-14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D0_MineViewController.h"
#import "D0LoginCell.h"
#import "D1_RegisterView1Controller.h"
#import "RootViewController.h"
#import "D1_OpinionReportViewController.h"
#import "D1_AboutUsViewController.h"
#import "BaseJXLViewController.h"
#import "D1_LoginViewController.h" 
#import "CELL_STRUCT_KEY.h"
#import "jxl.h"
#import "D1_PersonalCenterController.h"
#import "D0_MineProfileTableViewCell.h"
#import "D1_TakePartInViewController.h"
#import "D1_PersonDynamicViewController.h"
#import "ShareModel.h"
//
//cell1_0.key_indexpath = KEY_INDEXPATH(1, 0);

#define GET_MINECELL_STRUCT(OBJ,TITLE,PICTURE,PUSHCTR) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [self create_main_cellstruct:TITLE cellclass:@"BaseTableViewCell" picture:PICTURE pushcontroller:PUSHCTR];\
}\
return _cell_struct_##OBJ;}

#define GET_MINECELL_STRUCTX(OBJ,TITLE,PICTURE,PUSHCTR) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [self create_main_cellstruct:TITLE cellclass:@"BaseTableViewCell" picture:PICTURE pushcontroller:PUSHCTR];\
[_cell_struct_##OBJ.dictionary  setObject:@"xib" forKey:key_cellstruct_pushcontroller_xib];\
}\
return _cell_struct_##OBJ;}

@interface D0_MineViewController ()
AS_CELL_STRUCT_JXLCOMMON(exit)
AS_CELL_STRUCT_JXLCOMMON(login)
AS_CELL_STRUCT_JXLCOMMON(profile)
AS_CELL_STRUCT_JXLCOMMON(mypage)
AS_CELL_STRUCT_JXLCOMMON(myactive)
AS_CELL_STRUCT_JXLCOMMON(myproject)
AS_CELL_STRUCT_JXLCOMMON(feedback)
AS_CELL_STRUCT_JXLCOMMON(aboutus)
AS_CELL_STRUCT_JXLCOMMON(share)

@end

@implementation D0_MineViewController
@synthesize dataDictionary = _dataDictionary;
//GET_CELL_STRUCT_1(exit, 退出登录, NO, NO, 40, NO, NO,self, @selector(exit:))
//GET_CELL_STRUCT_WITH(exit, 退出登录, self, @selector(exit:))
GET_CELL_STRUCT_DICTIONARY(exit, (@{key_cellstruct_delegate:self,
                                    key_cellstruct_selector:@"exit:",
                                    key_cellstruct_title:@"退出登录",
                                    key_cellstruct_background:KT_UIColorWithRGB(252, 64, 78),
                                    key_cellstruct_titlecolor:value_cellstruct_write,
                                    key_cellstruct_textAlignment:value_cellstruct_textAlignment_center,
                                    key_cellstruct_accessory:@0}))
GET_MINECELL_STRUCT(myproject, @"我的项目", @"me_myproject_icon", @"D1_TakePartInViewController")

GET_MINECELL_STRUCT(mypage, @"我的主页", @"main_main_icon_normal", @"D1_PersonDynamicViewController")
GET_MINECELL_STRUCT(myactive, @"我报名的活动", @"me_active_icon", @"BaseJXLViewController")
GET_MINECELL_STRUCTX(share, @"分享", @"me_feedback_icon", @"")
GET_MINECELL_STRUCTX(feedback, @"意见反馈", @"me_feedback_icon", @"D1_OpinionReportViewController")
GET_MINECELL_STRUCT(aboutus, @"关于我们", @"me_about_icon", @"D1_AboutUsViewController")

-(IBAction)exit:(id)sender
{
    PXAlertView * alert = [PXAlertView showAlertWithTitle:@"提示" message:@"是否要退出登陆？" cancelTitle:@"取消" otherTitle:@"确定" buttonsShouldStack:NO completion:^(BOOL cancelled, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            [[GlobalData sharedInstance] RemoveGlobalData];
            [self presentMessageTips_:@"正在退出" dismisblock:^{
                SEND_HBSIGNAL(@"User", @"logout", nil);
//                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
    [alert useDefaultIOS7Style];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"我";
    self.tableView.backgroundColor = JXL_COLOR_THEME; // [UIColor whiteColor];
    [self userDefaultBackground];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:HEIGHT_TABBAR];
    [self.navigationbar setTitle:@"我"];
     self.navigationbar.backgroundColor = JXL_COLOR_THEME_NAVIGATIONBAR ;
//    [self loadData];
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D0LoginCell");
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D0_MineProfileTableViewCell")
    
    ADD_HBSIGNAL_OBSERVER(self,@"login",@"D1_LoginViewController")
    ADD_HBSIGNAL_OBSERVER(self,@"logout",@"User")
    ADD_HBSIGNAL_OBSERVER(self,@"loginfochange",@"User")
}

-(void)viewWillAppear:(BOOL)animated
{
    self.statusBarStyleDefault = NO;
}

-(void)dealloc
{
    REMOVE_HBSIGNAL_OBSERVER(self,@"loginfochange",@"User")
    REMOVE_HBSIGNAL_OBSERVER(self,@"logout",@"User")
    REMOVE_HBSIGNAL_OBSERVER(self,@"login",@"D1_LoginViewController")
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableDictionary *)reloadDataDictionary
{
    NSString * m_typeId = [GlobalData sharedInstance].m_login_info.m_typeId;
    if (![GlobalData sharedInstance].m_mid) {
        _dataDictionary = [self unlogindictionary];
    }
    else if ([m_typeId isEqualToString:VALUE_MEMBER_NORMAL]) {
        _dataDictionary = [self normaluserdictionary];
    }
    else if ([m_typeId isEqualToString:VALUE_MEMBERTYPE_PLAYER]) {
        _dataDictionary = [self playerdictionary];
    }
    else if ([m_typeId isEqualToString:VALUE_MEMBERTYPE_VC]) {
        _dataDictionary = [self vcdictionary];
    }
    return _dataDictionary;
}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [self reloadDataDictionary];
    }
    return _dataDictionary;
}

ON_HBSIGNAL(User, loginfochange, notify)//状态改变
{
    self.dataDictionary = [self reloadDataDictionary];
    [self.tableView reloadData];
}

ON_HBSIGNAL(User, logout, notify)
{
    self.cell_struct_profile = nil;
      self.dataDictionary = [self reloadDataDictionary]; 
      [self.tableView reloadData];
}

ON_HBSIGNAL(D1_LoginViewController, login, notify)
{ 
    self.dataDictionary = [self reloadDataDictionary];
    [self.tableView reloadData];
}



-(IBAction)selectAction:(id)sender
{
    
    CELL_STRUCT *cellstruct = (CELL_STRUCT *)sender;
    if (cellstruct == self.cell_struct_share) {
        
        [[ShareModel sharedInstance] openShareViewWithViewController:self content:@"金项恋" fontIndex:1 image:nil];
        return;
    }
    BOOL allpass = NO;
    
    if ([GlobalData sharedInstance].m_mid) {
        allpass = YES;
    }
    
    if ([self isyijianfankui:cellstruct] || [self isaboutuscell:cellstruct]) {
        allpass = YES;
    }
    
    if (NO == allpass) {
        D1_LoginViewController * ctr = [[D1_LoginViewController alloc] init];
        [[RootViewController sharedInstance].navigationController pushViewController:ctr animated:YES];
        return;
    }
    
    NSString * Classname = @"BaseTableViewController";
    NSString * ControllType = nil;
    if (cellstruct.dictionary) {
        Classname = [cellstruct.dictionary objectForKey:key_cellstruct_pushcontroller]; //cellstruct.object;
        Classname = Classname?Classname:@"BaseTableViewController";
        ControllType= [cellstruct.dictionary objectForKey:key_cellstruct_pushcontroller_xib];
    }
    Class cls = NSClassFromString(Classname);
    BaseViewController * ctr = nil;
    if(ControllType && [ControllType isEqualToString:@"xib"])
    {
        ctr = [[cls alloc] initWithNibName:Classname bundle:nil];
    }
    else
    {
        ctr = [[cls alloc] init];
    }
    ctr.title = cellstruct.title;
    [[RootViewController sharedInstance].navigationController pushViewController:ctr animated:YES];
    
}


#pragma mark - setter getter


-(BOOL)ispersonalcell:(CELL_STRUCT *)cellstruct
{
    return cellstruct == self.cell_struct_mypage;
}

-(BOOL)isyijianfankui:(CELL_STRUCT *)cellstruct
{
    return cellstruct == self.cell_struct_feedback; //[cellstruct.key_indexpath isEqualToString:KEY_INDEXPATH(3, 0)];
}

-(BOOL)isaboutuscell:(CELL_STRUCT *)cellstruct
{
    return cellstruct == self.cell_struct_aboutus; //[cellstruct.key_indexpath isEqualToString:KEY_INDEXPATH(3, 1)];
}


-(NSMutableDictionary *)unlogindictionary
{
    NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.cell_struct_login,KEY_INDEXPATH(0, 0),
                                   self.cell_struct_mypage,KEY_INDEXPATH(0, 1),
                                   self.cell_struct_myproject,KEY_INDEXPATH(0, 2),
                                   self.cell_struct_myactive,KEY_INDEXPATH(0, 3),
                                   self.cell_struct_share,KEY_INDEXPATH(1, 0),
                                   self.cell_struct_feedback,KEY_INDEXPATH(1, 1),
                                   self.cell_struct_aboutus,KEY_INDEXPATH(1, 2),nil];
    return array0;
}

-(NSMutableDictionary *)normaluserdictionary
{
    NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.cell_struct_profile,KEY_INDEXPATH(0, 0),
                                   self.cell_struct_mypage,KEY_INDEXPATH(1, 0),
                                   self.cell_struct_myactive,KEY_INDEXPATH(1, 1),
                                   self.cell_struct_share,KEY_INDEXPATH(2, 0),
                                   self.cell_struct_feedback,KEY_INDEXPATH(2, 1),
                                   self.cell_struct_aboutus,KEY_INDEXPATH(2, 2),
                                   self.cell_struct_exit,KEY_INDEXPATH(3, 0),nil];
    return array0;
}

-(NSMutableDictionary *)playerdictionary
{
    NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.cell_struct_profile,KEY_INDEXPATH(0, 0),
                                   self.cell_struct_mypage,KEY_INDEXPATH(1, 0),
                                   self.cell_struct_myproject,KEY_INDEXPATH(1, 1),
                                   self.cell_struct_myactive,KEY_INDEXPATH(1, 2),
                                   self.cell_struct_share,KEY_INDEXPATH(2, 0),
                                   self.cell_struct_feedback,KEY_INDEXPATH(2,1),
                                   self.cell_struct_aboutus,KEY_INDEXPATH(2, 2),
                                   self.cell_struct_exit,KEY_INDEXPATH(3, 0),nil];
    return array0;
}

-(NSMutableDictionary *)vcdictionary
{
    NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.cell_struct_profile,KEY_INDEXPATH(0, 0),
                                   self.cell_struct_mypage,KEY_INDEXPATH(1, 0),
                                   self.cell_struct_myactive,KEY_INDEXPATH(1, 1),
                                   self.cell_struct_share,KEY_INDEXPATH(2, 0),
                                   self.cell_struct_feedback,KEY_INDEXPATH(2, 1),
                                   self.cell_struct_aboutus,KEY_INDEXPATH(2, 2),
                                   self.cell_struct_exit,KEY_INDEXPATH(3, 0),nil];
    return array0;
}




-(CELL_STRUCT *)create_main_cellstruct:(NSString *)title cellclass:(NSString *)cellclass picture:(NSString *)picture pushcontroller:(NSString *)pushcontroller
{
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:title cellclass:cellclass placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell1_0.picture = picture;
//    cell1_0.picturecolor = @"gray";
    cell1_0.selectionStyle = YES;
    cell1_0.cellheight = 40;
    cell1_0.sectionheight = 30;
    cell1_0.accessory = YES;
    cell1_0.titlecolor = @"black";
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_pushcontroller:pushcontroller}];
    return cell1_0;
}

-(CELL_STRUCT *)cell_struct_profile
{
    if (!_cell_struct_profile) {
        
        NSString * nickname =  [GlobalData sharedInstance].m_login_info.m_nickname;
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:nickname cellclass:@"D0_MineProfileTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.detailtitle = [GlobalData sharedInstance].m_login_info.m_typeName;
        cell0_0.picture = [GlobalData sharedInstance].m_login_info.m_headpic;
        cell0_0.cellheight = 80;
        cell0_0.selectionStyle = NO;
        cell0_0.imageCornerRadius = YES;
        cell0_0.sectionheight = 25;
        cell0_0.sectionfooterheight = 0;
        cell0_0.subvalue1 = @"xib";
        cell0_0.titlecolor = @"black";
        cell0_0.key_indexpath = KEY_INDEXPATH(0, 0);
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_pushcontroller:@"D1_PersonalCenterController"}];
        
        _cell_struct_profile = cell0_0;
    }
    return _cell_struct_profile;
}

-(CELL_STRUCT *)cell_struct_login
{
    if (!_cell_struct_login) {
        
    CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"登陆" cellclass:@"D0LoginCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
    cell0_0.picture = @"rightmenu_userphoto";
    cell0_0.cellheight = 80;
    cell0_0.accessory = NO;
    cell0_0.selectionStyle = NO;
    cell0_0.imageCornerRadius = YES;
    cell0_0.sectionheight = 20;
    cell0_0.sectionfooterheight = 0;
    cell0_0.titlecolor = @"black";
    cell0_0.subvalue1 = @"xib";
    cell0_0.key_indexpath = KEY_INDEXPATH(0, 0);
    cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor],key_cellstruct_pushcontroller:@"D1_LoginViewController",key_cellstruct_pushcontroller_xib:@""}];
        _cell_struct_login = cell0_0;
    }
    return _cell_struct_login;
}
@end
