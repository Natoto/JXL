//
//  FilterProjectTypeListController.h
//  JXL
//
//  Created by BooB on 15/5/24.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewController.h"
@class FilterProjectTypeListController;
@class ProjectTypeList;

@protocol FilterProjectTypeListControllerDelegate <NSObject>

-(void)FilterProjectTypeListController:(FilterProjectTypeListController *)FilterProjectTypeListController selectItem:(ProjectTypeList *)item;
@end

@interface FilterProjectTypeListController : BaseTableViewController    
@property(nonatomic,assign) id <FilterProjectTypeListControllerDelegate> delegate;
@end
