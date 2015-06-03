//
//  TopSelectorScrollerView.h
//  JXL
//
//  Created by 星盛 on 15/4/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopSelectorScrollerView;
@protocol TopSelectorScrollerViewDelegate

-(NSArray *)tabsOfScrollView:(TopSelectorScrollerView *)scrollerView;
//-(NSUInteger)numberOfTab:(TopSelectorScrollerView *)scrollerView;
 
@optional
-(CGSize)slideTabTextSize:(TopSelectorScrollerView *)scrollerView;
/**
 * 点击选择动作
 */
//-(void)topSelectorScrollerView:(TopSelectorScrollerView *)view selectNameButton:(UIButton *)sender;
-(void)topSelectorScrollerView:(TopSelectorScrollerView *)view didselectTab:(NSUInteger)tabtag;
@end

@interface TopSelectorScrollerView : UIScrollView
@property(nonatomic,assign) NSObject <TopSelectorScrollerViewDelegate> *selectorDelegate;

@property (nonatomic,strong)  UIImageView   * shadowImageView;
@property (nonatomic,strong)  UIImage       * shadowImage;
@property (nonatomic, strong) UIColor       * tabItemNormalColor;
@property (nonatomic, strong) UIColor       * tabItemSelectedColor;
@property (nonatomic, strong) UIImage       * tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage       * tabItemSelectedBackgroundImage;

@property (nonatomic, strong) UIButton      * rigthSideButton;
+(TopSelectorScrollerView *)defaultTopSelectorScrollerView;
- (void)buildUI;
-(void)selectItemView:(int)index;

-(void)reloadData;
@end
