//
//  A0_FirstPageViewController.h
//  JXL
//
//  Created by BooB on 15-4-14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseViewController.h"
@class A0_FirstPageViewController;
@protocol A0_FirstPageViewControllerDelegate

@optional

-(void)A0_FirstPageViewController:(A0_FirstPageViewController *)A0_FirstPageViewController collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

-(void)A0_FirstPageViewController:(A0_FirstPageViewController *)A0_FirstPageViewController  didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;

-(void)A0_FirstPageViewController:(A0_FirstPageViewController *)A0_FirstPageViewController pushviewcontroller:(UIViewController *)viewcontroller;

-(void)A0_FirstPageViewController:(A0_FirstPageViewController *)A0_FirstPageViewController left:(BOOL)left navigationItem:(id)sender;

@end;

@interface A0_FirstPageViewController : BaseViewController
@property(nonatomic,assign) NSObject<A0_FirstPageViewControllerDelegate> * delegate;

@end
