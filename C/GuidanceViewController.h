//
//  GuidanceViewController.h
//  pengmi
//
//  Created by wei on 15/1/26.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class GuidanceViewController;

@protocol GuidanceViewControllerDelegate <NSObject>

@optional
//第一次进来的导引
//-(void)guidanceCallBack:(BOOL)isMan with:(NSInteger)actherIndex;
//切换账号或重生之后的导引

-(void)GuidanceViewController:(GuidanceViewController *)GuidanceViewController selectButtonTag:(NSInteger)tag dismissblock:(void (^)()) dismissblock;

-(void)GuidanceViewController:(GuidanceViewController *)GuidanceViewController dismissblock:(void (^)()) dismissblock;
@end

@interface GuidanceViewController : BaseViewController
@property (nonatomic, weak)id<GuidanceViewControllerDelegate> delegate;
@end
