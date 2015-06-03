//
//  D2_RegisterView2Controller.m
//  JXL
//
//  Created by BooB on 15-4-23.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D2_RegisterView2Controller.h"
#import "D1_AboutUSHeaderCell.h"
#import "D1_InputTableViewCell.h"
#import "SwitchInputAccessoryView.h"
#import "D3_CompletePersonInfoController.h"
#import "D3_CompltePlayerInfoController.h"

#import "perfectMemberModel.h"
#import "jxl.h"


@interface D2_RegisterView2Controller ()<D1_InputTableViewCellDelegate,InputAccessoryViewDelegate>
{
    CGFloat keybordheight;
    CGRect oldtableRect;
}

@property(nonatomic,retain) SwitchInputAccessoryView * inputAccessoryView;
@end

@implementation D2_RegisterView2Controller

@synthesize dataDictionary = _dataDictionary;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.noHeaderFreshView = NO;
//    self.noFooterView = NO;
    self.tableView.tableFooterView =  [JXL_Common BigButtonview:CGRectMake(0, 0, SCREEN_WIDTH, 70) btnframe:CGRectMake(10, 20, SCREEN_WIDTH - 20, 40)  title:@"下一步" target:self sel:@selector(nextstep:)];
    [self.navigationbar setTitle:@"完善个人资料"];
    
    [self.tableView registerClass:NSClassFromString(@"D1_InputTableViewCell") forCellReuseIdentifier:@"D1_InputTableViewCell"];
    UINib * cell2nib = [UINib nibWithNibName:@"D1_InputTableViewCell" bundle:nil];
    [self.tableView registerNib:cell2nib forCellReuseIdentifier:@"D1_InputTableViewCell"];
    
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self showhbnavigationbarBackItem:YES];
//    [self userDefaultBackground];
    self.view.backgroundColor = JXL_COLOR_THEME;
    oldtableRect = [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self initobserver];
}


-(void)initobserver
{
    //注册手势通知
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(handelSignal_BaseViewController_basetableview_tap:) name:notify_basetableview_tap object:nil];
    //    [self observeTapgesture];
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordwillshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordwillhide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 事件 处理

-(void)nextstep:(id)sender
{
    Req_PerfectMember * req_per = [Req_PerfectMember sharedInstance];
    
    if (!CONFIG_NONEED_COMLETE) {
        req_per.m_name = [[self get_name] trim];
        req_per.m_nickname = req_per.m_name;
        if (!req_per.m_name.length) {
            [self presentMessageTips_:@"请输入姓名"];
            return;
        }
        req_per.m_email = [self get_email];
        if (!req_per.m_email.length || ![req_per.m_email isEmail]) {
            [self presentMessageTips_:@"请填写正确的邮箱"];
            return;
        }
        NSString * pasword = [self get_password];
        NSString * confirmpsd = [self get_confirmpasswd];
        if (!pasword) {
            [self presentMessageTips_:@"请输入密码"];
            return;
        }
        if (!confirmpsd) {
            [self presentMessageTips_:@"请输入确认密码"];
            return;
        }
        if ([pasword isNot:confirmpsd]) {
            [self presentMessageTips_:@"两次密码不匹配"];
            return;
        }
        req_per.m_password = [self get_confirmpasswd];
    } 
    req_per.m_type = [self get_membertype];
    if (!req_per.m_type.length) {
        [self presentMessageTips_:@"请选择身份"];
        return;
    }
    if ([req_per.m_type is:REQ_MEMBERTYPE_VC]) {
        D3_CompletePersonInfoController * ctr = [[D3_CompletePersonInfoController alloc] init];
        //传递头像 姓名 身份 邮箱  密码
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if([req_per.m_type is:REQ_MEMBERTYPE_PLAYER])
    {
        D3_CompltePlayerInfoController * ctr = [[D3_CompltePlayerInfoController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else
    {
        //TODO: 提交资料 完成注册 。。
        Req_PerfectMember * req_pre = [Req_PerfectMember sharedInstance];
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
                                                     interest:@""
                                                      support:@""
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

-(void)selectAction:(id)object
{
    CELL_STRUCT * cell0_0 = (CELL_STRUCT *)object;
    NSString * key_indexpath_section = KEY_SECTION_INDEX_STR(cell0_0.key_indexpath);
    NSString * key_indexpath_row = KEY_INDEXPATH_ROW_STR(cell0_0.key_indexpath);
    if (key_indexpath_row.integerValue == [self getIDentifyCellRow]) {
        
        [self.inputAccessoryView.cur_textfield resignFirstResponder];
        
        NSArray * array = @[KEY_MEMBERTYPE_NORMAL,KEY_MEMBERTYPE_PLAYER,KEY_MEMBERTYPE_VC];
        [UIActionSheet actionSheetWithTitle:nil message:@"请选择身份" buttons:array showInView:self.view onDismiss:^(int buttonIndex) {
            cell0_0.title = [array objectAtIndex:buttonIndex];
            cell0_0.titlecolor = @"black";
            [self.dataDictionary setObject:cell0_0 forKey:cell0_0.key_indexpath];
            
            if ([KEY_MEMBERTYPE_NORMAL is:cell0_0.title]) {
                self.tableView.tableFooterView = [self doneFooterView];
            }
            else
            {
                self.tableView.tableFooterView = [self nextstepFooterView];
            }
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:key_indexpath_row.integerValue inSection:key_indexpath_section.integerValue]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        } onCancel:^{
            
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark  input accesor view delegate
-(void)InputAccessoryView:(SwitchInputAccessoryView *)InputAccessoryView last:(BOOL)last next:(BOOL)next done:(BOOL)done
{
    NSIndexPath * curindexpath =  [self.tableView indexPathForSelectedRow];
    D1_InputTableViewCell * currentcell = (D1_InputTableViewCell *)[self.tableView cellForRowAtIndexPath:curindexpath];
    NSInteger current_row = curindexpath.row;
    
    if (done) {
        if ([[currentcell class] isSubclassOfClass:[D1_InputTableViewCell class]]) {
//            [currentcell.txt_input resignFirstResponder];
            [InputAccessoryView.cur_textfield resignFirstResponder];
        }
        return;
    }
    
    NSIndexPath * nextIndexPath = nil;
    if (last) {//向前
        if (!current_row) {
            return;
        }
        nextIndexPath = [NSIndexPath indexPathForRow:current_row -1 inSection:curindexpath.section];
    }
    if (next) {//向后
        if (current_row > self.dataDictionary.count -1) {
            return;
        }
        nextIndexPath = [NSIndexPath indexPathForRow:current_row + 1 inSection:curindexpath.section];
       
    }
    if(nextIndexPath.row == [self getIDentifyCellRow])
    {
        [currentcell.txt_input resignFirstResponder];
        CELL_STRUCT * idcellstruct = [self getIDentifyCellStruct];
        [self selectAction:idcellstruct];
        return;
    }
    if (nextIndexPath) {
        D1_InputTableViewCell * cell = (D1_InputTableViewCell *)[self.tableView cellForRowAtIndexPath:nextIndexPath];
        if ([[cell class] isSubclassOfClass:[D1_InputTableViewCell class]]) {
            [cell.txt_input becomeFirstResponder];
            [self relayoutTableViewWithKeyboardheight:keybordheight indexpath:nextIndexPath];
        }
        else
        {
            if ([[currentcell class] isSubclassOfClass:[D1_InputTableViewCell class]]) {
                [currentcell.txt_input resignFirstResponder];
            }
        }
    }
}
#pragma mark D1_InputTableViewCell delegate

-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldChange:(NSString *)text
{
    NSString * key = KEY_INDEXPATH(D1_InputTableViewCell.indexPath.section, D1_InputTableViewCell.indexPath.row);
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:key];
    cellstruct.value = text;
    NSLog(@"textField: %@",text);
    [self.dataDictionary setObject:cellstruct forKey:key];
}
-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell sendCheckcode:(id)sender
{
    
}


-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldDidBeginEditing:(UITextField *)textField
{
    D1_InputTableViewCell.txt_input.inputAccessoryView = self.inputAccessoryView;
    self.inputAccessoryView.cur_textfield = D1_InputTableViewCell.txt_input;
    [self.tableView selectRowAtIndexPath:D1_InputTableViewCell.indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldDidEndEditing:(UITextField *)textField
{
    
}
#pragma mark 重新排版

-(void)relayoutTableViewWithKeyboardheight:(CGFloat)height indexpath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:0.5 animations:^{
        if (!self.tableView.contentOffset.y) {
            return ;
        }
        //self.tableView.height +
        CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
        CGFloat newoffsety =  self.tableView.contentSize.height - height;
        CGFloat offset =     (rect.origin.y + rect.size.height)  - newoffsety;
     
        self.tableView.frame = CGRectMake(0, - offset, self.view.width, self.view.height);
        
    }];
}

#pragma mark - 键盘显示 收缩

-(void)keybordwillshow:(NSNotification *)notify
{
     CGSize kbSize = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
       keybordheight = kbSize.height;
    NSIndexPath * indexpath =  [self.tableView indexPathForSelectedRow];
    [self relayoutTableViewWithKeyboardheight:kbSize.height indexpath:indexpath];
//    NSLog(@"%@",kbSize);
}

-(void)keybordwillhide:(NSNotification *)nofity
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.tableView.frame = oldtableRect;
    }];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notify_basetableview_tap object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)handelSignal_BaseViewController_basetableview_tap:(NSNotification *)notify
{
    self.editing = NO;
    [self.tableView reloadData];
}

#pragma mark - tableview 额外扩展 .
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [JXL_Common BigButtonview:CGRectMake(10, 30, self.view.width - 20, 40) title:@"下一步" target:self sel:@selector(nextstep:)];
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 70;
//}


#pragma mark - geter setter


-(SwitchInputAccessoryView *)inputAccessoryView
{
    if (!_inputAccessoryView) {
        _inputAccessoryView = [SwitchInputAccessoryView defalutAccessoryView];
        _inputAccessoryView.delegate = self;
    }
    return _inputAccessoryView;
}


-(CELL_STRUCT *)getIDentifyCellStruct
{
    return [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 2)];
}

-(NSInteger)getIDentifyCellRow
{
    return 2;
}


-(NSString *)get_name
{
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 1)];
    return  cellstruct.value;
}

-(NSString *)get_membertype
{
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 2)];
    if ([cellstruct.title isEqualToString:KEY_MEMBERTYPE_PLAYER]) {
        return VALUE_MEMBERTYPE_PLAYER;
    }else if ([cellstruct.title isEqualToString:KEY_MEMBERTYPE_VC]) {
        return VALUE_MEMBERTYPE_VC;
    }
    else if ([cellstruct.title isEqualToString:KEY_MEMBERTYPE_NORMAL])
        return VALUE_MEMBER_NORMAL;
    else
        return VALUE_MEMBER_NORMAL;
}

-(NSString *)get_email
{
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 3)];
    return  cellstruct.value;
}

-(NSString *)get_password
{
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 4)];
    return  cellstruct.value;
}

-(NSString *)get_confirmpasswd
{
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 5)];
   return  cellstruct.value;
}


-(UIView *)nextstepFooterView
{
    return [JXL_Common BigButtonview:CGRectMake(0, 0, SCREEN_WIDTH, 70) btnframe:CGRectMake(10, 20, SCREEN_WIDTH - 20, 40)  title:@"下一步" target:self sel:@selector(nextstep:)];
}

-(UIView *)doneFooterView
{
    return [JXL_Common BigButtonview:CGRectMake(0, 0, SCREEN_WIDTH, 70) btnframe:CGRectMake(10, 20, SCREEN_WIDTH - 20, 40)  title:@"完成注册" target:self sel:@selector(nextstep:)];
}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"  " cellclass:@"D1_AboutUSHeaderCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.picture = @"pick_photo_icon";
        cell0_0.object= @"B0_NewsViewController";
        cell0_0.cellheight = 200;
        cell0_0.accessory = NO;
        cell0_0.detailtitle = @"  ";
        cell0_0.sectionheight = 10;
        cell0_0.titlecolor = @"black";
        cell0_0.subvalue1 = @"xib";
        cell0_0.selectionStyle = NO;
        cell0_0.key_indexpath = KEY_INDEXPATH(0, 0);
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
        
        CELL_STRUCT * cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"真实姓名" cellclass:@"D1_InputTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_1.picture = @"user_icon";
        cell0_1.object = @"";
        cell0_1.selectionStyle = NO;
        cell0_1.cellheight = 70;
        cell0_1.sectionheight = 25;
        cell0_1.accessory = NO;
        cell0_1.titlecolor = @"black";
        cell0_1.subvalue1 = @"xib";
        cell0_1.key_indexpath = KEY_INDEXPATH(0, 1);
        cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_placehoder:@"真实姓名",key_cellstruct_subvalue1:@"",key_cellstruct_profile:@"user_icon",key_cellstruct_subvalue2:JXL_COLOR_THEME_NAVIGATIONBAR}];
        
        CELL_STRUCT * cell0_2 = [[CELL_STRUCT alloc] initWithtitle:@"选择身份" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell0_2.picture = @"";
        cell0_2.object = @"";
        cell0_2.selectionStyle = YES;
        cell0_2.cellheight = 70;
        cell0_2.sectionheight = 25;
        cell0_2.titlecolor = @"gray";
        cell0_2.key_indexpath = KEY_INDEXPATH(0, 2);
        cell0_2.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        CELL_STRUCT * cell0_3 = [[CELL_STRUCT alloc] initWithtitle:@"邮箱地址" cellclass:@"D1_InputTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_3.picture = @"mail_icon";
        cell0_3.object = @"";
        cell0_3.selectionStyle = NO;
        cell0_3.cellheight = 70;
        cell0_3.sectionheight = 25;
        cell0_3.accessory = NO;
        cell0_3.titlecolor = @"black";
        cell0_3.subvalue1 = @"xib";
        cell0_3.key_indexpath = KEY_INDEXPATH(0, 3);
        cell0_3.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_placehoder:@"邮箱地址",key_cellstruct_subvalue1:@"",key_cellstruct_profile:@"mail_icon",key_cellstruct_subvalue2:JXL_COLOR_THEME_NAVIGATIONBAR}];
        
        
        CELL_STRUCT * cell0_4 = [[CELL_STRUCT alloc] initWithtitle:@"密码" cellclass:@"D1_InputTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_4.picture = @"password_icon";
        cell0_4.object = @"C0_ProjectViewController";
        cell0_4.selectionStyle = NO;
        cell0_4.cellheight = 70;
        cell0_4.sectionheight = 25;
        cell0_4.accessory = NO;
        cell0_4.titlecolor = @"black";
        cell0_4.subvalue1 = @"xib";
        cell0_4.key_indexpath = KEY_INDEXPATH(0, 4);
        cell0_4.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_placehoder:@"密码",key_cellstruct_profile:@"password_icon",key_cellstruct_txtsecureTextEntry:[NSNumber numberWithBool:YES]}];
        
        CELL_STRUCT * cell0_5 = [[CELL_STRUCT alloc] initWithtitle:@"确认密码" cellclass:@"D1_InputTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_5.picture = @"xinwen";
        cell0_5.object = @"C0_ProjectViewController";
        cell0_5.selectionStyle = NO;
        cell0_5.cellheight = 70;
        cell0_5.sectionheight = 25;
        cell0_5.accessory = NO;
        cell0_5.titlecolor = @"black";
        cell0_5.subvalue1 = @"xib";
        cell0_5.key_indexpath = KEY_INDEXPATH(0, 5);
        cell0_5.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_placehoder:@"确认密码",key_cellstruct_subvalue1:@"",key_cellstruct_profile:@"password_icon",key_cellstruct_txtsecureTextEntry:[NSNumber numberWithBool:YES]}];
        
        NSMutableDictionary * array0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell0_1,KEY_INDEXPATH(0, 1),cell0_2,KEY_INDEXPATH(0, 2),cell0_3,KEY_INDEXPATH(0, 3),cell0_4,KEY_INDEXPATH(0, 4),cell0_5,KEY_INDEXPATH(0, 5),nil];
        _dataDictionary = array0;
        
    }
    
    return _dataDictionary;
}



@end
