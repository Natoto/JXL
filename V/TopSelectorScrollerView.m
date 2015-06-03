//
//  TopSelectorScrollerView.m
//  JXL
//
//  Created by 星盛 on 15/4/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import "JXL_Define.h"
#import "TopSelectorScrollerView.h"
@interface TopSelectorScrollerView()
{
    NSInteger _userSelectedChannelID;               //点击按钮选择名字ID
    BOOL _isBuildUI;                                //是否建立了ui
}

@end


#define LINE_LAYERBOARD_NOTCGCOLOR [UIColor colorWithWhite:0.8 alpha:1.0f]
#define LINE_LAYERBOARDCOLOR [UIColor colorWithWhite:0.8 alpha:1.0f].CGColor
#define LINE_LAYERBOARDWIDTH 0.5f
#define TAG_QC_BUTTON_START 100
#define SLIDSWITCH_SECTIONS_HEIGHT 30.0f

//static const CGFloat kYOfTopScrollView = 0;
static const CGFloat kHeightOfTopScrollView = SLIDSWITCH_SECTIONS_HEIGHT;
static const CGFloat kWidthOfButtonMargin = 2.0f;
static const CGFloat kFontSizeOfTabButton = 16.0f;
//static const NSUInteger kTagOfRightSideButton = 999;

@implementation TopSelectorScrollerView


+(TopSelectorScrollerView *)defaultTopSelectorScrollerView
{
    TopSelectorScrollerView *_topSelectorScrollerView = [[TopSelectorScrollerView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    _topSelectorScrollerView.showsHorizontalScrollIndicator = NO;
    _topSelectorScrollerView.tabItemNormalColor = KT_UIColorWithRGB(97, 100, 113);// KT_HEXCOLOR(0x868686);
    _topSelectorScrollerView.tabItemSelectedColor =KT_UIColorWithRGB(240, 40, 50);// KT_HEXCOLOR(0xbb0b15);    
    //        _topSelectorScrollerView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]\
    stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
   
    return _topSelectorScrollerView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isBuildUI = NO;
        _userSelectedChannelID = TAG_QC_BUTTON_START;
    }
    return self;
}
/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    [self createNameButtons];
    //选中第一个view
    if (self.selectorDelegate && [self.selectorDelegate respondsToSelector:@selector(topSelectorScrollerView:didselectTab:)]) {
        [self.selectorDelegate  topSelectorScrollerView:self didselectTab:0];
    }
    _isBuildUI = YES; 
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

-(void)reloadData
{
    [self buildUI];
}

- (void)createNameButtons
{
    /*
    //下边框着色
    UIImageView *bottomBorder = [[UIImageView alloc] init];
    float height=self.frame.size.height-LINE_LAYERBOARDWIDTH;
    float width=self.frame.size.width;
    bottomBorder.frame = CGRectMake(0, height, width, LINE_LAYERBOARDWIDTH);
    bottomBorder.backgroundColor =LINE_LAYERBOARD_NOTCGCOLOR; //[UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    [self addSubview:bottomBorder];
    */
    
    NSArray * subviews = self.subviews;
    [subviews enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
        _shadowImageView = nil;
    }];
    
    if (!_shadowImageView) {
        _shadowImageView = [[UIImageView alloc] init];
        _shadowImageView.tag = 54;
        [self addSubview:_shadowImageView];
    }
    [_shadowImageView setImage:_shadowImage];
    
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = kWidthOfButtonMargin;
    //每个tab偏移量
    CGFloat xOffset = kWidthOfButtonMargin;
    
    //slideTabTextSize
    
    NSArray *Tabs = [self.selectorDelegate tabsOfScrollView:self];
    NSInteger tabscount = Tabs.count>5?5:Tabs.count;
    
    CGSize textSize =CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) /tabscount, kHeightOfTopScrollView);
    
    if (self.selectorDelegate && [self.selectorDelegate respondsToSelector:@selector(slideTabTextSize:)]) {
        textSize = [self.selectorDelegate slideTabTextSize:self];
    }
    
    for (int i = 0; i < Tabs.count; i++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:i+TAG_QC_BUTTON_START];//
        if (!button) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:button];
            [button setTag:i+TAG_QC_BUTTON_START];
        }
        
        //累计每个tab文字的长度
        topScrollViewContentWidth += kWidthOfButtonMargin+textSize.width;
        //设置按钮尺寸
        [button setFrame:CGRectMake(xOffset,0,
                                    textSize.width, self.frame.size.height)];
        
        //计算下一个tab的x偏移量
        xOffset += textSize.width + kWidthOfButtonMargin;
        
        if (i == 0) {
            _shadowImageView.frame = CGRectMake(kWidthOfButtonMargin, 0, textSize.width, button.frame.size.height);
            button.selected = YES;
        }
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button setTitle:[Tabs objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    //设置顶部滚动视图的内容总尺寸
    self.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
    
}

//当横竖屏切换时可通过此方法调整布局
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    //创建完子视图UI才需要调整布局
//    if (_isBuildUI) {
//        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
//        if (self.rigthSideButton.bounds.size.width > 0) {
//            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
//                                                _rigthSideButton.bounds.size.width, self.bounds.size.height);
//            
//            self.frame = CGRectMake(0, 0,
//                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
//        }
//        
//        
//        //滚动到选中的视图
//        [self setContentOffset:CGPointMake((_userSelectedChannelID - TAG_QC_BUTTON_START)*self.bounds.size.width, 0) animated:NO];
//        
//        //调整顶部滚动视图选中按钮位置
//        UIButton *button = (UIButton *)[self viewWithTag:_userSelectedChannelID];
//    }
//}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        [UIView animateWithDuration:0.1 animations:^{
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, sender.frame.size.height)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (self.selectorDelegate && [self.selectorDelegate respondsToSelector:@selector(topSelectorScrollerView:didselectTab:)]) {
                    [self.selectorDelegate topSelectorScrollerView:self didselectTab:_userSelectedChannelID - TAG_QC_BUTTON_START];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}


/*!
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - self.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [self setContentOffset:CGPointMake(sender.frame.origin.x - (self.bounds.size.width- (kWidthOfButtonMargin+sender.bounds.size.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - self.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [self setContentOffset:CGPointMake(sender.frame.origin.x - kWidthOfButtonMargin, 0)  animated:YES];
    }
    NSLog(@"_topScrollView.contentOffset X = %f Y = %f ",self.contentOffset.x,self.contentOffset.y);
}

-(void)selectItemView:(int)index
{
    index = index + TAG_QC_BUTTON_START;
    UIButton *button = (UIButton *)[self viewWithTag:index];
    if (button) {
        [self selectNameButton:button];
    }
}

@end
