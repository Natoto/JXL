//
//  D1_RegisterView1Controller.m
//  JXL
//
//  Created by BooB on 15-4-22.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_RegisterView1Controller.h"
#import "D1_InputTableViewCell.h"
#import "HBNavigationbar.h"
#import "D2_RegisterView2Controller.h"
#import "HBSignalBus.h"
#import "HTTPSEngine.h"
#import "NSString+HBExtension.h"
#import "jxl.h"
#import "JXLCommon.h" 

@interface D1_RegisterView1Controller ()<D1_InputTableViewCellDelegate>
@end

@implementation D1_RegisterView1Controller

@synthesize dataDictionary = _dataDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(handelSignal_BaseViewController_basetableview_tap:) name:notify_basetableview_tap object:nil];
     
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self showhbnavigationbarBackItem:YES];    
    [self userDefaultBackground];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    [self observeTapgesture];
    [self.navigationbar setTitle:@"手机快速注册"];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = JXL_COLOR_THEME;
    
    self.tableView.scrollEnabled = NO;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notify_basetableview_tap object:nil];
}

-(void)handelSignal_BaseViewController_basetableview_tap:(NSNotification *)notify
{
    self.editing = NO;
    [self.tableView reloadData];
}
-(void)back
{
    
}

-(void)setEditing:(BOOL)editing
{
    
}

//立即注册
-(void)gotoregist:(id)sender
{
    
    if (CONFIG_NONEED_MSG) {
        [self presentMessageTips_:@"注册成功,跳转完善个人信息" dismisblock:^{
            D2_RegisterView2Controller * ctr = [[D2_RegisterView2Controller alloc] init];
            [self.navigationController pushViewController:ctr animated:YES];
        }];
        return;
    }
    
    if (![self havephonemobile]) {
        [self presentMessageTips_:@"请输入手机号!"];
        return;
    }
    if (![self phonemobilevalite]) {
        [self presentMessageTips_:@"请输入手机号不正确"];
        return;
    }
    
    if (![self havecheckcode]) {
        [self presentMessageTips_:@"请输入验证码"];
        return;
    }
    
    if ([self checkcodevalite]) {
        
        //TODO: 立即注册
        [[HTTPSEngine sharedInstance] fetch_regMember:[self phonemobile] response:^(NSDictionary *Dictionary) {
           
            if ([[Dictionary class] isSubclassOfClass:[NSDictionary class]]) {
                NSString * errormsg = [Dictionary objectForKey:@"errorMsg"];
                if (errormsg && errormsg.length) {
                    [self presentMessageTips_:[Dictionary objectForKey:@"errorMsg"]];
                    return ;
                }
            }
            [self presentMessageTips_:@"注册成功,跳转完善个人信息" dismisblock:^{
                NSLog(@"mid : %@",Dictionary);
                [GlobalData sharedInstance].m_mid =  [NSString stringWithFormat:@"%@",Dictionary];
                D2_RegisterView2Controller * ctr = [[D2_RegisterView2Controller alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
            }];
            
        } errorHandler:^(NSError *error) {
            
        }];

    }
    else
    {
        [self presentMessageTips_:@"验证码不正确"];
    }

}

-(void)fireyanzhengma:(BOOL)enable
{
    NSString * key2 = KEY_INDEXPATH(0, 1);
    CELL_STRUCT * cellstruct2 = [self.dataDictionary objectForKey:key2];
    [cellstruct2.dictionary setObject:[NSNumber numberWithBool:enable] forKey:key_cellstruct_active];
    [self.dataDictionary setObject:cellstruct2 forKey:key2];
}
#pragma mark d1 inputview delegate
-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldChange:(NSString *)text
{
    NSString * key = KEY_INDEXPATH(D1_InputTableViewCell.indexPath.section, D1_InputTableViewCell.indexPath.row);
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:key];
    cellstruct.value = text;
    NSLog(@"%@",text);
    [self.dataDictionary setObject:cellstruct forKey:key];
}

-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell sendCheckcode:(id)sender
{
    NSString * key = KEY_INDEXPATH(D1_InputTableViewCell.indexPath.section, 0);
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:key];
    NSString * phone = cellstruct.value;
    phone = [phone trim];
    if ([phone isTelephone]) {
        //开始倒计时
        [self fireyanzhengma:YES];
        [self.tableView reloadData];
        
        NSString * key2 = KEY_INDEXPATH(0, 1);
        CELL_STRUCT * cellstruct2 = [self.dataDictionary objectForKey:key2];
        
        [[HTTPSEngine sharedInstance] fetch_sendMessageWithPhone:phone response:^(NSDictionary *Dictionary) {
            NSLog(@"%@",Dictionary);
            [self fireyanzhengma:NO];
            if (Dictionary) {
                NSString * codetempvalue = [NSString stringWithFormat:@"%@",Dictionary];
                cellstruct2.tempvalue = codetempvalue;
                [self.dataDictionary setObject:cellstruct2 forKey:key2];
            }
        } errorHandler:^(NSError *error) {
            
        }];
    }
    else
    {
        [self presentMessageTips:@"请输入正确的手机号"];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [JXL_Common BigButtonview:CGRectMake(0, 0, SCREEN_WIDTH, 70) btnframe:CGRectMake(10, 20, SCREEN_WIDTH - 20, 40)  title:@"立即注册" target:self sel:@selector(gotoregist:)];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}
-(void)selectAction:(id)object
{
    
}

#pragma mark - 常用判断

-(NSString *)phonemobile
{
     CELL_STRUCT * cellstruct0 = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
    return cellstruct0.value;
}

-(BOOL)havephonemobile
{
    CELL_STRUCT * cellstruct0 = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
    return cellstruct0.value.length;
}

-(BOOL)phonemobilevalite
{
    CELL_STRUCT * cellstruct0 = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
    if (cellstruct0.value.length && [cellstruct0.value isTelephone]) {
        return YES;
    }
    return NO;
}

-(BOOL)havecheckcode
{
    NSString * key = KEY_INDEXPATH(0, 1);
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:key];
    return cellstruct.value.length;
}

-(BOOL)checkcodevalite
{
    NSString * key = KEY_INDEXPATH(0, 1);
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:key];
    if (cellstruct.tempvalue && cellstruct.value && [cellstruct.value isEqualToString:cellstruct.tempvalue]) {
        return YES;
    }
    return NO;
}


-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"徐军" cellclass:@"D1_InputTableViewCell" placeholder:@"" accessory:YES sel_selctor:nil delegate:self];
        cell0_0.object= @"B0_NewsViewController";
        cell0_0.cellheight = 60;
        cell0_0.accessory = NO;
        cell0_0.sectionheight = 20;
        cell0_0.titlecolor = @"black";
        cell0_0.subvalue1 = @"xib";
        cell0_0.selectionStyle = NO;
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_placehoder:@"请输入11位有效手机号",key_cellstruct_subvalue1:@"",key_cellstruct_editing:[NSNumber numberWithBool:self.editing],key_cellstruct_txtkeyboardtype:value_cellstruct_txtkeyboardtype_number}];
        
        CELL_STRUCT * cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"我的主页" cellclass:@"D1_InputTableViewCell" placeholder:@"" accessory:NO sel_selctor:nil delegate:self];
        cell0_1.object = @"C0_ProjectViewController";
        cell0_1.selectionStyle = NO;
        cell0_1.cellheight = 60;
        cell0_1.sectionheight = 25;
        cell0_1.accessory = NO;
        cell0_1.titlecolor = @"black";
        cell0_1.subvalue1 = @"xib";
        cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_placehoder:@"请输入4位验证码",key_cellstruct_subvalue1:@"获取验证码",key_cellstruct_subvalue2:JXL_COLOR_THEME_NAVIGATIONBAR,key_cellstruct_editing:[NSNumber numberWithBool:self.editing],key_cellstruct_txtkeyboardtype:value_cellstruct_txtkeyboardtype_number}];
         
        NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell0_1,KEY_INDEXPATH(0, 1),nil];
        _dataDictionary = array0;
        
    }
    
    return _dataDictionary;
}

@end
