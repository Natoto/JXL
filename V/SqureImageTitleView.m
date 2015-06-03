//
//  SqureImageTitleView.m
//  JXL
//
//  Created by BooB on 15/5/11.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "SqureImageTitleView.h"
#import "UIViewAdditions.h"
#import "UIImageView+WebCache.h"
#import "NSString+HBExtension.h"
@implementation SqureImageTitleView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, self.height - 20, self.width, 20);
    self.imageView.frame = CGRectMake(0, 0, self.width, self.titleLabel.top);
}

-(void)dataChange:(NSString *)title imgurl:(NSString *)imgurl
{
    if ([imgurl isUrl]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"default_activeslist_item"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.imageView setNeedsDisplay];
        }];
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:imgurl];
    }
    self.titleLabel.text = title;
}


-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_activeslist_item@2x"]];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.userInteractionEnabled = NO;
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 20, self.width, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
