//
//  BubbleViewCell.m
//  pengmi
//
//  Created by 星盛 on 15/2/9.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "BubbleViewCell.h"
#import "JXL_Define.h"
#import "BubbleStruct.h"

@interface BubbleViewCell()
{

}
@property (weak, nonatomic) IBOutlet UIImageView *img_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_type;
@property (weak, nonatomic) IBOutlet UIButton *btn_select;

@end
@implementation BubbleViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)selectcell:(id)sender {
    
}

-(void)dataChange:(id)object
{
    BubbleStruct * abs =(BubbleStruct *)object;
    self.contentView.backgroundColor = HBRandomColor;
    if (!abs) {
        return;
    }
    self.img_content.image =[UIImage imageNamed:abs.m_image];
    self.btn_select.hidden = YES;
    self.btn_type.hidden = YES;
//    if (abs.m_title.length) {
//        [self.btn_type setTitle:abs.m_title forState:UIControlStateNormal];
//        self.btn_type.hidden = NO;
//        self.btn_select.hidden = NO;
//    }
//    else
//    {
//        self.btn_select.hidden = YES;
//        self.btn_type.hidden = YES;
//    }
//    if (abs.m_select) {
//        [self selectBubbleCell:YES];
//    }
}

-(void)selectBubbleCell:(BOOL)select
{
    if (select) {
         [self.btn_select setImage:[UIImage imageNamed:@"edit_select_on"] forState:UIControlStateNormal];
        self.isselected = select;
    }
    else
    {
        [self.btn_select setImage:[UIImage imageNamed:@"edit_select_off"] forState:UIControlStateNormal];
          self.isselected = select;
    }
}
@end
