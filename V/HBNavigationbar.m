//
//  HBNavigationbar.m
//  JXL
//
//  Created by BooB on 15-4-18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "HBNavigationbar.h"
#import "JXL_Define.h"
#import "ToolsFunc.h"
#import "UIImage+Tint.h"

@implementation HBNavigationbar
@synthesize leftItem = _leftItem;
@synthesize rightItem = _rightItem;
@synthesize titleView = _titleView;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:234./255.0 green:234./255.0 blue:234./255.0 alpha:1.0f];
        [self drawtabviewsociallayer];
        [self addSubview:self.leftItem];
        [self addSubview:self.rightItem];
        [self addSubview:self.titleView];
    }
    return self;
}

+(HBNavigationbar *)navigationbar
{
    CGFloat BAR_HEIGHT = 44;
    CGFloat ITEM_HEIGHT = 80;
    CGFloat STATUS_HEIGHT = 20;
    HBNavigationbar * navbar = [[HBNavigationbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, BAR_HEIGHT + STATUS_HEIGHT)];
    
    [navbar leftItem];
    if (navbar.leftItem) {
        navbar.leftItem.frame = CGRectMake(10, 5, ITEM_HEIGHT, ITEM_HEIGHT);
    }
    
    if (navbar.rightItem) {
        navbar.rightItem.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50 , 0, ITEM_HEIGHT, BAR_HEIGHT);
    }
    navbar.leftItem.center = CGPointMake( ITEM_HEIGHT/2 + 10,STATUS_HEIGHT + BAR_HEIGHT/2);
    navbar.rightItem.center = CGPointMake( [UIScreen mainScreen].bounds.size.width - ITEM_HEIGHT/2 - 10 , BAR_HEIGHT/2 + STATUS_HEIGHT);
    if (navbar.titleView ) {
        navbar.titleView.frame = CGRectMake(0, 0, 200, BAR_HEIGHT);
        navbar.titleView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, BAR_HEIGHT/2 + STATUS_HEIGHT);
    }
    return navbar;
}

+(HBNavigationbar *)navigationtoolbar
{
    CGFloat BAR_HEIGHT = 44;
    CGFloat ITEM_HEIGHT = 80;
    CGFloat STATUS_HEIGHT = 0;
    HBNavigationbar * navbar = [[HBNavigationbar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, BAR_HEIGHT + STATUS_HEIGHT)];
    
    [navbar leftItem];
    if (navbar.leftItem) {
        navbar.leftItem.frame = CGRectMake(10, 5, ITEM_HEIGHT, ITEM_HEIGHT);
    }
    
    if (navbar.rightItem) {
        navbar.rightItem.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50 , 0, ITEM_HEIGHT, BAR_HEIGHT);
    }
    navbar.leftItem.center = CGPointMake( ITEM_HEIGHT/2 + 10,STATUS_HEIGHT + BAR_HEIGHT/2);
    navbar.rightItem.center = CGPointMake( [UIScreen mainScreen].bounds.size.width - ITEM_HEIGHT/2 - 10 , BAR_HEIGHT/2 + STATUS_HEIGHT);
    if (navbar.titleView ) {
        navbar.titleView.frame = CGRectMake(0, 0, 200, BAR_HEIGHT);
        navbar.titleView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, BAR_HEIGHT/2 + STATUS_HEIGHT);
    }
    return navbar;
}

-(void)drawtabviewsociallayer
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, self.frame.size.height - 0.5, UISCREEN_WIDTH, 0.5);
    //    imageLayer.contents = (id)image.CGImage;
    imageLayer.cornerRadius = 0;  //设置layer圆角半径
    imageLayer.masksToBounds = YES;  //隐藏边界
    imageLayer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.8].CGColor;  //边框颜色
    imageLayer.borderWidth = 0.5;
    [self.layer addSublayer:imageLayer];
}

-(void)drawtoplinelayer
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, UISCREEN_WIDTH, 0.5);
    //    imageLayer.contents = (id)image.CGImage;
    imageLayer.cornerRadius = 0;  //设置layer圆角半径
    imageLayer.masksToBounds = YES;  //隐藏边界
    imageLayer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.8].CGColor;  //边框颜色
    imageLayer.borderWidth = 0.5;
    [self.layer addSublayer:imageLayer];
}

-(void)setLeftItem:(UIControl *)leftItem
{
    if (leftItem!=_leftItem) {
        [_leftItem removeFromSuperview];
        _leftItem = leftItem;
        [self addSubview:_leftItem];
    }
}

-(UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIControl alloc] init];
    }
    return _titleView;
}
-(UIView *)leftItem
{
    if (!_leftItem) {
        _leftItem = [[UIControl alloc] init];
//        _leftItem.backgroundColor = HBRandomColor;
    }
    return _leftItem;
}

-(void)setRightItem:(UIControl *)rightItem
{
    if (rightItem!=_rightItem) {
        [_rightItem removeFromSuperview];
        _rightItem = rightItem;
        [self addSubview:_rightItem];
    }
}

-(UIView *)rightItem
{
    if (!_rightItem) {
        _rightItem = [[UIControl alloc] init];
//        _rightItem.backgroundColor = HBRandomColor;
    }
    return _rightItem;
}

-(void)setTitleView:(UIView *)titleView
{
    if (titleView != _titleView) {
        CGRect frame = self.titleView.frame;
        [_titleView removeFromSuperview];
         _titleView = titleView;
        _titleView.frame = frame;
        [self addSubview:_titleView];
    }
}

-(void)setTintColor:(UIColor *)tintColor
{
    _TintColor = tintColor;
    UILabel * lbl = (UILabel *)[self.titleView viewWithTag:4240024];
    if (lbl) {
        lbl.textColor = tintColor;
    }
}
-(void)setTitle:(NSString *)title
{
    _title = title;
    CGRect frame = self.titleView.frame;
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor =  [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = title;
    label.tag = 4240024;
    [self.titleView removeFromSuperview];
    self.titleView = label;
    [self addSubview:self.titleView];
}

+(UIImage *)defaultbackImage
{
    UIImage * image = [UIImage imageNamed:@"fanhui"];
    return image;
}
-(UIButton *)setrightBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector
{
  return [self setBarButtonItemWithImage:image leftbar:NO target:target selector:selector];
}

-(UIButton *)setrightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
   return [self setBarButtonItemWithTitle:title leftbar:NO target:target selector:selector];
}

-(UIButton *)setleftBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector
{
   return [self setBarButtonItemWithImage:image leftbar:YES target:target selector:selector];
}

-(UIButton *)setleftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
   return [self setBarButtonItemWithTitle:title leftbar:YES target:target selector:selector];
}

-(UIButton *)setBarButtonItemWithTitle:(NSString *)title leftbar:(BOOL)left target:(id)target selector:(SEL)selector
{
   return [self setBarButtonItemWithTitle:title image:nil leftbar:left target:target selector:selector];
}

-(UIButton *)setBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image leftbar:(BOOL)left target:(id)target selector:(SEL)selector
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    if (!image && title) {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTintColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
    }
    if (title){
            [button setTitle:title forState:UIControlStateNormal];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (selector) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
         button.showsTouchWhenHighlighted = YES;
    }
    if (left) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.frame= _leftItem.frame;
        [_leftItem removeFromSuperview];
        _leftItem = button;
        [self addSubview:_leftItem];
    }
    else
    {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button.frame= _rightItem.frame;
        [_rightItem removeFromSuperview];
        _rightItem = button;
        [self addSubview:_rightItem];
    }
    return button;
}

-(UIButton *)setBarButtonItemWithImage:(UIImage *)image leftbar:(BOOL)left target:(id)target selector:(SEL)selector
{
   return [self setBarButtonItemWithTitle:nil image:image leftbar:left target:target selector:selector];
}

@end
