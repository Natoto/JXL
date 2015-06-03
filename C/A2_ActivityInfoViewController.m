//
//  A2_ActivityInfoViewController.m
//  JXL
//
//  Created by 跑酷 on 15/5/21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "jxl.h"
#import "A2_ActivityInfoViewController.h"
#import "SoloLabelCell.h"
#import "A2_ActivityHeaderCell.h"
#import "UIImage+Tint.h"
#import "HTTPSEngine.h"
@interface A2_ActivityInfoViewController ()
AS_CELL_STRUCT_JXLCOMMON(header)
AS_CELL_STRUCT_JXLCOMMON(info)

@property(nonatomic,retain) UIButton * btn_attent;
@end

@implementation A2_ActivityInfoViewController
GET_CELL_STRUCT_(header, 头部)
GET_CELL_STRUCT_(info, 内容)

-(void)modifycellstructs
{
    self.cell_struct_header.cellheight = 180;
    self.cell_struct_header.cellclass = @"A2_ActivityHeaderCell";
    self.cell_struct_header.subvalue1 = @"xib";
    self.cell_struct_header.accessory = NO;
    self.cell_struct_header.selectionStyle = NO;
    self.cell_struct_header.dictionary = [NSMutableDictionary dictionaryWithDictionary:@{key_cellstruct_background:[UIColor clearColor]}];
    
    self.cell_struct_info.cellclass = @"SoloLabelCell";
    self.cell_struct_info.sectionheight = 40;
    self.cell_struct_info.accessory = NO;
    self.cell_struct_info.selectionStyle = NO;
    self.cell_struct_info.sectiontitle = @"活动介绍";
    self.cell_struct_info.dictionary = [NSMutableDictionary dictionaryWithDictionary:@{key_cellstruct_background:[UIColor clearColor]}];
    
    
    self.cell_struct_header.object = self.m_Activity;
    self.cell_struct_info.title = self.m_Activity.content;
    self.cell_struct_info.cellheight = [SoloLabelCell heighofCell:self.m_Activity.content];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self usegrayNavigationbarConfigWithTitle:@"活动详情"];
    
    [self modifycellstructs];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"A2_ActivityHeaderCell")
    self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:@{KEY_INDEXPATH(0, 0):self.cell_struct_header,KEY_INDEXPATH(1, 0):self.cell_struct_info}];
    [self addToolBar];
    [self adjustContentOffSet:self.navigationbar.height bottom:self.navigationtoolsbar.height];
}

-(void)addToolBar
{
    [self navigationtoolsbar];
    [self.navigationtoolsbar drawtoplinelayer];
    //    [self showhbnavigationbarBackItem:YES];
    
    UIView * centerview = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 200, 44)];
    
    UIButton * writebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [writebtn setImage:[UIImage imageNamed:@"active_detail_region"] forState:UIControlStateNormal];
    [writebtn setImage:[UIImage imageNamed:@"active_detail_canel"] forState:UIControlStateSelected];
    
    [writebtn addTarget:self action:@selector(attendactivity:) forControlEvents:UIControlEventTouchUpInside];
    writebtn.frame = CGRectMake(0, 0, 150, 44);
    [writebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [writebtn setTitleColor:KT_UIColorWithRGB(122, 180, 232) forState:UIControlStateSelected ];
    [writebtn setTitle:@" 我要参加" forState:UIControlStateNormal];
    [writebtn setTitle:@" 取消报名" forState:UIControlStateSelected];
//    writebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [centerview addSubview:writebtn];
    self.btn_attent = writebtn;
    self.navigationtoolsbar.titleView = centerview;
    
    self.navigationtoolsbar.titleView.center = CGPointMake(self.navigationtoolsbar.width/2, self.navigationtoolsbar.height/2);
    self.btn_attent.center = CGPointMake(centerview.width/2, centerview.height/2);
    
    self.btn_attent.selected = self.m_Activity.is_regist.boolValue;
}

-(IBAction)attendactivity:(id)sender
{
    if (self.btn_attent.selected) {
        [[HTTPSEngine sharedInstance] fetch_cancelActivityWithid:self.m_Activity.id mid:[GlobalData sharedInstance].m_mid response:^(NSString *responsejson) {
            [self loadRegData:responsejson];
        } errorHandler:nil];
    }
    else
    {
        [[HTTPSEngine sharedInstance] fetch_registActivityWithid:self.m_Activity.id mid:[GlobalData sharedInstance].m_mid response:^(NSString *responsejson) {
            ;
            [self loadRegData:responsejson];
        } errorHandler:nil];
    }
}

-(void)loadRegData:(NSString *)responsejson
{
    if (responsejson.integerValue) {
        NSString * attentnumber = [NSString stringWithFormat:@"成功！目前有%@人报名",responsejson];
        [self presentMessageTips:attentnumber];
        self.m_Activity.sigNum = [NSNumber numberWithInteger:responsejson.integerValue];
        [self modifycellstructs];
        [self.tableView reloadData];
        self.btn_attent.selected = !self.btn_attent.selected;
    }
    else
    {
        ErrorObject * error = [APIBaseObject encodeJsonResponse:responsejson];
        [self presentMessageTips:error.errorMsg];
    }
}

GET_CELL_SELECT_ACTION(cellstruct)
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
