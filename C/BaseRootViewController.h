//
//  BaseRootViewController.h
//  JXL
//
//  Created by 星盛 on 15/4/14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseViewController.h"
#import "RKTabView.h"

@interface BaseRootViewController : BaseViewController

@property (nonatomic,strong)  RKTabView             * tabViewSocial;
-(void)TabSelectAtIndex:(int)index;
@end
