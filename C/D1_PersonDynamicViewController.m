//
//  D1_PersonDynamicViewController.m
//  JXL
//
//  Created by 跑酷 on 15/5/16.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_PersonDynamicViewController.h"
#import "D1_PersonalPageHeadCell.h"
#import "D1_PersonalPageCell.h"
#import "jxl.h"
#import "MemberCommnetsModel.h"
#import "B1_ANewsViewController.h"

@interface D1_PersonDynamicViewController ()
AS_CELL_STRUCT_JXLCOMMON(header)
@end

@implementation D1_PersonDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self userDefaultConfigWithTitle:@"个人主页"];
//    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"D1_PersonalPageHeadCell")
    // Do any additional setup after loading the view.
    
    if (!self.m_mid) {
        self.m_mid = [GlobalData sharedInstance].m_mid;
    }
     MemberList * amember  = [[CacheCenter sharedInstance] readObject:[NSString stringWithFormat:@"memberList%@",self.m_mid]];
    [self headDataChange:amember];
    self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary: @{KEY_INDEXPATH(0, 0):self.cell_struct_header}];
    
    NSArray * CommnetList = [[CacheCenter sharedInstance] readObject:[NSString stringWithFormat:@"CommnetList%@",self.m_mid]];
    [self commentsDataChange:CommnetList];
    
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshView
{
    [[HTTPSEngine sharedInstance] fetch_memberList:self.m_mid response:^(NSString *Dictionary) {
        NSLog(@"%@",Dictionary);
        MemberList * amember = [MemberListModel encodeDiction:Dictionary];
        [self headDataChange:amember];
        [self.tableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
    
    [[HTTPSEngine sharedInstance] fetch_memberCommnets:self.m_mid response:^(NSString *responsejson) {
       //TODO:评论消息接口数据有问题
        NSArray * CommnetList = [MemberCommnetsModel encodeDiction:responsejson];
        [self commentsDataChange:CommnetList];
        NSLog(@"%@",responsejson);
        [self.tableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
}

-(void)headDataChange:(MemberList *)amember
{
    if (amember) {
        [[CacheCenter sharedInstance] saveObject:amember forkey:[NSString stringWithFormat:@"memberList%@",self.m_mid]];
        self.cell_struct_header.title = amember.nickname;
        self.cell_struct_header.picture = amember.headpic;
        self.cell_struct_header.object = amember;
    }
}
-(void)commentsDataChange:(NSArray *)CommnetList
{
    if (CommnetList.count) {
        [[CacheCenter sharedInstance] saveObject:CommnetList forkey:[NSString stringWithFormat:@"CommnetList%@",self.m_mid]];
        [CommnetList enumerateObjectsUsingBlock:^(AMemberCommnet * obj, NSUInteger idx, BOOL *stop) {
            CELL_STRUCT * cell_struct = [self create_commentcell_struct];
            cell_struct.object = obj;
            cell_struct.key_indexpath = KEY_INDEXPATH(1, idx);
            [self.dataDictionary setObject:cell_struct forKey:KEY_INDEXPATH(1, idx)];
        }];
    }
}

-(CELL_STRUCT *)cell_struct_header
{
    
    if (!_cell_struct_header) {
        _cell_struct_header = [[CELL_STRUCT alloc] initWithtitle:@"张三" cellclass:@"D1_PersonalPageHeadCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
//        _cell_struct_header.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor grayColor]}];
        _cell_struct_header.selectionStyle = NO;
        _cell_struct_header.cellheight = [D1_PersonalPageHeadCell heightOfCell];
    }
    return _cell_struct_header;
}

-(CELL_STRUCT *)create_commentcell_struct
{
   CELL_STRUCT * cell_struct = [[CELL_STRUCT alloc] initWithtitle:@"张三" cellclass:@"D1_PersonalPageCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
    cell_struct.sectionheight = 40;
    cell_struct.sectiontitle = @"动态";
    cell_struct.cellheight = 100;
    cell_struct.selectionStyle = NO;
    return cell_struct;
}
-(IBAction)selectAction:(id)sender
{
    CELL_STRUCT * cell_struct = (CELL_STRUCT *)sender;
    if (KEY_INDEXPATH_SECTION_STR(cell_struct.key_indexpath).integerValue == 1) {
//        AMemberCommnet * obj = cell_struct.object;
//        B1_ANewsViewController * ctr = [[B1_ANewsViewController  alloc] initWithNewsId:obj.id mid:self.m_mid];
//        [self.navigationController pushViewController:ctr animated:YES];
    }
}
@end
