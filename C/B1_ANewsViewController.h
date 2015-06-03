//
//  B1_ANewsViewController.h
//  JXL
//
//  Created by BooB on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseViewController.h"
/**
 * B1_ANewsViewController * ctr = [[B1_ANewsViewController alloc] initWithNewsId:obj.m_id mid:[GlobalData sharedInstance].m_mid];
 ctr.m_newcomment = obj.m_views;
 [[RootViewController sharedInstance]  rootpushviewcontroller:ctr animated:YES];//
 */

@interface B1_ANewsViewController : BaseViewController
@property(nonatomic,retain) NSString * m_news_id;
@property(nonatomic,retain) NSString * m_mid;
@property(nonatomic,retain) NSString * m_newcomment;
@property(nonatomic,retain) NSString * image;
-(id)initWithNewsId:(NSString *)news_id mid:(NSString *)mid;
@end
