//
//  A0_FirstPage_RecomendCell.h
//  JXL
//
//  Created by 跑酷 on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
static NSString * key_firstpage_recomendcell_article = @"key_firstpage_recomendcell_article";
static NSString * key_firstpage_recomendcell_Investor = @"key_firstpage_recomendcell_Investor";
static NSString * key_firstpage_recomendcell_activityplates = @"key_firstpage_recomendcell_activityplates";
static NSString * key_firstpage_recomendcell_project = @"key_firstpage_recomendcell_project";

@interface A0_FirstPage_RecomendCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_firstarticle;
@property (weak, nonatomic) IBOutlet UIButton *btn_firstInvestor;
@property (weak, nonatomic) IBOutlet UIButton *btn_findproject;
@property (weak, nonatomic) IBOutlet UIButton *btn_activityplates;
@property (weak, nonatomic) IBOutlet UIImageView *img_project;
@property (weak, nonatomic) IBOutlet UIImageView *img_article;
@property (weak, nonatomic) IBOutlet UILabel *lbl_touziren;
@property (weak, nonatomic) IBOutlet UIControl *ctl_recomentarticle;
@property (weak, nonatomic) IBOutlet UIControl *ctl_recomendvc;
+(CGFloat)heightOfCell;
@end


@protocol A0_FirstPage_RecomendCellDelegate <NSObject>

-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell RecomandAreticleTap:(id)RecomandAreticleSender;
-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell RecomandVCTap:(id)RecomandVCSender;
-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell FindProject:(id)sender;
-(void)A0_FirstPage_RecomendCell:(A0_FirstPage_RecomendCell *)A0_FirstPage_RecomendCell ActiveCenter:(id)sender;
@end