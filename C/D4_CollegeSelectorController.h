//
//  D4_CollegeSelectorController.h
//  JXL
//
//  Created by BooB on 15/5/3.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseViewController.h"
@class D4_CollegeSelectorController;
@protocol D4_CollegeSelectorControllerDelegate <NSObject>

-(void)cencelSelectD4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController;
@optional
-(void)D4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController selectCollegeName:(NSString *)collegeName collegeID:(NSString *)collegeID;


-(void)D4_CollegeSelectorController:(D4_CollegeSelectorController *)D4_CollegeSelectorController  selectCollageCityName:(NSString *)selectCollegeCityName selectCollegeCityID:(NSString *)selectCollegeCityID selectCollegeName:(NSString *)collegeName collegeID:(NSString *)collegeID;
@end

@interface D4_CollegeSelectorController : BaseViewController

@property(nonatomic,assign)id <D4_CollegeSelectorControllerDelegate> selectordelegate;
@end
