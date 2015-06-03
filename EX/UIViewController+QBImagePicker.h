//
//  UIViewController+QBImagePicker.h
//  pengmi
//
//  Created by 跑酷 on 15/4/28.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "QBImagePickerController.h"
#import <UIKit/UIKit.h>

@interface UIViewController(QBImagePicker)<QBImagePickerControllerDelegate>

/**
 * 首先要设置代理模式 第一步
 */
-(void)setUIViewControllerQBImagePickerDelegate:(id)delegate;
-(void)presentAblumViewControllerWithAnimated: (BOOL)flag completion:(void (^)(void))completion;
-(void)pushAblumViewController;
-(void)pushAblumViewController:(UINavigationController *)parnavigation;
@end



@protocol UIViewControllerQBImagePickerDelegate <NSObject>

@optional

/**
 * 从相册挑选一张图片
 */
// UIImage * image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];

- (void)hb_imagePickerController:(UIViewController *)imagePickerController didSelectAsset:(ALAsset *)asset;

- (void)hb_imagePickerController:(UIViewController *)imagePickerController didSelectImage:(UIImage *)image;

/**
 * 从相册挑选图片 一系列的图片
 */
- (void)hb_imagePickerController:(UIViewController *)imagePickerController didSelectAssets:(NSArray *)assets;

/**
 * 从相册挑选图片取消
 */
- (void)hb_imagePickerControllerDidCancel:(UIViewController *)imagePickerController;


@end

