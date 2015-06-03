//
//  FilterSearchBoard.m
//  JXL
//
//  Created by BooB on 15/5/24.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "FilterSearchBoard.h"
#import "jxl.h"
@interface FilterSearchBoard()
@property(nonatomic,retain) UIImageView * line_left;
@property(nonatomic,retain) UIImageView * line_center;

@property(nonatomic,assign) UIButton    * selectbutton;

@end;

@implementation FilterSearchBoard

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"FilterSearchBoard %s",__func__);
    self.backgroundColor = KT_UIColorWithRGB(248, 248, 248);
    
    [self initButtons:self.btn_school];
    [self initButtons:self.btn_hangye];
    [self initButtons:self.btn_needtype];
    
}
-(void)initButtons:(UIButton *)button
{
    [button setTitleColor:KT_UIColorWithRGB(0, 115, 202) forState:UIControlStateSelected];
    [button setTitleColor:KT_UIColorWithRGB(159, 159, 159) forState:UIControlStateNormal];
    
}

-(void)drawbottomlayer
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

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.btn_needtype addTarget:target action:action forControlEvents:controlEvents];
    [self.btn_school addTarget:target action:action forControlEvents:controlEvents];
    [self.btn_hangye addTarget:target action:action forControlEvents:controlEvents]; 
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.line_left.left = self.btn_school.right;
    self.line_center.left = self.btn_hangye.right;
    [self drawbottomlayer];
}


-(UIImageView *)line_center
{
    if (!_line_center) {
        _line_center = [self createLine];
        [self addSubview:_line_center];
    }
    return _line_center;
}

-(UIImageView *)line_left
{
    if (!_line_left) {
        UIImageView * img =  [self createLine];
        _line_left = img;
        [self addSubview:_line_left];
    }
    return _line_left;
}

-(UIImageView *)createLine
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.5 ,10)];
    img.backgroundColor = [UIColor grayColor];
    img.centerY = self.height/2;
    return img;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
