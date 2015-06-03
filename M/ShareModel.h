//
//  ShareModel.h
//  PENG
//
//  Created by 跑酷 on 15/5/20.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
@interface ShareModel : NSObject
+ (instancetype)sharedInstance;
@property(nonatomic,strong) id<ISSContent>          publishContent;
@property(nonatomic,strong) id<ISSContainer>        container;


-(void)registShareSDK;
-(void)openShareViewWithViewController:(UIViewController*)viewController content:(NSString*)content fontIndex:(NSUInteger)fontIndex image:(UIImage*)image;
/**
 * 分享碰密 带id的方式
 */
-(void)openShareViewWithViewController:(UIViewController*)viewController content:(NSString*)content fontIndex:(NSUInteger)fontIndex image:(UIImage*)image m_id:(NSNumber *)m_id;

//-(void)openShareViewWithViewController:(UIViewController*)viewController content:(NSString*)content fontIndex:(NSUInteger)fontIndex image:(UIImage*)image title:(NSString*)title url:(NSString*)url description:(NSString*)description;

@end
