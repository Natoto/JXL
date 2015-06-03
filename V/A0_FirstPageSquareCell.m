//
//  A0_FirstPageSquareCell.m
//  JXL
//
//  Created by 跑酷 on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "A0_FirstPageSquareCell.h"
#import "UIButton+Alignment.h"
#import "SqureImageTitleView.h"
#import "UIViewAdditions.h"
@implementation A0_FirstPageSquareCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
int const tag_of_sqtstart = 100;

-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    [super setcelldictionary:dictionary];
    NSArray * subviews = [self.contentView subviews];
    [subviews enumerateObjectsUsingBlock:^(UIView *aview, NSUInteger idx, BOOL *stop) {
        if ([[aview class] isSubclassOfClass:[SqureImageTitleView class]]) {
            SqureImageTitleView * view = (SqureImageTitleView *)aview;
            [view removeFromSuperview];
        }
    }];
    if (dictionary) {
        NSArray * names = [dictionary objectForKey:key_firstpage_squarecell_names];
        NSArray * images = [dictionary objectForKey:key_firstpage_squarecell_images];
        
        CGFloat margin_w = 5;
        CGFloat item_w = (self.contentView.width - 3* margin_w)/2;
        CGFloat item_h = item_w;
        if (!names.count) {
           
        }
        
        [names enumerateObjectsUsingBlock:^(NSString * name, NSUInteger idx, BOOL *stop) {
            
            NSString * imgurl = [images objectAtIndex:idx];
            SqureImageTitleView * view = (SqureImageTitleView *)[self.contentView viewWithTag:idx + tag_of_sqtstart];
            if (!view) {
                view = [self createsqureviewWithTag:idx + tag_of_sqtstart];
                [self.contentView addSubview:view];
            }
            
            view.frame = CGRectMake((idx%2) * item_w + (idx%2 + 1) * margin_w, (idx /2) * item_h +  margin_w , item_w, item_h);
            [view dataChange:name imgurl:imgurl];
        }];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    [self.btn_leftbottom setLayout:OTSImageTopTitleBootomStyle spacing:5];
//    [self.btn_lefttop setLayout:OTSImageTopTitleBootomStyle spacing:5];
//    [self.btn_rightbottom setLayout:OTSImageTopTitleBootomStyle spacing:5];
//    [self.btn_righttop setLayout:OTSImageTopTitleBootomStyle spacing:5];
}


-(SqureImageTitleView *)createsqureviewWithTag:(NSInteger)tag
{
    SqureImageTitleView * sv = [[SqureImageTitleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    sv.backgroundColor = [UIColor whiteColor];
    [sv addTarget:self action:@selector(viewTap:) forControlEvents:UIControlEventTouchUpInside];
    sv.tag = tag;
    return sv;
}

-(IBAction)viewTap:(id)sender
{
    SqureImageTitleView * sqt = (SqureImageTitleView *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(A0_FirstPageSquareCell:SqureImageTitleView:SelectIndex:)]) {
        [self.delegate A0_FirstPageSquareCell:self SqureImageTitleView:sqt SelectIndex:sqt.tag - tag_of_sqtstart];
    }
}

+(CGFloat)heightofcell
{
    return 320;
}


@end
