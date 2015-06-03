//
//  A0_FirstPageSquareCell.h
//  JXL
//
//  Created by 跑酷 on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "SqureImageTitleView.h"

#define key_firstpage_squarecell_names @"key_firstpage_squarecell_names"
#define key_firstpage_squarecell_images @"key_firstpage_squarecell_images"

@interface A0_FirstPageSquareCell : BaseTableViewCell
//@property (weak, nonatomic) IBOutlet UIButton *btn_lefttop;
//@property (weak, nonatomic) IBOutlet UIButton *btn_leftbottom;
//@property (weak, nonatomic) IBOutlet UIButton *btn_righttop;
//@property (weak, nonatomic) IBOutlet UIButton *btn_rightbottom;
+(CGFloat)heightofcell;
@end

@protocol A0_FirstPageSquareCellDelegate <NSObject>

-(void)A0_FirstPageSquareCell:(A0_FirstPageSquareCell*)A0_FirstPageSquareCell SqureImageTitleView:(SqureImageTitleView *)SqureImageTitleView SelectIndex:(NSInteger)index;

@end