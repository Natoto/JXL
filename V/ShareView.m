//
//  ShareView.m
//  pengmi
//
//  Created by wei on 15/1/29.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

-(void)setImage:(UIImage*)image content:(NSString*)content fontIndex:(NSUInteger)fontIndex
{
    self.image1.image = image;
    self.label.text = content;
    self.image1.layer.cornerRadius = 8.0;
    self.image1.layer.masksToBounds = YES;
    [self setMyFontType:fontIndex];
}
-(void)setMyFontType:(NSUInteger)index
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.label.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary * dictionary = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSParagraphStyleAttributeName:paragraphStyle,
                                  NSFontAttributeName:[UIFont systemFontOfSize:12],
                                  NSStrokeWidthAttributeName:@-2,
                                  NSStrokeColorAttributeName:[UIColor grayColor],
                                  };
    [attributedString addAttributes:dictionary range:NSMakeRange(0, attributedString.length)];
    self.label.attributedText = attributedString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
