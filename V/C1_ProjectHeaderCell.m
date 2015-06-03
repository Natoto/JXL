//
//  C1_ProjectHeaderCell.m
//  JXL
//
//  Created by BooB on 15-4-23.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "AdScrollView.h"
#import "C1_ProjectHeaderCell.h"
#import "jxl.h"

@interface C1_ProjectHeaderCell()
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIView *ad_view;
@property (strong, nonatomic)         AdScrollView *ad_scrolliview;
@property (weak, nonatomic) IBOutlet UILabel *lbl_state;
@property (weak, nonatomic) IBOutlet UILabel *lbl_location;

@end
@implementation C1_ProjectHeaderCell

- (void)awakeFromNib {
    // Initialization code
    self.lbl_state.backgroundColor = KT_UIColorWithRGB(214, 118, 34);
    self.lbl_state.textColor = [UIColor whiteColor];
    self.lbl_location.backgroundColor = KT_UIColorWithRGB(209, 209, 209);
    self.lbl_location.textColor = [UIColor whiteColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(AdScrollView *)ad_scrolliview
{
    if (!_ad_scrolliview) {
        _ad_scrolliview = [[AdScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,200)];
        [self.ad_view addSubview:_ad_scrolliview];
    }
    return _ad_scrolliview;
}
-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    if (!dictionary) {
        return;
    }
    [super setcelldictionary:dictionary]; 
    NSArray * headerimageNameArray = [dictionary objectForKey:key_projectheader_imageNameArray];
    NSArray * headerTitleNameArray = [dictionary objectForKey:key_projectheader_titleNameArray];
    if (self.ad_scrolliview) {
        self.ad_scrolliview.imageNameArray = headerimageNameArray;
        self.ad_scrolliview.PageControlShowStyle = UIPageControlShowStyleNone;
        self.ad_scrolliview.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self.ad_scrolliview setAdTitleArray:headerTitleNameArray withShowStyle:AdTitleShowStyleLeft];
        self.ad_scrolliview.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    }
    self.lbl_title.text = [dictionary objectForKey:key_projectheader_discription];
    self.lbl_location.text = [dictionary objectForKey:key_projectheader_location];
    self.lbl_state.text = [dictionary objectForKey:key_projectheader_state];
}


-(void)setcellTitle:(NSString *)title
{
    
}
-(void)setcellProfile:(NSString *)profile
{
    
}

@end
