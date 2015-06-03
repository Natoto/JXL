//
//  D1_ProjectViewController.m
//  JXL
//
//  Created by BooB on 15-4-23.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "C1_ProjectViewController.h"
#import "RootViewController.h"
#import "C1_ProjectHeaderCell.h"
#import "C1_ProjectInfoCell.h"
#import "jxl.h"
#import "B2_NewsCommentViewController.h"
#import "TelephoneButtonCell.h"
#import "BaseViewController+ToolBar.h"
#import "D1_LoginViewController.h"
#define GET_PROJECTCELL_STRUCT(__OBJ,__TITLE) -(CELL_STRUCT *)cell_struct_##__OBJ\
{\
    if (!_cell_struct_##__OBJ) {\
        _cell_struct_##__OBJ = [self create_project_cellstruct:@#__TITLE];\
    }\
    return _cell_struct_##__OBJ;\
}

@interface C1_ProjectViewController ()
@property(nonatomic,retain) UIButton * btn_zan;
@property(nonatomic,retain) UIButton * btn_comment;
@property(nonatomic,retain) UIButton * btn_xiazai;
@property(nonatomic,retain) ProjectInfo_New * projectinfo ;
AS_CELL_STRUCT_JXLCOMMON(header)
AS_CELL_STRUCT_JXLCOMMON(projecttype)
AS_CELL_STRUCT_JXLCOMMON(school)
AS_CELL_STRUCT_JXLCOMMON(money)
AS_CELL_STRUCT_JXLCOMMON(teamname)
AS_CELL_STRUCT_JXLCOMMON(teamleader)
AS_CELL_STRUCT_JXLCOMMON(teamids)
AS_CELL_STRUCT_JXLCOMMON(teamdesc)
AS_CELL_STRUCT_JXLCOMMON(phone)
AS_CELL_STRUCT_JXLCOMMON(projectdesc)
@end

@implementation C1_ProjectViewController
@synthesize dataDictionary = _dataDictionary;

GET_PROJECTCELL_STRUCT(projecttype, 项目类型)
GET_PROJECTCELL_STRUCT(school, 所在学校)
GET_PROJECTCELL_STRUCT(money, 资金额度)
GET_PROJECTCELL_STRUCT(teamname, 团队名称)
GET_PROJECTCELL_STRUCT(teamleader, 团队负责)
GET_PROJECTCELL_STRUCT(teamids, 团队成员)
GET_PROJECTCELL_STRUCT(teamdesc, 团队描述)
GET_PROJECTCELL_STRUCT(projectdesc, )
GET_PROJECTCELL_STRUCT(phone, 联系电话)

- (void)viewDidLoad {
    [super viewDidLoad];
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"C1_ProjectHeaderCell")
    self.noHeaderFreshView = NO;
    [self userDefaultConfigWithTitle:@"项目详情"];
    [self addToolBar];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:self.navigationtoolsbar.height];
    [self.tableView headerBeginRefreshing];
//    [self refreshView];
     self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self projectDic]];
}

-(void)refreshView
{
    if (![GlobalData sharedInstance].m_mid) {
        [[RootViewController sharedInstance] rootpresentLoginViewController];
    }
    
    [[HTTPSEngine sharedInstance] fetch_findProjectById:self.m_projectid
                                                    mid:[GlobalData sharedInstance].m_mid
     jsonstring:^(NSString *jsonstring) {
         [self FinishedLoadData];
        if ([jsonstring isEqualToString:@"error"]) {
            [self presentMessageTips_:jsonstring];
        }
        else
        {
            ProjectInfo_New * projectinfo = [FindProjectByIdModel encodeJsonString:jsonstring];
            if (projectinfo) {
                self.projectinfo = projectinfo;
                [self dataChange:projectinfo];
                [self.tableView reloadData];                
            }
        }
    } errorHandler:^(NSError *error) {
    }];
}

-(void)dataChange:(ProjectInfo_New *)project
{
    NSArray * headerimageNameArray = project.team_photo_array;
    if (headerimageNameArray.count) {
        [self.cell_struct_header.dictionary setObject:headerimageNameArray forKey:key_projectheader_imageNameArray];
    }
    
    if(project.name)
    [self.cell_struct_header.dictionary setObject:project.name forKey:key_projectheader_discription];
    if(project.demandName)
    [self.cell_struct_header.dictionary setObject:project.demandName forKey:key_projectheader_state];
    
    if (project.schoolCity) {
       [self.cell_struct_header.dictionary setObject:project.schoolCity forKey:key_projectheader_location];
    }

    
    self.cell_struct_header.title = project.name;
    
    self.cell_struct_projecttype.value = project.typeName;
    self.cell_struct_projecttype.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
    self.cell_struct_school.value = [NSString stringWithFormat:@"%@",project.schoolName];
    
    self.cell_struct_money.value = project.financ_amount;
    
    self.cell_struct_teamname.value = project.team_name;
    self.cell_struct_teamname.sectiontitle = @"团队介绍";
    
    self.cell_struct_teamleader.array =[NSMutableArray arrayWithArray: project.team_member_headpic];// .teamember_headpic;
    
    self.cell_struct_teamids.array =[NSMutableArray arrayWithArray: project.team_photo_array];
    
    self.cell_struct_teamdesc .cellheight = 80;
    self.cell_struct_teamdesc .value = project.team_info;// .teainfo;
    self.cell_struct_teamdesc.cellheight = [C1_ProjectInfoCell heighofCell:project.team_info havetitle:YES];
    
    self.cell_struct_projectdesc.sectiontitle = @"项目介绍";
    self.cell_struct_projectdesc.value =project._description;
    self.cell_struct_projectdesc.cellheight = [C1_ProjectInfoCell heighofCell:project._description havetitle:NO];
    
    
    self.cell_struct_phone.cellclass = @"TelephoneButtonCell"; 
    self.cell_struct_phone.title = [NSString stringWithFormat:@"联系电话:%@",project.team_phone];
    self.cell_struct_phone.detailtitle = project.team_phone;
    
    
    [self.btn_comment setTitle:JOIN_STR(@" ", @" ",project.views) forState:UIControlStateNormal];
    [self.btn_zan setTitle:JOIN_STR(@" ", @" ",project.topNum) forState:UIControlStateNormal];
    
    
}



-(NSDictionary *)projectDic
{
    NSMutableDictionary * dataDictionary = [NSMutableDictionary dictionaryWithCapacity:6];
    [dataDictionary setObject:self.cell_struct_header forKey:KEY_INDEXPATH(0, 0)];
    [dataDictionary setObject:self.cell_struct_projecttype forKey:KEY_INDEXPATH(1, 0)];
    [dataDictionary setObject:self.cell_struct_school forKey:KEY_INDEXPATH(1, 1)];
    [dataDictionary setObject:self.cell_struct_money forKey:KEY_INDEXPATH(1, 2)];
    [dataDictionary setObject:self.cell_struct_teamname forKey:KEY_INDEXPATH(2, 0)];
    [dataDictionary setObject:self.cell_struct_teamleader forKey:KEY_INDEXPATH(2, 1)];
    [dataDictionary setObject:self.cell_struct_teamids forKey:KEY_INDEXPATH(2, 2)];
    [dataDictionary setObject:self.cell_struct_teamdesc forKey:KEY_INDEXPATH(2, 3)];
    [dataDictionary setObject:self.cell_struct_projectdesc forKey:KEY_INDEXPATH(3, 0)];
    [dataDictionary setObject:self.cell_struct_phone forKey:KEY_INDEXPATH(4, 0)];
    return dataDictionary;
}

-(void)setButtonLayer:(UIButton *)button
{
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth= 0.6;
    button.showsTouchWhenHighlighted = YES;
}

-(void)addToolBar
{
    [self navigationtoolsbar];
    [self.navigationtoolsbar drawtoplinelayer];
    //    [self showhbnavigationbarBackItem:YES];
    NSArray * frames = @[[NSValue valueWithCGRect:CGRectMake(10 , 10, 60, 22)],
                         [NSValue valueWithCGRect:CGRectMake(140, 10, 40, 22)],[NSValue valueWithCGRect:CGRectMake(self.navigationtoolsbar.width - 60, 10, 44, 22)]];
    
    NSArray * titles = @[@"下载附件",@"33",@"33"];
    NSArray * images = @[@"file_icon",@"programma_up_icon",@"item_comment"];
    NSArray * selectors = @[@"downloadfj:",@"gotodianzan:",@"gotocomment:"];
    
    NSArray * buttons = [self addToolBarWithFrames:frames titles:titles images:images selectors:selectors];
    
    self.btn_xiazai = buttons[0];
    self.btn_comment = buttons[2];
    self.btn_zan = buttons[1];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.statusBarStyleDefault = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件 处理 

-(IBAction)gotodianzan:(id)sender
{
  if (self.projectinfo)
    [self presentMessageTips_:@"+1"];
}

-(IBAction)gotocomment:(id)sender
{
    if (!self.projectinfo) return;
    B2_NewsCommentViewController * ctr =[[B2_NewsCommentViewController alloc] init];
    ctr.m_cid = self.m_projectid;
    ctr.m_type = fetch_messge_type_project;
    [self.navigationController pushViewController:ctr animated:YES];
//    [self presentMessageTips_:@"去到评论界面"];
}

-(IBAction)downloadfj:(id)sender
{
    if (self.projectinfo.annexCode) {
         [self presentMessageTips_:self.projectinfo.annexCode];
    }
    else
     [self presentMessageTips_:@"该项目没有附件"];
}

-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT *cellstruct = (CELL_STRUCT *)sender;
    
    if (cellstruct.object) {
        NSString * Classname = cellstruct.object;
        Classname = Classname?Classname:@"BaseViewController";
        Class cls = NSClassFromString(Classname);
        BaseViewController * ctr = nil;
        if(cellstruct.subvalue2 && [cellstruct.subvalue2 isEqualToString:@"xib"])
        {
            ctr = [[cls alloc] initWithNibName:Classname bundle:nil];
        }
        else
        {
            ctr = [[cls alloc] init];
        }
        [[RootViewController sharedInstance].navigationController pushViewController:ctr animated:YES];
    }
    if (cellstruct == self.cell_struct_phone) {
        if ([self.cell_struct_phone.detailtitle isTelephone]) {
            //TODO: 打电话
            PXAlertView * alert = [PXAlertView showAlertWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打%@",self.cell_struct_phone.detailtitle] cancelTitle:@"取消" otherTitle:@"确定" buttonsShouldStack:NO completion:^(BOOL cancelled, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    // 直接拨号，拨号完成后会停留在通话记录中
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",cellstruct.detailtitle]];
                    [[UIApplication sharedApplication] openURL:url];
                }
            } ];
            [alert useDefaultIOS7Style];
        }
    }
}

#pragma mark 通知相关

//-(void)handelSignal_BaseViewController_basetableview_tap:(NSNotification *)notify
//{
//    self.editing = NO;
//    [self.tableView reloadData];
//}
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:notify_basetableview_tap object:nil];
//}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithCapacity:0];
        _dataDictionary = array0;
    }
    return _dataDictionary;
}
-(CELL_STRUCT *)cell_struct_header
{
    if (!_cell_struct_header) {
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"C1_ProjectHeaderCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.object= nil;
        cell0_0.cellheight = 280;
        cell0_0.accessory = NO;
        cell0_0.sectionheight = 0;
        cell0_0.titlecolor = @"black";
        cell0_0.subvalue1 = @"xib";
        cell0_0.selectionStyle = NO;
        cell0_0.dictionary = [NSMutableDictionary dictionaryWithDictionary:@{key_cellstruct_background:[UIColor whiteColor]}];
        _cell_struct_header = cell0_0;
    }
    return _cell_struct_header;
}

-(CELL_STRUCT *)create_project_cellstruct:(NSString *)title
{
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:title cellclass:@"C1_ProjectInfoCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell1_0.selectionStyle = NO;
    cell1_0.cellheight = 55;
    cell1_0.sectionheight = 30;
    cell1_0.accessory = NO;
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
    return cell1_0;
}


@end
