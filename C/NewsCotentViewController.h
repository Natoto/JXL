//
//  NewsCotentViewController.h
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewController.h"

@interface NewsCotentViewController : BaseTableViewController

@property(nonatomic,retain) NSString * m_catid;
-(void)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottomt;
 
@end
