//
//  D3_ComplteNormalViewController.m
//  JXL
//
//  Created by BooB on 15/5/6.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D3_ComplteNormalViewController.h"

#import "JXLCommon.h"
#import "UIActionSheet+MKBlockAdditions.h"
#import "HTTPSEngine.h"
#import "jxl.h"
#import "perfectMemberModel.h"
#import "D1_InputTableViewCell.h"
#import "D4_CollegeSelectorController.h"

@interface D3_ComplteNormalViewController ()

@end

@implementation D3_ComplteNormalViewController
@synthesize dataDictionary = _dataDictionary;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //    self.noHeaderFreshView = NO;
    //    self.noFooterView = NO;
    [self.navigationbar setTitle:@"完善档案"];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self showhbnavigationbarBackItem:YES];
    //    [self userDefaultBackground];
    self.view.backgroundColor = JXL_COLOR_THEME;
    
    self.tableView.tableFooterView =  [JXL_Common BigButtonview:CGRectMake(0, 0, SCREEN_WIDTH, 70) btnframe:CGRectMake(10, 20, SCREEN_WIDTH - 20, 40)  title:@"完成注册" target:self sel:@selector(nextstep:)];
    
     [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self initobserver];
}


-(void)initobserver
{
    //    [self observeTapgesture];
    //监听键盘通知
}
#pragma mark 完成注册
-(void)nextstep:(id)sender
{
    Req_PerfectMember * req_pre = [Req_PerfectMember sharedInstance];
    
    if ([req_pre.m_type is:REQ_MEMBERTYPE_VC]) {
        
    }
    else if([req_pre.m_type is:REQ_MEMBERTYPE_PLAYER])
    {
        req_pre.m_sex = [self get_sex];
        req_pre.m_age = [self get_age];
        [self presentLoadingTips:@"提交中..."];
        [[HTTPSEngine sharedInstance] fetch_perfectMemberWith:[GlobalData sharedInstance].m_mid
                                                     password:req_pre.m_password
                                                      headpic:req_pre.m_headpic
                                                     nickname:req_pre.m_nickname
                                                        email:req_pre.m_email
                                                          age:req_pre.m_age
                                                          sex:req_pre.m_sex
                                                         type:req_pre.m_type
                                                     schoolid:req_pre.m_schoolid
                                                      teacher:req_pre.m_teacher
                                                           id:req_pre.m_id
                                                     interest:req_pre.m_interest
                                                      support:req_pre.m_support
                                                     response:^(NSDictionary *Dictionary) {
                                                         [self dismissAllTips];
                                                         NSString * errorstr = [Dictionary objectForKey:@"errorMsg"];
                                                         if ([[Dictionary class] isSubclassOfClass:[NSString class]]) {
                                                             errorstr = [NSString stringWithFormat:@"%@",Dictionary];
                                                         }
                                                         if (errorstr) {
                                                             [self presentMessageTips_:errorstr];
                                                             return ;
                                                         }
                                                         [self presentMessageTips_:@"资料已完善" dismisblock:^{
                                                             RES_PerfectMember * res = [perfectMemberModel encodeDiction:Dictionary];
                                                             [GlobalData sharedInstance].m_res_perfectmember = res;
                                                             [self.navigationController popToRootViewControllerAnimated:YES];
                                                         }];
                                                         
                                                         
                                                     } errorHandler:^(NSError *error) {
                                                         
                                                     }];
        
    }
    
}

-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    NSArray * options;
    NSString * title;
    
    
    if ([self isxingbie:cellstruct]) {
        options = @[@"男",@"女",@"保密"];
        title = @"选择性别";
    }
    if ([self isnianlin:cellstruct]) {
        options = @[@"<20",@"20~30",@"30~40",@">40"];
        NSMutableArray * ages = [NSMutableArray arrayWithCapacity:0];
        for (int age = 5; age <= 100; age ++) {
            [ages addObject:[NSString stringWithFormat:@"%d",age]];
        }
        options = ages;
        title = @"选择年龄";
    }
    
    if (!options && !options.count) {
        return;
    }
    
    [UIActionSheet actionSheetWithTitle:title message:title buttons:options showInView:self.view onDismiss:^(int buttonIndex) {
        cellstruct.detailtitle = [options objectAtIndex:buttonIndex];
        [self reloadTableViewCell:cellstruct];
    } onCancel:^{
        
    }];
}

#pragma mark - d4 school selector
-(void)D4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController selectCollegeName:(NSString *)collegeName collegeID:(NSString *)collegeID
{
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
    cellstruct.detailtitle = collegeName;
    cellstruct.value = collegeID;
    [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, 0)];
    [self.tableView reloadData];
    
}
#pragma mark D1_InputTableViewCell delegate

-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldChange:(NSString *)text
{
    NSString * key = KEY_INDEXPATH(D1_InputTableViewCell.indexPath.section, D1_InputTableViewCell.indexPath.row);
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:key];
    cellstruct.value = text;
    [self.dataDictionary setObject:cellstruct forKey:key];
}


-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldDidBeginEditing:(UITextField *)textField
{
    D1_InputTableViewCell.txt_input.inputAccessoryView = self.inputAccessoryView;
    [self.tableView selectRowAtIndexPath:D1_InputTableViewCell.indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldDidEndEditing:(UITextField *)textField
{
    
}


-(void)reloadTableViewCell:(CELL_STRUCT *)cellstruct
{
    [self.dataDictionary setObject:cellstruct forKey:cellstruct.key_indexpath];
    
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row.integerValue inSection:section.integerValue]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - getter sentter

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        
        
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"性别" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.sectionheight = 70;
        cell0_0.object = @"";
        cell0_0.sectiontitle = @"个人档案(必填)";
        cell0_0.selectionStyle = YES;
        cell0_0.cellheight = 70;
        cell0_0.sectionheight = 50;
        cell0_0.titlecolor = @"gray";
        cell0_0.key_indexpath = KEY_INDEXPATH(0, 0);
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        CELL_STRUCT * cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"年龄" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        
        cell0_1.object = @"";
        cell0_1.selectionStyle = YES;
        cell0_1.cellheight = 70;
        cell0_1.titlecolor = @"gray";
        cell0_1.key_indexpath = KEY_INDEXPATH(0, 1);
        cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        NSMutableDictionary * array0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell0_1,KEY_INDEXPATH(0, 1),nil];
        _dataDictionary = array0;
        
    }
    
    return _dataDictionary;
}
//
//-(NSString *)get_gaoxiao
//{
//    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
//    return cellstruct.value;
//}
//
//-(NSString *)get_teacher
//{
//    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 1)];
//    return cellstruct.value;
//}
//
//-(NSString *)get_identify
//{
//    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 2)];
//    return cellstruct.value;
//}

-(NSString *)get_sex
{
    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
    if ([cellstruct.detailtitle isEqualToString:KEY_SEX_MAN]) {
        return VALUE_SEX_MAN;
    }
    
    if ([cellstruct.detailtitle isEqualToString:KEY_SEX_WOMAN]) {
        return VALUE_SEX_WOMAN;
    }
    if ([cellstruct.detailtitle isEqualToString:KEY_SEX_UNKNOW]) {
        return VALUE_SEX_UNKNOW;
    }
    
    return cellstruct.detailtitle;
}

-(NSString *)get_age
{
    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 1)];
    return cellstruct.detailtitle;
}


//
//-(BOOL)isselectschool:(CELL_STRUCT *)cellstruct
//{
//    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
//    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
//    return (row.integerValue == 0 && section.integerValue == 0);
//}
//
//-(BOOL)isselectteacher:(CELL_STRUCT *)cellstruct
//{
//    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
//    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
//    return (row.integerValue == 1 && section.integerValue == 0);
//}
//
//-(BOOL)isselecttidendity:(CELL_STRUCT *)cellstruct
//{
//    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
//    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
//    return (row.integerValue == 2 && section.integerValue == 0);
//}
//

-(BOOL)isxingbie:(CELL_STRUCT *)cellstruct
{
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    return (row.integerValue == 0 && section.integerValue == 0);
}
-(BOOL)isnianlin:(CELL_STRUCT *)cellstruct
{
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    return (row.integerValue == 0 && section.integerValue == 1);
}

@end
