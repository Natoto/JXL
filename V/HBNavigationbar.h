//
//  HBNavigationbar.h
//  JXL
//
//  Created by BooB on 15-4-18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBNavigationbar : UIView
+(HBNavigationbar *)navigationbar;

@property(nonatomic,strong) UIColor     * TintColor;
@property(nonatomic,strong) UIView      * titleView;
@property(nonatomic,strong) UIControl   * leftItem;
@property(nonatomic,strong) UIControl   * rightItem;
@property(nonatomic,strong) NSString    * title;
-(void)drawtoplinelayer;
+(UIImage *)defaultbackImage;

-(UIButton *)setrightBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;
-(UIButton *)setrightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

-(UIButton *)setleftBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;
-(UIButton *)setleftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;
-(UIButton *)setBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image leftbar:(BOOL)left target:(id)target selector:(SEL)selector;

+(HBNavigationbar *)navigationtoolbar;
@end
