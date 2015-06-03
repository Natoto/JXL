//
//  QBImagePickerController+Camera.h
//  EditImageDemo
//
//  Created by 星盛 on 15/4/8.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

//#import "QBImagePickerController.h"
#import "VPImageCropperViewController.h"
//#import "SCNavigationController.h"

#import <AVFoundation/AVFoundation.h>

@protocol QBImagePickerControllerCameraDelegate;

@interface UIViewController(Camera)<UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate>

/**
 * 首先要设置代理模式 第一步
 */
-(void)setQBImagePickerControllerCameraDelegate:(id)delegate;

-(void)presentCameraViewControllerWithAnimated: (BOOL)flag completion:(void (^)(void))completion;

//-(void)presentSCCaptureControllerWithAnimated: (BOOL)flag completion:(void (^)(void))completion;

-(void)pushVPImageCropperViewControllerWithImage:(UIImage *)image;



@end




@protocol QBImagePickerControllerCameraDelegate <NSObject>

@optional

/**
 * 从相册挑选一张图片
 */
// UIImage * image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];

//- (void)hb_imagePickerController:(UIViewController *)imagePickerController didSelectAsset:(ALAsset *)asset;
//
//- (void)hb_imagePickerController:(UIViewController *)imagePickerController didSelectImage:(UIImage *)image;
///**
// * 从相册挑选图片 一系列的图片
// */
//- (void)hb_imagePickerController:(UIViewController *)imagePickerController didSelectAssets:(NSArray *)assets;

/**
 * 从相册挑选图片取消
 */
- (void)hb_imagePickerControllerDidCancel:(UIViewController *)imagePickerController;
/**
 * 从相机选择图片
 */
-(void)hb_imagePickerController:(UIViewController *)viewController cameraDidFinishPickingMediaWithImage:(UIImage *)image;

///**
// * 从自定义相机选择图片
// */
//-(void)hb_imagePickerController:(UIViewController *)viewController sccaptureCameraDidFinishPickingMediaWithImage:(UIImage *)image;

/**
 * 编辑取消
 */
-(void)hb_imageCropperDidCancel:(UIViewController *)cropperViewController;
/**
 * 编辑完成结果
 */
-(void)hb_imageCropperViewController:(UIViewController *)cropperViewController didFinished:(UIImage *)editedImage;

@end
