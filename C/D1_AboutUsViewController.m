//
//  D1_AboutUsViewController.m
//  JXL
//
//  Created by 跑酷 on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_AboutUsViewController.h"
#import "PXAlertView+Customization.h"
#import "PXAlertView.h"
@interface D1_AboutUsViewController ()

@end

@implementation D1_AboutUsViewController

@synthesize dataDictionary = _dataDictionary;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self showhbnavigationbarBackItem:YES];
    [self userDefaultBackground];
    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = JXL_COLOR_THEME;
    self.tableView.scrollEnabled = NO;
    
    [self.navigationbar setTitle:@"关于我们"];
}


-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [NSString stringWithFormat:@"V %@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
//        self.lbl_version.text = [NSString stringWithFormat:@"%@", version];
        
        CELL_STRUCT * cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"D1_AboutUSHeaderCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.cellheight = 230;
        cell0_0.selectionStyle = NO;
        cell0_0.sectionheight = 25;
        cell0_0.titlecolor = @"black";
        cell0_0.subvalue1 = @"xib";
        cell0_0.detailtitle = version;
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor],key_cellstruct_pushcontroller:@"D1_RegisterView1Controller",key_cellstruct_pushcontroller_xib:@""}];
        
        CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:@"检查更新" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell1_0.object = @"C0_ProjectViewController";
        cell1_0.selectionStyle = YES;
        cell1_0.cellheight = 40;
        cell1_0.sectionheight = 0;
        cell1_0.accessory = YES;
        cell1_0.titlecolor = @"black";
        cell1_0.key_indexpath = KEY_INDEXPATH(1, 0);
        cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        CELL_STRUCT * cell1_1 = [[CELL_STRUCT alloc] initWithtitle:@"客服电话" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell1_1.selectionStyle = YES;
        cell1_1.cellheight = 40;
        cell1_1.detailtitle = @"4008520883";
        cell1_1.titlecolor = @"black";
        cell1_1.accessory = YES;
        cell1_1.key_indexpath = KEY_INDEXPATH(1, 1);
        cell1_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        CELL_STRUCT * cell1_2 = [[CELL_STRUCT alloc] initWithtitle:@"版权信息" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell1_2.selectionStyle = YES;
        cell1_2.cellheight = 40;
        cell1_2.key_indexpath = KEY_INDEXPATH(1, 2);
        cell1_2.detailtitle = @"南昌布谷鸟科技";
        cell1_2.titlecolor = @"black";
        cell1_2.accessory = YES;
        cell1_2.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor whiteColor]}];
        
        NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell1_0,KEY_INDEXPATH(1, 0),cell1_1,KEY_INDEXPATH(1, 1),cell1_2,KEY_INDEXPATH(1, 2),nil];
        
        _dataDictionary = array0;
    }
    return _dataDictionary;
}

-(void)selectAction:(id)sender
{
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    if ([self ischecknewindex:cellstruct.key_indexpath]) {
        
    }
    else if([self istelephoneindex:cellstruct.key_indexpath])
    {
        PXAlertView * alert = [PXAlertView showAlertWithTitle:@"提示" message:@"是否拨打客服电话" cancelTitle:@"取消" otherTitle:@"确定" buttonsShouldStack:NO completion:^(BOOL cancelled, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                // 直接拨号，拨号完成后会停留在通话记录中
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",cellstruct.detailtitle]];
                [[UIApplication sharedApplication] openURL:url];
            }
        } ];
        [alert useDefaultIOS7Style];
    }
}

-(BOOL)ischecknewindex:(NSString *)key_indexpath
{
    return [key_indexpath isEqualToString:KEY_INDEXPATH(1, 0)];
}

-(BOOL)istelephoneindex:(NSString *)key_indexpath
{
    return [key_indexpath isEqualToString:KEY_INDEXPATH(1, 1)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
