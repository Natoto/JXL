//
//  LeftViewController.m
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "LeftViewController.h"
#import "CELL_STRUCT.h"
#import "AppDelegate.h"
#import "B0_NewsViewController.h"
#import "C0_ProjectViewController.h"
#import "A1_ActivityViewController.h"
#import "BaseJXLViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
@synthesize dataDictionary = _dataDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)selectAction:(id)sender
{
    CELL_STRUCT *  cellstruct = (CELL_STRUCT *)sender;

    [AppdelegateSideViewController hideSideViewController:true];
    
    if (cellstruct) {
        NSString * Classname = cellstruct.object;
        Classname = Classname?Classname:@"BaseJXLViewController";
        Class cls = NSClassFromString(Classname);
        BaseViewController * ctr = nil;
        if(cellstruct.subvalue1 && [cellstruct.subvalue1 isEqualToString:@"xib"])
        {
            ctr = [[cls alloc] initWithNibName:Classname bundle:nil];
        }
        else
        {
            ctr = [[cls alloc] init];
        }
        ctr.title = cellstruct.title;
        [[RootViewController sharedInstance].navigationController pushViewController:ctr animated:YES];
    }
}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        CELL_STRUCT * cell0_0;
        CELL_STRUCT * cell0_1;
        CELL_STRUCT * cell0_2;
        CELL_STRUCT * cell0_3;
        
        cell0_0 = [[CELL_STRUCT alloc] initWithtitle:@"新闻中心" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:YES sel_selctor:@selector(selectAction:) delegate:self];
        cell0_0.picture = @"left_xinwenzhongxin";
        cell0_0.object= @"B0_NewsViewController";
        cell0_0.cellheight = 60;
        cell0_0.sectionheight = 25;
        cell0_0.titlecolor = @"white";
        cell0_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
        
        cell0_1 = [[CELL_STRUCT alloc] initWithtitle:@"项目中心" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_1.picture = @"left_xiangmuzhongxin";
        cell0_1.object = @"C0_ProjectViewController";
        cell0_1.selectionStyle = YES;
        cell0_1.cellheight = 60;
        cell0_1.titlecolor = @"white";
        cell0_1.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
        
        cell0_2 = [[CELL_STRUCT alloc] initWithtitle:@"活动中心" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_2.picture = @"left_huodongzhongxin";
        cell0_2.object = @"A1_ActivityViewController";
        cell0_2.selectionStyle = YES;
        cell0_2.cellheight = 60;
        cell0_2.titlecolor = @"white";
        cell0_2.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
        
        cell0_3 = [[CELL_STRUCT alloc] initWithtitle:@"参赛直播" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_3.picture = @"left_cansaizhibao";
        cell0_3.titlecolor = @"white";
        cell0_3.cellheight = 60;
        cell0_3.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
       
        CELL_STRUCT *cell0_4 = [[CELL_STRUCT alloc] initWithtitle:@"参赛报名" cellclass:@"BaseTableViewCell" placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];
        cell0_4.picture = @"left_cansaibaoming";
        cell0_4.titlecolor = @"white";
        cell0_4.cellheight = 60;
        cell0_4.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];
        
        NSMutableDictionary * array0 =[NSMutableDictionary dictionaryWithObjectsAndKeys:cell0_0,KEY_INDEXPATH(0, 0),cell0_1,KEY_INDEXPATH(0, 1),cell0_2,KEY_INDEXPATH(0, 2),cell0_3,KEY_INDEXPATH(0, 3),cell0_4,KEY_INDEXPATH(0, 4),nil];
        
        _dataDictionary = array0;
    }
    return _dataDictionary;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left_background"]];
    self.tableView.scrollEnabled = NO;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
