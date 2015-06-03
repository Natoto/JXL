//
//  D2_EditInfoViewController.m
//  JXL
//
//  Created by 跑酷 on 15/5/8.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D2_EditInfoViewController.h"
#import "HBSignalBus.h"
#import "D1_InputTableViewCell.h"
#import "JXLCommon.h"
#import "CollegeDataModel.h"
#import "NSString+HBExtension.h"
#import "ProjectTypeListModel.h"

@interface D2_EditInfoViewController ()<D1_InputTableViewCellDelegate>

@end

@implementation D2_EditInfoViewController

-(IBAction)backtoparent:(id)sender
{
   [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self TableViewDefaultConfigWithTitle:@"编辑"];
    self.nodeselectRow = YES;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
     TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D1_InputTableViewCell")
    
    [self.navigationbar setrightBarButtonItemWithTitle:@"确定" target:self selector:@selector(confirm:)];
    if (self.edit_type == edit_type_nickname) {
        TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D1_InputTableViewCell")
        self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self nicknameDic]];
    }
    if (self.edit_type == edit_type_sex) {
        self.dataDictionary =  [NSMutableDictionary dictionaryWithDictionary:[self sexDic]];
    }
    if (self.edit_type == edit_type_age) {
        self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self ageDictionary]];
    }
    if (self.edit_type == edit_type_location) {//有待修改
        TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D1_InputTableViewCell")
       self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self locationDic]];
    }
    if (self.edit_type == edit_type_teacher) {
        TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D1_InputTableViewCell")
        self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self teacherDic]];
    }
    if (self.edit_type == edit_type_idcount) {
        TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D1_InputTableViewCell")
        self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self idcountDic]];
    }
    if (self.edit_type <= edit_type_teamdesc && self.edit_type >= edit_type_projectname) {
         self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:[self inputDic:nil]];
        
    }
    if (self.edit_type == edit_type_projecttype) {
        [self getprojecttypedic:^(NSMutableDictionary * block)  {
            self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:block];
            [self.tableView reloadData];
        }];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    D1_InputTableViewCell * inputcell = (D1_InputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([[inputcell class] isSubclassOfClass:[D1_InputTableViewCell class]]) {
        [inputcell.txt_input becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectAction:(id)sender
{
    
    
}

-(void)confirmnext
{
    
    if (self.edit_type == edit_type_nickname || self.edit_type == edit_type_teacher  || self.edit_type == edit_type_idcount) {
        CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
        NSString * string = [NSString stringWithFormat:@"%d:%@",self.edit_type,cellstruct.value];
        string = string.trim;
        SEND_HBSIGNAL(NSStringFromClass([D2_EditInfoViewController class]), key_d2editInfoviewcontroller_notify_confirm, string)
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(self.edit_type == edit_type_sex || self.edit_type == edit_type_age)
    {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        if (!indexPath) {
            return;
        }
        CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
        NSString * string = [NSString stringWithFormat:@"%d:%@",self.edit_type,cellstruct.title];
        string = string.trim;
        SEND_HBSIGNAL(NSStringFromClass([D2_EditInfoViewController class]), key_d2editInfoviewcontroller_notify_confirm, string)
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.edit_type <= edit_type_teamdesc && self.edit_type >= edit_type_projectname)
    {
        CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
        NSString * string = [NSString stringWithFormat:@"%d:%@",self.edit_type,cellstruct.value];
        string = string.trim;
        SEND_HBSIGNAL(NSStringFromClass([D2_EditInfoViewController class]), key_d2editInfoviewcontroller_notify_confirm, string)
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.edit_type == edit_type_projecttype)
    {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        if (!indexPath) {
            return;
        }
        ProjectTypeList * selecttype = [[ProjectTypeListModel sharedInstance].projectTypeList objectAtIndex:indexPath.row];
        CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
        NSString * string = [NSString stringWithFormat:@"%d:%@:%@",self.edit_type,cellstruct.title,selecttype.m_id];
        string = string.trim;
        SEND_HBSIGNAL(NSStringFromClass([D2_EditInfoViewController class]), key_d2editInfoviewcontroller_notify_confirm, string)
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(IBAction)confirm:(id)sender
{
    
    D1_InputTableViewCell * inputcell = (D1_InputTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([[inputcell class] isSubclassOfClass:[D1_InputTableViewCell class]]) {
        [inputcell.txt_input resignFirstResponder];
        [self performSelector:@selector(confirmnext) withObject:nil afterDelay:0.5];
    }
    else
    {
        [self confirmnext];
    }
   
}

#pragma mark nickname

-(void)D1_InputTableViewCell:(D1_InputTableViewCell *)D1_InputTableViewCell textFieldChange:(NSString *)text
{
    NSString * key = KEY_INDEXPATH(D1_InputTableViewCell.indexPath.section, D1_InputTableViewCell.indexPath.row);
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:key];
    cellstruct.value = text;
    NSLog(@"textField: %@",text);
    [self.dataDictionary setObject:cellstruct forKey:key];
}




-(NSDictionary *)sexDic
{
    
    CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"男" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    //    cell0_1.picture = @"user_icon";
    cell0_0.object = @"";
    cell0_0.selectionStyle = YES;
    cell0_0.cellheight = 40;
    cell0_0.accessory = NO;
    cell0_0.titlecolor = @"black";
    cell0_0.key_indexpath = KEY_INDEXPATH(0, 0);
    cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
    
    CELL_STRUCT * cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"女" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell0_1.object = @"";
    cell0_1.selectionStyle = YES;
    cell0_1.cellheight = 40;
    cell0_1.accessory = NO;
    cell0_1.titlecolor = @"black";
    cell0_1.key_indexpath = KEY_INDEXPATH(0, 0);
    cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];

    return @{KEY_INDEXPATH(0, 0):cell0_0,KEY_INDEXPATH(0, 1):cell0_1};
    
}

-(void)getprojecttypedic:( void(^)(NSMutableDictionary *))dictionblock
{
    NSMutableDictionary * projectdictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [[ProjectTypeListModel sharedInstance] projectTypeList:^(NSDictionary *Dictionary) {
        if (Dictionary) {
            NSArray * array = [ProjectTypeListModel sharedInstance].projectTypeList;
            [array enumerateObjectsUsingBlock:^(ProjectTypeList *obj, NSUInteger idx, BOOL *stop) {
                CELL_STRUCT * cell_strct =[self get_basecell_struct:obj.m_name PLACEHOLDER:nil];
                [projectdictionary setObject:cell_strct forKey:KEY_INDEXPATH(0, idx)];
            }];
            dictionblock(projectdictionary);
        }
    } errorHandler:^(NSError *error) {
        
    }];
}
-(NSDictionary *)nicknameDic
{
    CELL_STRUCT * cell0_1 = [self get_inputcell_struct:self.value PLACEHOLDER:@"请输入昵称"];
    return @{KEY_INDEXPATH(0, 0):cell0_1};
}

-(NSDictionary *)locationDic
{
    CELL_STRUCT * cell0_1 = [self get_inputcell_struct:self.value PLACEHOLDER:@"请选择地区"];
    return @{KEY_INDEXPATH(0, 0):cell0_1};
}


-(NSDictionary *)teacherDic
{
    CELL_STRUCT * cell0_1 = [self get_inputcell_struct:self.value PLACEHOLDER:@"请输入指导老师"];
    return @{KEY_INDEXPATH(0, 0):cell0_1};
    
}

-(NSDictionary *)idcountDic
{
    CELL_STRUCT * cell0_1 = [self get_inputcell_struct:self.value PLACEHOLDER:@"请输入身份证号"];
    return @{KEY_INDEXPATH(0, 0):cell0_1};
}


-(NSDictionary *)inputDic:(NSString *)placeholder
{
    CELL_STRUCT * cell0_1 = [self get_inputcell_struct:self.value PLACEHOLDER:placeholder];
    return @{KEY_INDEXPATH(0, 0):cell0_1};
}


-(NSDictionary *)ageDictionary
{
    NSMutableDictionary * agedic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (int index = 0 ; index <=95; index ++) {
        CELL_STRUCT * cell0 = [JXL_Common cell_x_x_struct:[NSString stringWithFormat:@"%d",index+5] detailvalue:nil footerheight:0 selectionStyle:YES accessory:NO target:self selectAction:@selector(selectAction:)];
        [agedic setObject:cell0 forKey:KEY_INDEXPATH(0, index)];
    }
    return agedic;
}

-(CELL_STRUCT *)get_basecell_struct:(NSString *)VALUE PLACEHOLDER:(NSString *)PLACEHOLDER
{
    CELL_STRUCT * cell0_1 = [[CELL_STRUCT alloc] initWithtitle:VALUE cellclass:@"BaseTableViewCell" placeholder:PLACEHOLDER accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell0_1.object = @"";
    cell0_1.selectionStyle = YES;
    cell0_1.cellheight = 40;
    cell0_1.accessory = NO;
    cell0_1.titlecolor = @"black";
    cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
    return cell0_1;
}
-(CELL_STRUCT *)get_inputcell_struct:(NSString *)VALUE PLACEHOLDER:(NSString *)PLACEHOLDER
{
    CELL_STRUCT * cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"D1_InputTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];\
    cell0_1.object = @"";\
    cell0_1.selectionStyle = NO;\
    cell0_1.cellheight = 50;\
    cell0_1.value = VALUE;\
    cell0_1.sectionheight = 25;\
    cell0_1.accessory = NO;\
    cell0_1.titlecolor = @"black";\
    cell0_1.subvalue1 = @"xib";\
    cell0_1.key_indexpath = KEY_INDEXPATH(0, 0);\
    PLACEHOLDER = PLACEHOLDER?PLACEHOLDER:@"";
    cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor],key_cellstruct_placehoder:PLACEHOLDER,key_cellstruct_subvalue1:@"",key_cellstruct_subvalue2:JXL_COLOR_THEME_NAVIGATIONBAR}];
    return cell0_1;
}

@end
