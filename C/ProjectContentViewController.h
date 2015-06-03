//
//  PageContentViewController.h
//  JXL
//
//  Created by BooB on 15-4-19.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ProjectContentViewController : BaseTableViewController
@property(nonatomic,strong) NSString * m_typeid;
@property(nonatomic,strong) NSString * m_sort;
-(void)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottomt;

@end
