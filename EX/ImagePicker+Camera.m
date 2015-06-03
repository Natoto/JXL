//
//  QBImagePickerController+Camera.m
//  EditImageDemo
//
//  Created by 星盛 on 15/4/8.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "ImagePicker+Camera.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "VPImageCropperViewController.h"
#import "UIImage+HBExtension.h"

@implementation UIViewController(Camera)

#define KEY_OBJECT_DISMISSBLOCKER @"QBImagePickerController.Camera"
#define KEY_methodName @"delegate"
static char OperationKey;

-(void)setQBImagePickerControllerCameraDelegate:(id)delegate
{
    objc_setAssociatedObject(self, &OperationKey,delegate, OBJC_ASSOCIATION_RETAIN);
}

-(id)getQBImagePickerControllerCameraDelegate
{
    return objc_getAssociatedObject(self, &OperationKey);
}

//-(void)presentAblumViewControllerWithAnimated:(BOOL)flag completion:(void (^)(void))completion
//{
//    QBImagePickerController *imagePickerController ;
//    
//    imagePickerController = [[QBImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.groupTypes = @[  @(ALAssetsGroupSavedPhotos),
//                                           @(ALAssetsGroupPhotoStream),                                             @(ALAssetsGroupAlbum)                                             ];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
//    [self presentViewController:navigationController animated:flag completion:completion];
//}


//#pragma mark - SCCaputer delegate
//
//-(void)presentSCCaptureControllerWithAnimated:(BOOL)flag completion:(void (^)(void))completion
//{
//    SCNavigationController *nav = [[SCNavigationController alloc] init];
//    nav.scNaigationDelegate = self;
//    [nav showCameraWithParentController:self];
//    
//}
//
//#pragma mark SCNavigationController delegate
//
//- (void)didTakePicture:(SCNavigationController *)navigationController image:(UIImage *)image {
//    
//    [navigationController  dismissViewControllerAnimated:YES completion:nil];
//    
//    id delegate = [self getQBImagePickerControllerCameraDelegate];
//    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:sccaptureCameraDidFinishPickingMediaWithImage:)])
//    {
//        [delegate hb_imagePickerController:self sccaptureCameraDidFinishPickingMediaWithImage:image];
//    }
//}

//
//-(void)SCNavigationController:(SCNavigationController *)navigatonController gotoAblum:(id)sender
//{
//    [self  pushAblumViewController];
//}

//#pragma mark - QBImagePickerControllerDelegate
//
//-(void)pushAblumViewController
//{
//    QBImagePickerController *imagePickerController ;
//    
//    imagePickerController = [[QBImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.groupTypes = @[  @(ALAssetsGroupSavedPhotos),
//                                           @(ALAssetsGroupPhotoStream),                                             @(ALAssetsGroupAlbum)                                             ];
//    [self.navigationController pushViewController:imagePickerController animated:YES];
//}
//
//- (void)dismissImagePickerController
//{
//    if (self.presentedViewController) {
//        [self dismissViewControllerAnimated:NO completion:NULL];
//    } else {
//        [self.navigationController popToViewController:self animated:NO];
//        //popToViewController:self animated:YES];
//    }
//}
//
//- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
//{
//    NSLog(@"*** qb_imagePickerController:didSelectAsset:");
//    NSLog(@"%@", asset);
//    
//    [self dismissImagePickerController];
//    id delegate = [self getQBImagePickerControllerCameraDelegate];
//    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:didSelectAsset:)]) {
//        [delegate hb_imagePickerController:imagePickerController didSelectAsset:asset];
//    }
//    //处理图片
//    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:didSelectImage:)]) {
//        UIImage * image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
//        image = [image fixOrientation];
//        [delegate hb_imagePickerController:imagePickerController didSelectImage:image];
//    }
//}
//
//- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
//{
//    NSLog(@"*** qb_imagePickerController:didSelectAssets:");
//    NSLog(@"%@", assets);
//    
//    [self dismissImagePickerController];
//    
//    id delegate = [self getQBImagePickerControllerCameraDelegate];
//    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:didSelectAssets:)]) {
//        [delegate hb_imagePickerController:imagePickerController didSelectAssets:assets];
//    }
//}
//
//- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
//{
//    NSLog(@"*** qb_imagePickerControllerDidCancel:");
//    
//    [self dismissImagePickerController];
//    id delegate = [self getQBImagePickerControllerCameraDelegate];
//    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerControllerDidCancel:)]) {
//        [delegate hb_imagePickerControllerDidCancel:imagePickerController];
//    }
//}
#pragma mark - 编辑相关
-(BOOL)imageCropperAutoLoadsubview:(VPImageCropperViewController *)cropperViewController
{
    return YES;
}

-(void)pushVPImageCropperViewControllerWithImage:(UIImage *)image
{
    CGFloat LEFT = 10;
    CGFloat WIDTH = [UIScreen mainScreen].bounds.size.width - 20;
    VPImageCropperViewController * ctr = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(LEFT, 100, WIDTH,WIDTH) limitScaleRatio:3];
    ctr.cropdelegate = self;
    ctr.title = @"编辑";
    [self.navigationController pushViewController:ctr animated:YES];
}


- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    id delegate = [self getQBImagePickerControllerCameraDelegate];
    if (delegate && [delegate respondsToSelector:@selector(hb_imageCropperDidCancel:)])
    {
        [delegate hb_imageCropperDidCancel:cropperViewController];
    }
}

-(void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    [self.navigationController popViewControllerAnimated:YES];
    id delegate = [self getQBImagePickerControllerCameraDelegate];
    if (delegate && [delegate respondsToSelector:@selector(hb_imageCropperViewController:didFinished:)])
    {
        [delegate hb_imageCropperViewController:cropperViewController didFinished:editedImage];
    }
}




#pragma mark - 相机相关

-(void)presentCameraViewControllerWithAnimated: (BOOL)flag completion:(void (^)(void))completion
{
    UIImagePickerController *m_imagePicker = [[UIImagePickerController alloc] init];
    [m_imagePicker setDelegate:self];
    [m_imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [m_imagePicker setAllowsEditing:YES];
    [self presentViewController:m_imagePicker animated:flag completion:completion];
}

static NSDictionary * infoDic;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]){
            infoDic =[NSDictionary dictionaryWithDictionary:info];
            [self dismissViewControllerAnimated:YES completion:^{
                infoDic = [NSDictionary dictionaryWithDictionary:info];
                MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
                HUD.detailsLabelText = @"处理中...";
                [HUD showWhileExecuting:@selector(handleCamera:) onTarget:self withObject:info animated:YES];
            }];
        }
    }
}

-(void)handleCamera:(NSDictionary *)info
{
    UIImage * image = [self handleCanmearInfo:info];
    id delegate = [self getQBImagePickerControllerCameraDelegate];
    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:cameraDidFinishPickingMediaWithImage:)])
    {
        [delegate hb_imagePickerController:self cameraDidFinishPickingMediaWithImage:image];
    }
    [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
    
}
-(UIImage *)handleCanmearInfo:(NSDictionary *)info
{
    NSData *data;
    //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
    
    NSValue *cropRectValue =  [info objectForKey:UIImagePickerControllerCropRect];
    CGRect cropRect = cropRectValue.CGRectValue;
    UIImage *EditedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //图片压缩，因为原图都是很大的，不必要传原图
    float scalerat = 0.5;
    UIImage *scaleImage  = [self scaleImage:EditedImage toScale:scalerat];
    //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
    
    NSString *fileName = @"1609";//[NSString stringWithFormat:@"%@.jpg",[[NSDate date] stringWithDateFormat:@"yyyy_MM_dd_HH_MM_SS"]];
    if (UIImagePNGRepresentation(scaleImage) == nil) {
        //将图片转换为JPG格式的二进制数据
        data = UIImageJPEGRepresentation(scaleImage, scalerat);
        fileName = [NSString stringWithFormat:@"ios_dz%dp_%@.jpg",2,@"ddd"];
    } else {
        //将图片转换为PNG格式的二进制数据
        data = UIImagePNGRepresentation(scaleImage);
        fileName = [NSString stringWithFormat:@"ios_dz%dp_%@.png",2,@"ddd"];
    } //        //将二进制数据生成UIImage
    
    UIImage *image = [UIImage imageWithData:data];
    return image;
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
