//
//  RightViewController.m
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "RightViewController.h"
#import "JXL_Define.h"
#import "AppDelegate.h"
#import "BaseJXLViewController.h"
#import "jxl.h"
#import "D1_PersonalCenterController.h"
#import "D1_LoginViewController.h"
#import "D1_AboutUsViewController.h"
#import "D1_OpinionReportViewController.h"
#import "D1_TakePartInViewController.h"
#import "UIButton+Alignment.h"
#define GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR_HEIGHT_ROUND(OBJ,TITLE,IMAGE,HEIGHT,ROUND) \
-(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [JXL_Common cell_x_x_struct:@#TITLE detailvalue:nil \
footerheight:20 \
selectionStyle:YES  \
accessory:NO \
cellheight:HEIGHT \
imageRight:NO \
imageCornerRadius:ROUND \
picture:IMAGE \
target:self \
selectAction:@selector(selectAction:) \
background:[UIColor clearColor] titlecolor:@"white"];}\
return _cell_struct_##OBJ;}

#define GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR(OBJ,TITLE,IMAGE) \
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR_HEIGHT(OBJ,TITLE,IMAGE,90)

#define GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR_HEIGHT(OBJ,TITLE,IMAGE,HEIGHT) \
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR_HEIGHT_ROUND(OBJ,TITLE,IMAGE,60,NO)


//

@interface RightViewController ()
@property(nonatomic,retain) UIView * exitLoginView;
AS_CELL_STRUCT_JXLCOMMON(profile)
AS_CELL_STRUCT_JXLCOMMON(myshouye)
AS_CELL_STRUCT_JXLCOMMON(cansaibaoming)
AS_CELL_STRUCT_JXLCOMMON(myinfo)
AS_CELL_STRUCT_JXLCOMMON(yijianfankui)
AS_CELL_STRUCT_JXLCOMMON(aboutus)
AS_CELL_STRUCT_JXLCOMMON(shengji)

@end

@implementation RightViewController

GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR_HEIGHT_ROUND(profile, 登录,@"right_touxiang",70,YES)
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR(myshouye, 我的首页,@"rightmenu_memain_icon")
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR(cansaibaoming, 报名参赛,@"rightmenu_comments")
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR(myinfo, 我的资料,@"rightmenu_user")
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR(yijianfankui,意见反馈,@"message")
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR(aboutus,关于我们,@"rightmenu_info")
GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE_CLEAR(shengji,升级,@"left_xiangmuzhongxin")


@synthesize dataDictionary = _dataDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    
    REMOVE_HBSIGNAL_OBSERVER(self, @"loginfochange", @"User")
    REMOVE_HBSIGNAL_OBSERVER(self, @"logout", @"User")
    REMOVE_HBSIGNAL_OBSERVER(self, @"login", @"D1_LoginViewController")
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self changeBackGroundWithBackImage:[UIImage imageNamed:@"menu_background.jpg"]];
    //    self.view.backgroundColor = [UIColor whiteColor];
    //    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left_background"]];
    self.tableView.scrollEnabled = NO;
    
    self.tableView.frame = CGRectMake((UISCREEN_BOUNDS.size.width/2), 0, (UISCREEN_BOUNDS.size.width)/2, UISCREEN_BOUNDS.size.height - 40);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
 
    ADD_HBSIGNAL_OBSERVER(self,@"login", @"D1_LoginViewController")
    ADD_HBSIGNAL_OBSERVER(self, @"logout", @"User")
    ADD_HBSIGNAL_OBSERVER(self, @"loginfochange", @"User")
    [self loadDataWithLoginfo];
    
    // Do any additional setup after loading the view.
}

-(UIView *)exitLoginView
{
    if (!_exitLoginView) {
        UIView * footerview = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.left, self.tableView.bottom, self.tableView.width , 40)];
        //    footerview.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UIButton * button = [ToolsFunc CreateButtonWithFrame:CGRectMake(10, 0, 120, 30) andTxt:@"   退出登录" andImage:[UIImage imageNamed:@"logout_icon"]];
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
        [button setLayout:OTSTitleLeftImageRightStyle spacing:5];
        [footerview addSubview:button];
        _exitLoginView = footerview;
    }
    return _exitLoginView;
}

#pragma mark - 

-(void)selectAction:(id)sender
{
    CELL_STRUCT *  cellstruct = (CELL_STRUCT *)sender;
    
    [AppdelegateSideViewController hideSideViewController:true];
     
    UIViewController * ctr = nil;
    
    if (cellstruct == self.cell_struct_profile ) {
        
        if (![GlobalData sharedInstance].m_mid) {
            ctr = [[D1_LoginViewController alloc] init];
        }
    }
    else if(cellstruct == self.cell_struct_myinfo)
    {
        if (![GlobalData sharedInstance].m_mid) {
            ctr = [[D1_LoginViewController alloc] init];
        }else
        ctr = [[D1_PersonalCenterController  alloc] init];
    }
    else if(cellstruct == self.cell_struct_yijianfankui)
    {
        ctr = [[D1_OpinionReportViewController alloc] init];
    }
    else if(cellstruct == self.cell_struct_aboutus)
    {
        ctr = [[D1_AboutUsViewController alloc] init];
    }
    else if(cellstruct == self.cell_struct_cansaibaoming)
    {
        if (![GlobalData sharedInstance].m_mid) {
            ctr = [[D1_LoginViewController alloc] init];
        }
        else
            ctr = [[D1_TakePartInViewController alloc] init];
    }
    if (ctr) {
        UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:ctr];
        [navigation setNavigationBarHidden:YES];
        [[RootViewController sharedInstance] rootpresentViewController:navigation animated:YES completion:nil];
    }
}



-(IBAction)exit:(id)sender
{
    PXAlertView * alert = [PXAlertView showAlertWithTitle:@"提示" message:@"是否要退出登陆？" cancelTitle:@"取消" otherTitle:@"确定" buttonsShouldStack:NO completion:^(BOOL cancelled, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            [[GlobalData sharedInstance] RemoveGlobalData];
            [AppdelegateSideViewController.view.window presentMessageTips_:@"正在退出..." dismisblock:^{
                SEND_HBSIGNAL(@"User", @"logout", nil);
            }];
        }
    }];
    [alert useDefaultIOS7Style];
}

ON_HBSIGNAL(User, loginfochange, notify)
{
    [self loadDataWithLoginfo];
}
ON_HBSIGNAL(D1_LoginViewController, login, notify)
{
    [self loadDataWithLoginfo];
}

ON_HBSIGNAL(User, logout, notify)
{
    [self loadDataWithLoginfo];
    
}
-(void)loadDataWithLoginfo
{
    
    if ([GlobalData sharedInstance].m_login_info) {
        self.cell_struct_profile.picture = [GlobalData sharedInstance].m_login_info.m_headpic;
        self.cell_struct_profile.title = [GlobalData sharedInstance].m_login_info.m_nickname;
    }
    
    if ([GlobalData sharedInstance].m_mid) {
        if ([[GlobalData sharedInstance].m_login_info.m_typeId isEqualToString:VALUE_MEMBER_NORMAL])  {
            self.dataDictionary = [self nomarlmemberDictionary];
        }
        else if ([[GlobalData sharedInstance].m_login_info.m_typeId isEqualToString:VALUE_MEMBERTYPE_PLAYER])
        {
            self.dataDictionary = [self playerDictionary];
        }
        else if ([[GlobalData sharedInstance].m_login_info.m_typeId isEqualToString:VALUE_MEMBERTYPE_VC])
        {
            self.dataDictionary = [self vcmemberDictionary];
        }
        [self.view  addSubview:self.exitLoginView];
        [self.view bringSubviewToFront:self.exitLoginView];
    }
    else
    {
        self.cell_struct_profile.picture = @"rightmenu_userphoto";
        self.cell_struct_profile.title = @"登录";
        self.dataDictionary = [self unloginDictionary];
        
        [self.exitLoginView removeFromSuperview];
    }
    [self.tableView reloadData];
    
}
#pragma mark -
-(NSMutableDictionary *)unloginDictionary
{
    NSDictionary * dic = [NSDictionary dictionary];
    
    dic = @{KEY_INDEXPATH(0, 0):self.cell_struct_profile,KEY_INDEXPATH(0, 1):self.cell_struct_cansaibaoming,KEY_INDEXPATH(0, 2):self.cell_struct_myinfo,KEY_INDEXPATH(0, 3):self.cell_struct_yijianfankui,KEY_INDEXPATH(0, 4):self.cell_struct_aboutus};
    
    return [NSMutableDictionary dictionaryWithDictionary:dic];
}

-(NSMutableDictionary *)nomarlmemberDictionary
{
    NSDictionary * dic = [NSDictionary dictionary];
    
    dic = @{KEY_INDEXPATH(0, 0):self.cell_struct_shengji,KEY_INDEXPATH(0, 1):self.cell_struct_myinfo,KEY_INDEXPATH(0, 2):self.cell_struct_myinfo,KEY_INDEXPATH(0, 3):self.cell_struct_yijianfankui,KEY_INDEXPATH(0, 4):self.cell_struct_aboutus};
    
    return [NSMutableDictionary dictionaryWithDictionary:dic];
}


-(NSMutableDictionary *)playerDictionary
{
    NSDictionary * dic = [NSDictionary dictionary];
    
    dic = @{KEY_INDEXPATH(0, 0):self.cell_struct_profile,KEY_INDEXPATH(0, 1):self.cell_struct_myshouye,KEY_INDEXPATH(0, 2):self.cell_struct_cansaibaoming,KEY_INDEXPATH(0, 3):self.cell_struct_myinfo,KEY_INDEXPATH(0, 4):self.cell_struct_yijianfankui,KEY_INDEXPATH(0, 5):self.cell_struct_aboutus};
    
    return [NSMutableDictionary dictionaryWithDictionary:dic];
}

-(NSMutableDictionary *)vcmemberDictionary
{
    NSDictionary * dic = [NSDictionary dictionary];
    
    dic = @{KEY_INDEXPATH(0, 0):self.cell_struct_profile,KEY_INDEXPATH(0, 1):self.cell_struct_myshouye,KEY_INDEXPATH(0, 2):self.cell_struct_myinfo,KEY_INDEXPATH(0, 3):self.cell_struct_yijianfankui,KEY_INDEXPATH(0, 4):self.cell_struct_aboutus};
    
    return [NSMutableDictionary dictionaryWithDictionary:dic];
}


//
//-(NSMutableDictionary *)dataDictionary
//{
//    if (!_dataDictionary) {
//        CELL_STRUCT * cell0_0;
//        CELL_STRUCT * cell0_1;
//        CELL_STRUCT * cell0_2;
//        CELL_STRUCT * cell0_3;
//        CELL_STRUCT * cell0_4;
//        
//        cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"头像" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
//        cell0_0.picture = @"right_touxiang";
//        cell0_0.cellheight = 60;
//        cell0_0.sectionheight = 25;
//        cell0_0.titlecolor = @"white";
//        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
//        
//        cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"我的项目" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
//        cell0_1.picture = @"left_xiangmuzhongxin";
//        cell0_1.selectionStyle = YES;
//        cell0_1.cellheight = 60;
//        cell0_1.titlecolor = @"white";
//        cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
//        
//        cell0_2 = [[CELL_STRUCT alloc] initWithtitle:@"我的评论" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
//        cell0_2.picture = @"right_pinlun";
//        cell0_2.selectionStyle = YES;
//        cell0_2.cellheight = 60;
//        cell0_2.titlecolor = @"white";
//        cell0_2.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
//        
//        cell0_3 = [[CELL_STRUCT alloc] initWithtitle:@"我的资料" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
//        cell0_3.picture = @"right_wodeziliao";
//        cell0_3.titlecolor = @"white";
//        cell0_3.cellheight = 60;
//        cell0_3.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
//        
//        
//        cell0_4 = [[CELL_STRUCT alloc] initWithtitle:@"关于我们" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
//        cell0_4.picture = @"right_wodeziliao";
//        cell0_4.titlecolor = @"white";
//        cell0_4.cellheight = 60;
//        cell0_4.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
//        
//        NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell0_1,KEY_INDEXPATH(0, 1),cell0_2,KEY_INDEXPATH(0, 2),cell0_3,KEY_INDEXPATH(0, 3),nil];
//        
//        _dataDictionary = array0;
//    }
//    return _dataDictionary;
//}
@end
