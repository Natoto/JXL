//
//  D3_CompletePersonInfoController.m
//  JXL
//
//  Created by BooB on 15-5-2.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D3_CompletePersonInfoController.h"
#import "JXLCommon.h"
#import "UIActionSheet+MKBlockAdditions.h"
#import "HTTPSEngine.h"
#import "jxl.h"
#import "perfectMemberModel.h"

@interface D3_CompletePersonInfoController()
@property(nonatomic,strong) NSArray * m_suppertArray;
@end
@implementation D3_CompletePersonInfoController
@synthesize dataDictionary = _dataDictionary;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //    self.noHeaderFreshView = NO;
    //    self.noFooterView = NO;
    self.tableView.tableFooterView =  [JXL_Common BigButtonview:CGRectMake(0, 0, SCREEN_WIDTH, 70) btnframe:CGRectMake(10, 20, SCREEN_WIDTH - 20, 40)  title:@"完成注册" target:self sel:@selector(nextstep:)];
    [self.navigationbar setTitle:@"完善档案"];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self showhbnavigationbarBackItem:YES];
    //    [self userDefaultBackground];
    self.view.backgroundColor = JXL_COLOR_THEME;
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
//    [self initobserver];
    
    [[HTTPSEngine sharedInstance] fetch_supportTypeList:^(NSDictionary *Dictionary) {
        if ([Dictionary isErrorObject]) {
            
        }
        else
        {
            self.m_suppertArray = [SupportTypeModel encodeDiction:Dictionary];
        }
        
    } errorHandler:^(NSError *error) {
        
    }];
}

#pragma mark 完成注册
-(void)nextstep:(id)sender
{
    Req_PerfectMember * req_pre = [Req_PerfectMember sharedInstance];
    
    if ([req_pre.m_type is:REQ_MEMBERTYPE_VC]) {
        req_pre.m_support = [self get_zizhutype];
        req_pre.m_interest = [self get_guanzhuarea];
        req_pre.m_age = [self get_age];
        req_pre.m_sex = [self get_sex];
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
                                                         if (!errorstr) {
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

-(NSArray *)zizhunames
{
    NSMutableArray * names = [NSMutableArray arrayWithCapacity:0];
    [self.m_suppertArray enumerateObjectsUsingBlock:^(SupportType *obj, NSUInteger idx, BOOL *stop) {
        [names addObject:obj.m_name];
    }];
    return names;
}
-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    NSArray * options;
    NSString * title;
    if ([self iszizhuleixing:cellstruct]) {
        
        options = [self zizhunames];
        //@[KEY_ZIZHUTYPE_CHULI,KEY_ZIZHUTYPE_CHUQIAN,KEY_ZIZHUTYPE_CHULIANDQIAN];
        title = @"请选择资助类型";
 
    }
    
    if ([self isguanzhulingyu:cellstruct]) {
        options = @[@"类型2",@"类型6"];
        title = @"选择关注领域";
    }
    
    if ([self isxingbie:cellstruct]) {
        options = @[KEY_SEX_MAN,KEY_SEX_WOMAN,KEY_SEX_UNKNOW];
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

-(void)reloadTableViewCell:(CELL_STRUCT *)cellstruct
{
    [self.dataDictionary setObject:cellstruct forKey:cellstruct.key_indexpath];
    
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row.integerValue inSection:section.integerValue]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
#pragma mark - getter setter 

-(NSString *)get_zizhutype
{
    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
    return cellstruct.detailtitle;
}

-(NSString *)get_guanzhuarea
{
    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 1)];
    return [self zizhutypeofname:cellstruct.detailtitle];
    
}

-(NSString *)zizhutypeofname:(NSString *)name
{
    __block NSString * m_type = nil;
    [self.m_suppertArray enumerateObjectsUsingBlock:^(SupportType *obj, NSUInteger idx, BOOL *stop) {
       
        if ([obj.m_name isEqualToString:name]) {
            m_type = obj.m__id;
            *stop = YES;
        }
    }];
    return m_type;
}

-(NSString *)get_sex
{
    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(1, 0)];
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
    CELL_STRUCT *cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(1, 1)];
    return cellstruct.detailtitle;
}



-(BOOL)iszizhuleixing:(CELL_STRUCT *)cellstruct
{
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    return (row.integerValue == 0 && section.integerValue == 0);
}

-(BOOL)isguanzhulingyu:(CELL_STRUCT *)cellstruct
{
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    return (row.integerValue == 1 && section.integerValue == 0);
}

-(BOOL)isxingbie:(CELL_STRUCT *)cellstruct
{
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    return (row.integerValue == 0 && section.integerValue == 1);
}
-(BOOL)isnianlin:(CELL_STRUCT *)cellstruct
{
    NSString *row = KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath);
    NSString *section = KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath);
    return (row.integerValue == 1 && section.integerValue == 1);
}


-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        
        //        Req_PerfectMember * req = [Req_PerfectMember sharedInstance];
        
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"资助类型" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        
        cell0_0.cellheight = 70;
        cell0_0.sectiontitle = @"投资人档案(必填)";
        cell0_0.sectionheight = 50;
        cell0_0.titlecolor = @"gray";
        cell0_0.detailtitle = @"";
        cell0_0.selectionStyle = YES;
        cell0_0.key_indexpath = KEY_INDEXPATH(0, 0);
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        CELL_STRUCT * cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"关注领域" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        
        cell0_1.object = @"";
        cell0_1.selectionStyle = YES;
        cell0_1.cellheight = 70;
        cell0_1.titlecolor = @"gray";
        cell0_1.key_indexpath = KEY_INDEXPATH(0, 1);
        cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:@"性别" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        
        cell1_0.sectionheight = 70;
        cell1_0.object = @"";
        cell1_0.sectiontitle = @"个人档案(必填)";
        cell1_0.selectionStyle = YES;
        cell1_0.cellheight = 70;
        cell1_0.sectionheight = 50;
        cell1_0.titlecolor = @"gray";
        cell1_0.key_indexpath = KEY_INDEXPATH(1, 0);
        cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        CELL_STRUCT * cell1_1 = [[CELL_STRUCT alloc] initWithtitle:@"年龄" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        
        cell1_1.object = @"";
        cell1_1.selectionStyle = YES;
        cell1_1.cellheight = 70;
        cell1_1.titlecolor = @"gray";
        cell1_1.key_indexpath = KEY_INDEXPATH(1, 1);
        cell1_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        NSMutableDictionary * array0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell0_1,KEY_INDEXPATH(0, 1),cell1_0,KEY_INDEXPATH(1, 0),cell1_1,KEY_INDEXPATH(1, 1),nil];
        _dataDictionary = array0;
        
    }
    
    return _dataDictionary;
}

@end
