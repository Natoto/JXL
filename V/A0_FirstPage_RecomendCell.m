//
//  A0_FirstPage_RecomendCell.m
//  JXL
//
//  Created by 跑酷 on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A0_FirstPage_RecomendCell.h"
#import "UIImageView+WebCache.h"
#import "HomeIndexModel.h"
#import "UIButton+WebCache.h"
#import "UIButton+Alignment.h"
@implementation A0_FirstPage_RecomendCell

- (void)awakeFromNib {
    // Initialization code
    [self.btn_firstInvestor setLayout:OTSImageTopTitleBootomStyle spacing:5];
    KT_CORNER_PROFILE(self.btn_firstInvestor)
    KT_CORNER_PROFILE(self.img_article)
//    self.btn_firstInvestor.layer.borderColor = [UIColor grayColor].CGColor;
//    self.btn_firstInvestor.layer.borderWidth = 0.5;
}

+(CGFloat)heightOfCell
{
    return 290;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)recomendArticleTap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPage_RecomendCell:RecomandAreticleTap:) ]) {
        [self.delegate A0_FirstPage_RecomendCell:self RecomandAreticleTap:sender];
    }
}
- (IBAction)recomendVCTap:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPage_RecomendCell:RecomandAreticleTap:) ]) {
        [self.delegate A0_FirstPage_RecomendCell:self RecomandVCTap:sender];
    }
}
- (IBAction)activecenter:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPage_RecomendCell:RecomandAreticleTap:) ]) {
        [self.delegate A0_FirstPage_RecomendCell:self ActiveCenter:sender];
    }
}
- (IBAction)findproject:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPage_RecomendCell:RecomandAreticleTap:) ]) {
        [self.delegate A0_FirstPage_RecomendCell:self FindProject:sender];
    }
}

-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    [super setcelldictionary:dictionary];
    if (dictionary) {
        FirstInvestor * firstvc = [dictionary objectForKey:key_firstpage_recomendcell_Investor];
        FirstNews   * firstnews = [dictionary objectForKey:key_firstpage_recomendcell_article];
        
        [self.btn_firstInvestor sd_setImageWithURL:[NSURL URLWithString:firstvc.m_img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_activeslist_item"]];
        
        [self.img_article sd_setImageWithURL:[NSURL URLWithString:firstnews.m_img] placeholderImage:[UIImage imageNamed:@"default_activeslist_item"]];
        self.lbl_firstarticle.text  = firstnews.m_title;
        self.lbl_touziren.text = firstvc.m_title;
//        [self.btn_firstInvestor setTitle:firstvc.m_title forState:UIControlStateNormal];
    }
}

@end
