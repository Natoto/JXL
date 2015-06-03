//
//  WebViewController.h
//  JXL
//
//  Created by 跑酷 on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController 

- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURLString:(NSString *)urlString;

/* Get/set the current URL being displayed. (Will automatically start loading) */
@property (nonatomic,strong)    NSURL *url;

/* Show the loading progress bar (default YES) */
@property (nonatomic,assign)    BOOL showLoadingBar;

/* Show the URL while loading the page, i.e. before the page's <title> tag is available (default YES) */
@property (nonatomic,assign)    BOOL showUrlWhileLoading;

/* Tint colour for the loading progress bar. Default colour is iOS system blue. */
@property (nonatomic,copy)      UIColor *loadingBarTintColor;

/* Show all of the navigation/action buttons (ON by default) */
@property (nonatomic,assign)    BOOL navigationButtonsHidden;

/* Show the 'Action' button instead of the stop/refresh button (YES by default)*/
@property (nonatomic,assign)    BOOL showActionButton;

/* Disable the contextual popup that appears if the user taps and holds on a link. */
@property (nonatomic,assign)    BOOL disableContextualPopupMenu;

/* Hide the gray/linin background and all shadows and use the same colour as the current page */
@property (nonatomic,assign)    BOOL hideWebViewBoundaries;

/* When being presented as modal, this optional block can be performed after the users dismisses the controller. */
@property (nonatomic,copy)      void (^modalCompletionHandler)(void);

/* On iOS 6 or below, this can be used to override the default fill color of the navigation button icons */
@property (nonatomic,strong)    UIColor *buttonTintColor UI_APPEARANCE_SELECTOR;

/* On iOS 6 or below, this overrides the default opacity level of the bevel around the navigation buttons */
@property (nonatomic,assign)    CGFloat buttonBevelOpacity UI_APPEARANCE_SELECTOR;

@end
