//
//  FilterNeedTypeViewController.h
//  JXL
//
//  Created by BooB on 15/5/24.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewController.h"
@class FilterNeedTypeViewController;

@protocol FilterNeedTypeViewControllerDelegate <NSObject>
-(void)cancelSelectFilterNeedTypeViewController:(FilterNeedTypeViewController *)FilterNeedTypeViewController;
-(void)FilterNeedTypeViewController:(FilterNeedTypeViewController *)FilterNeedTypeViewController selectItem:(NSString *)title money:(NSString *)money;
-(void)FilterNeedTypeViewController:(FilterNeedTypeViewController *)FilterNeedTypeViewController selectItem:(NSString *)title;
@end
@interface FilterNeedTypeViewController : BaseViewController
@property(nonatomic,assign) id<FilterNeedTypeViewControllerDelegate> delegate;
@end
