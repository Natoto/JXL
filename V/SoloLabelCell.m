//
//  SoloLabelCell.m
//  JXL
//
//  Created by 跑酷 on 15/5/21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "SoloLabelCell.h"
#import "NIAttributedLabel.h"
#import "UIViewAdditions.h"
@interface SoloLabelCell()<NIAttributedLabelDelegate>
@end
@implementation SoloLabelCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(void)setcellProfile:(NSString *)profile{}
-(void)setcellTitle:(NSString *)title
{
    self.m_Label.text = title;
    CGSize size = [self.m_Label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 0)];
    self.m_Label.height = size.height;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.m_Label.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, self.contentView.height);
}

static UILabel * testLabel;
+(CGFloat)heighofCell:(NSString *)content
{
    if (!testLabel) {
        testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, 0)];
        testLabel.numberOfLines = 0;
        testLabel.font = [UIFont systemFontOfSize:13];
    }
    testLabel.text = content;
    CGSize size = [testLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0)];
    return fmaxf(size.height + 10, 44);
}

-(NIAttributedLabel *)m_Label
{
    if (!_m_Label) {
        _m_Label = [[NIAttributedLabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 44)];
        _m_Label.numberOfLines = 0;
        _m_Label.lineBreakMode = NSLineBreakByCharWrapping;
        _m_Label.autoDetectLinks = YES;
        _m_Label.font = [UIFont systemFontOfSize:13];
        _m_Label.delegate = self;
        [self.contentView addSubview:_m_Label];
    }
    return _m_Label;
}

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    [[UIApplication sharedApplication] openURL:result.URL];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
