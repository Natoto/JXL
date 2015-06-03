//
//  UIViewController+QBImagePicker.m
//  pengmi
//
//  Created by 跑酷 on 15/4/28.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "UIViewController+QBImagePicker.h"
#import <objc/runtime.h>
//#import "UIImage+Resize.h"
#import "UIImage+HBExtension.h"
@implementation UIViewController(QBImagePicker)

static char OperationKey;

-(void)setUIViewControllerQBImagePickerDelegate:(id)delegate
{
    objc_setAssociatedObject(self, &OperationKey,delegate, OBJC_ASSOCIATION_RETAIN);
}


-(id)getUIViewControllerQBImagePickerDelegate
{
    return objc_getAssociatedObject(self, &OperationKey);
}

-(void)presentAblumViewControllerWithAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    QBImagePickerController *imagePickerController ;
    
    imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = NO;
    imagePickerController.groupTypes = @[  @(ALAssetsGroupSavedPhotos),
                                           @(ALAssetsGroupPhotoStream),                                             @(ALAssetsGroupAlbum)                                             ];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
   
    
    [navigationController.navigationBar setBackgroundImage:[UIImage buttonImageFromColor:[UIColor blackColor] frame:CGRectMake(0, 0, self.view.bounds.size.width, 65)] forBarMetrics:UIBarMetricsDefault];
    [self presentViewController:navigationController animated:flag completion:completion];
    
//     navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"拍照" style:UIBarButtonSystemItemCamera target:self action:@selector(gotocameral:)];
    
    UIBarButtonItem *doneButton =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(gotocameral:)];
    [self.navigationItem setRightBarButtonItem:doneButton animated:NO];
    
}

-(void)gotocameral:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//
//-(void)SCNavigationController:(SCNavigationController *)navigatonController gotoAblum:(id)sender
//{
//    [self  pushAblumViewController];
//}

#pragma mark - QBImagePickerControllerDelegate
/**
 * 弹出qbimagepicker相册
 */
-(void)pushAblumViewController
{
    QBImagePickerController *imagePickerController ;
    
    imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.groupTypes = @[  @(ALAssetsGroupSavedPhotos),
                                           @(ALAssetsGroupPhotoStream),                                             @(ALAssetsGroupAlbum)                                             ];
    
     [self.navigationController pushViewController:imagePickerController animated:YES];
}

-(void)pushAblumViewController:(UINavigationController *)parnavigation
{
    QBImagePickerController *imagePickerController ;
    
    imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.groupTypes = @[  @(ALAssetsGroupSavedPhotos),
                                           @(ALAssetsGroupPhotoStream),                                             @(ALAssetsGroupAlbum)                                             ];
    parnavigation.navigationBarHidden = NO;
    [parnavigation pushViewController:imagePickerController animated:YES];
}


- (void)dismissImagePickerController
{
    if ([[self class] isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController * navi = (UINavigationController *)self;
        [navi popViewControllerAnimated:YES];
        return;
    }
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:NO completion:NULL];
    } else {
        [self.navigationController popToViewController:self animated:NO];
        //popToViewController:self animated:YES];
    }
}



- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    NSLog(@"*** qb_imagePickerController:didSelectAsset:");
    NSLog(@"%@", asset);
    
    if (![[self class] isSubclassOfClass:[UINavigationController class]]) {
        [self dismissImagePickerController];
    }
    id delegate = [self getUIViewControllerQBImagePickerDelegate];
    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:didSelectAsset:)]) {
        [delegate hb_imagePickerController:imagePickerController didSelectAsset:asset];
    }
    //处理图片
    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:didSelectImage:)]) {
        ALAssetRepresentation *defaultRepresentation = [asset defaultRepresentation];
        CGImageRef fullResolutionImage = [defaultRepresentation fullResolutionImage];
        
        // Return if the user is trying to upload an image which has already been uploaded
        CGFloat scale = [defaultRepresentation scale];
        ALAssetOrientation orientation= [defaultRepresentation orientation];
        
        UIImage *image = [UIImage imageWithCGImage:fullResolutionImage scale:scale orientation:(UIImageOrientation)orientation];
        
//        UIImage * image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
//        image = [image fixOrientation];
        [delegate hb_imagePickerController:imagePickerController didSelectImage:image];
    }
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    NSLog(@"*** qb_imagePickerController:didSelectAssets:");
    NSLog(@"%@", assets);
    
    [self dismissImagePickerController];
    
    id delegate = [self getUIViewControllerQBImagePickerDelegate];
    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerController:didSelectAssets:)]) {
        [delegate hb_imagePickerController:imagePickerController didSelectAssets:assets];
    }
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"*** qb_imagePickerControllerDidCancel:");
    
    [self dismissImagePickerController];
    id delegate = [self getUIViewControllerQBImagePickerDelegate];
    if (delegate && [delegate respondsToSelector:@selector(hb_imagePickerControllerDidCancel:)]) {
        [delegate hb_imagePickerControllerDidCancel:imagePickerController];
    }
}

@end
