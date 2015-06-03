//
//  ShareModel.m
//  JXL
//
//  Created by BooB on 15-4-26.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "ShareModel.h"
#import "ShareView.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"

static NSString * SHARE_PENGMI_URL =  @"http://112.74.78.166";

@implementation ShareModel

+ (instancetype)sharedInstance \
{ \
    static dispatch_once_t once; \
    static id __singleton__; \
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
    return __singleton__; \
}

-(id)init
{
    self = [super init];
    if (self) {
        [self registShareSDK];
    }
    return self;
}

-(void)openShareViewWithViewController:(UIViewController*)viewController content:(NSString*)content fontIndex:(NSUInteger)fontIndex image:(UIImage*)image m_id:(NSNumber *)m_id
{
    NSString * shareurl = SHARE_PENGMI_URL; //self.mResDefine.m_shareUrlModel;
    //    if ([shareurl rangeOfString:@"%d"].location != NSNotFound) {
    //        shareurl = [shareurl stringByReplacingOccurrencesOfString:@"%d" withString:[NSString stringWithFormat:@"%@",m_id]];
    [self openShareViewWithViewController:viewController content:content fontIndex:fontIndex image:image title:@"金项恋" url:shareurl description:@"初恋从这里开始"];
    
    //    }
}

-(void)openShareViewWithViewController:(UIViewController*)viewController content:(NSString*)content fontIndex:(NSUInteger)fontIndex image:(UIImage*)image
{
    [self openShareViewWithViewController:viewController content:content fontIndex:fontIndex image:image title:@"金项恋" url:@"http://112.74.78.166" description:@"初恋从这里开始"];
}
- (UIImage *)getWithContent:(NSString*)content fontIndex:(NSInteger)fontIndex Image:(UIImage*)image  {
    
    //    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    view1.backgroundColor = [UIColor colorWithHexValue:0xff00ff alpha:1.0f];
//    ShareView * view1 = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:nil options:nil] firstObject];
//    [view1 setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, view1.bounds.size.height)];
//    [view1 setImage:image content:content fontIndex:fontIndex];
//    UIGraphicsBeginImageContextWithOptions(view1.bounds.size, NO, 1.0);  //NO，YES 控制是否透明
//    [view1.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}


-(void)openShareViewWithViewController:(UIViewController*)viewController content:(NSString*)content fontIndex:(NSUInteger)fontIndex image:(UIImage*)image title:(NSString*)title url:(NSString*)url description:(NSString*)description
{
    
    //构造分享内容
    self.publishContent = [ShareSDK content:content
                             defaultContent:@"来自金项恋"
                                      image:[ShareSDK pngImageWithImage:[self getWithContent:content fontIndex:fontIndex Image:image]]
                                      title:title
                                        url:url
                                description:description
                                  mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
    self.container = [ShareSDK container];
    [self.container setIPhoneContainerWithViewController:viewController];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(showShareSDKView:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)showShareSDKView:(NSTimer*)timer
{
    //弹出分享菜单
    [ShareSDK showShareActionSheet:self.container
                         shareList:nil
                           content:self.publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@",(long)[error errorCode],[error errorDescription]);
                                    UIAlertView * alerView =[[UIAlertView alloc] initWithTitle:@"提示" message:[error errorDescription] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
                                    [alerView show];
                                }
                            }];
}

-(void)registShareSDK
{
    [ShareSDK registerApp:@"584bde980ec5"];//字符串api20为您的ShareSDK的AppKey
    
    
    //254381441@qq.com zxcqwe123456 mob分享帐号新浪微博KEY：金项恋（新浪微博KEY）
    //App Key：2882301233
    //App Secret：7da62f885ca7888cd4fa4c49f7591e39金项恋 （腾讯移动互联）
    
    //APP ID:1104553370
    //APP KEY:Egvv6bp5OSITNgVO
    
    //微信
    //AppID：wxd58418daf2ba3499
    //AppSecret：c4ec995dd40b174f4a20fa2ad0714195
    
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"2882301233"
                                  appSecret:@"7da62f885ca7888cd4fa4c49f7591e39"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104553370"
                           appSecret:@"7da62f885ca7888cd4fa4c49f7591e39"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"QQ41D6259A"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wxd58418daf2ba3499"
                           appSecret:@"c4ec995dd40b174f4a20fa2ad0714195"
                           wechatCls:[WXApi class]];
    
    //    //添加搜狐微博应用  注册网址  http://open.t.sohu.com
    //    [ShareSDK connectSohuWeiboWithConsumerKey:@"SAfmTG1blxZY3HztESWx"
    //                               consumerSecret:@"yfTZf)!rVwh*3dqQuVJVsUL37!F)!yS9S!Orcsij"
    //                                  redirectUri:@"http://www.sharesdk.cn"];
    //
    //    //添加豆瓣应用  注册网址 http://developers.douban.com
    //    [ShareSDK connectDoubanWithAppKey:@"07d08fbfc1210e931771af3f43632bb9"
    //                            appSecret:@"e32896161e72be91"
    //                          redirectUri:@"http://dev.kumoway.com/braininference/infos.php"];
    //
    //
    //    //添加开心网应用  注册网址 http://open.kaixin001.com
    //    [ShareSDK connectKaiXinWithAppKey:@"358443394194887cee81ff5890870c7c"
    //                            appSecret:@"da32179d859c016169f66d90b6db2a23"
    //                          redirectUri:@"http://www.sharesdk.cn/"];
    //
    //    //添加Instapaper应用   注册网址  http://www.instapaper.com/main/request_oauth_consumer_token
    //    [ShareSDK connectInstapaperWithAppKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA"
    //                                appSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
    //
    //    //添加有道云笔记应用  注册网址 http://note.youdao.com/open/developguide.html#app
    //    [ShareSDK connectYouDaoNoteWithConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
    //                                consumerSecret:@"d98217b4020e7f1874263795f44838fe"
    //                                   redirectUri:@"http://www.sharesdk.cn/"];
    //
    //    //添加Facebook应用  注册网址 https://developers.facebook.com
    //    [ShareSDK connectFacebookWithAppKey:@"107704292745179"
    //                              appSecret:@"38053202e1a5fe26c80c753071f0b573"];
    //
    //    //添加Twitter应用  注册网址  https://dev.twitter.com
    //    [ShareSDK connectTwitterWithConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
    //                             consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc"
    //                                redirectUri:@"http://www.sharesdk.cn"];
}

@end
