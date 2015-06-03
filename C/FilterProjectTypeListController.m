//
//  FilterProjectTypeListController.m
//  JXL
//
//  Created by BooB on 15/5/24.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "FilterProjectTypeListController.h"
#import "jxl.h"
@interface FilterProjectTypeListController ()
AS_CELL_STRUCT_JXLCOMMON(select)
@end

@implementation FilterProjectTypeListController


GET_CELL_SELECT_ACTION(cellstruct)
{
    self.cell_struct_select = cellstruct; 
}

-(void)confirm:(id)sender
{
    if (self.cell_struct_select) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(FilterProjectTypeListController:selectItem:)]) {
            [self.delegate FilterProjectTypeListController:self selectItem:self.cell_struct_select.object];
        }
    }
    [self backtoparent:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [self userDefaultConfigWithTitle:@"选择项目类型"];
    [self.navigationbar setrightBarButtonItemWithTitle:@"选择" target:self selector:@selector(confirm:)];
    self.nodeselectRow = YES;
    [[ProjectTypeListModel sharedInstance] projectTypeList:^(NSDictionary *Dictionary) {
        NSLog(@"%@",Dictionary);
        if (Dictionary &&  [[Dictionary class] isSubclassOfClass:[NSArray class]]) {
            NSArray * array = [ProjectTypeListModel encodeDiction:Dictionary];
            [array enumerateObjectsUsingBlock:^(ProjectTypeList *obj, NSUInteger idx, BOOL *stop) {
                CELL_STRUCT * cellstruct = [JXL_Common cell_x_x_struct:obj.m_name target:self selectAction:@selector(selectAction:)];
                cellstruct.object = obj;
                [self.dataDictionary setObject:cellstruct forKeyedSubscript:KEY_INDEXPATH(0, idx)];
            }];
            [self.tableView reloadData];
        }
    } errorHandler:^(NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
