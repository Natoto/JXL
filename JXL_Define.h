//
//  JXL.h
//  JXL
//
//  Created by BooB on 15-4-13.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#ifndef JXL_JXL_h
#define JXL_JXL_h

#undef	AS_SINGLETON
#define AS_SINGLETON

#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#else	// #if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}


#endif	// #if __has_feature(objc_instancetype)

//随机颜色
#define HBRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


//圆角
#define KT_CORNER_PROFILE(_OBJ) _OBJ.layer.masksToBounds = YES;\
[_OBJ.layer setCornerRadius:CGRectGetHeight([_OBJ bounds]) / 2];\
_OBJ.layer.borderWidth = 0;\
_OBJ.layer.borderColor = [[UIColor whiteColor] CGColor];

#define KT_CORNER_RADIUS(_OBJ,_RADIUS)   _OBJ.layer.masksToBounds = YES;\
_OBJ.layer.cornerRadius = _RADIUS;

#define KT_LAYERBOARDER_COLOR(_OBJ,_WIDTH,_COLOR)   _OBJ.layer.masksToBounds = YES;\
_OBJ.layer.borderColor = _COLOR.CGColor;\
_OBJ.layer.borderWidth = _WIDTH;

#define KT_CORNER_RADIUS_VALUE_2    2.0f
#define KT_CORNER_RADIUS_VALUE_5    5.0f
#define KT_CORNER_RADIUS_VALUE_10   10.0f
#define KT_CORNER_RADIUS_VALUE_15   15.0f
#define KT_CORNER_RADIUS_VALUE_20   20.0f

//随机颜色
#define HBRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
//----------------------------------------------------------------- 颜色
#define KT_HEXCOLORA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define KT_HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]

#define KT_HEXCOLORA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define KT_UIColorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KT_UIColorWithRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0f]

//常用变量

//navigationbar 高度
#define HEIGHT_NAVIGATIONBAR 64.0
#define HEIGHT_NAVIGATIONCTR [UIScreen mainScreen].bounds.size.height - HEIGHT_NAVIGATIONBAR 
#define HEIGHT_TABBAR  50.0

#define UISCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define UISCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define UISCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)

//淡色底
#define JXL_COLOR_THEME KT_UIColorWithRGB(245, 245, 245)
//蓝色
#define JXL_COLOR_THEME_NAVIGATIONBAR KT_UIColorWithRGB(14, 113, 196)

//tabbar 灰色
#define JXL_COLOR_THEME_TABBAR KT_UIColorWithRGB(232, 232, 232)
#pragma mark - 配置

//取消短信验证这一步 用于测试阶段
#define CONFIG_NONEED_MSG NO
#define CONFIG_NONEED_COMLETE NO

//#define SHARE_SDK_APP @"584bde980ec5"
//254381441@qq.com zxcqwe123456 mob分享帐号新浪微博KEY：金项恋（新浪微博KEY）
//App Key：2882301233
//App Secret：7da62f885ca7888cd4fa4c49f7591e39金项恋 （腾讯移动互联）
//APP ID:1104553370
//APP KEY:Egvv6bp5OSITNgVO

//微信
//AppID：wxd58418daf2ba3499
//AppSecret：c4ec995dd40b174f4a20fa2ad0714195
//http://112.74.78.166/api.php?m=App&a=project


//金项链进度安排
//
//新闻列表  420 _______ok
//
//项目列表  420  _______ok
//
//活动   420 _______ok
//
//我  421  _______ok
//
//注册  421
//
//登录 421  ?? 没有吗
//
//新闻详情 422
//
//项目详情  422  _______ok
//
//评论页面 423
//
//我的界面 423
//
//我的主页 424
//
//我报名的活动 425
//
//我评论过的新闻  425
//
//我评论过的项目 426
//
//设置 427
//
//关于我们 428
//
//投资人 429
//
//地图  430
//
//下载附件  430
//
//18个页面








