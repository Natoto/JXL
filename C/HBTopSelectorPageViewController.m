//
//  TopSelectorPageViewController.m
//  JXL
//
//  Created by 星盛 on 15/4/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "HBTopSelectorPageViewController.h"
#import "TopSelectorScrollerView.h"
#import "UIViewController+BarButtonItem.h"
#import "HBNavigationbar.h"
#import "UIImage+Tint.h"
#import "BaseTableViewController.h"
@implementation HBTopSelectorPageViewController
@synthesize showBackItem = _showBackItem;
@synthesize navigationbar = _navigationbar;

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self pageViewController];
    [self topSelectorScrollerView];

    HBNavigationbar * navigationbar = [HBNavigationbar navigationbar];
    navigationbar.titleView.width = 280;
    navigationbar.titleView.centerX = self.view.width/2;
    
    navigationbar.titleView = self.topSelectorScrollerView; 
 
//    self.topSelectorScrollerView.width = 250;
    [navigationbar bringSubviewToFront:navigationbar.titleView];
    [self.view addSubview:navigationbar]; 
    self.navigationbar = navigationbar;    
}
 

-(void)setShowBackItem:(BOOL)showBackItem
{
    _showBackItem = showBackItem;
    //TODO:设置返回按钮
    if (_showBackItem) {
        [self.navigationbar setleftBarButtonItemWithImage:[[HBNavigationbar defaultbackImage] imageWithTintColor:[UIColor redColor]] target:self selector:@selector(backtoparent:)];
        self.navigationbar.leftItem .width = 50;
    }
    else
    {
        [self.navigationbar setleftBarButtonItemWithImage:nil target:self selector:nil];
         self.navigationbar.leftItem .width = 50;
    }
}


-(IBAction)backtoparent:(id)sender
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)reloadData
{
    [self.topSelectorScrollerView reloadData];
}

-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];

        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.view.frame = rect;
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        [self.view addSubview:self.pageViewController.view];
        [self.pageViewController didMoveToParentViewController:self];
        [self addChildViewController:self.pageViewController];
        
    }
    return _pageViewController;
}

-(NSArray *)controllerArray
{
    if (!_controllerArray) {
        
        BaseTableViewController * viewController1 = [[BaseTableViewController alloc] init];
        viewController1.view.backgroundColor = HBRandomColor;
        
        BaseTableViewController * viewController2 = [[BaseTableViewController alloc] init];
        viewController2.view.backgroundColor = HBRandomColor;
        
        BaseTableViewController * viewController3 = [[BaseTableViewController alloc] init];
        viewController3.view.backgroundColor = HBRandomColor;
        
        _controllerArray = [[NSArray alloc] initWithObjects:viewController1,viewController2, nil];
    }
    return _controllerArray;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //    return [self getController:viewController offset:-1];
    NSUInteger  currentIndex = [self indexOfViewController:viewController];
    if (currentIndex == 0 || (currentIndex == NSNotFound)) {
        return nil;
    }
    currentIndex -- ;
    return  [self.controllerArray objectAtIndex:currentIndex];;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger  currentIndex = [self indexOfViewController:viewController];
    if (currentIndex == NSNotFound) {
        return nil;
    }
    currentIndex ++;
    if (currentIndex == [self.controllerArray count]) {
        return nil;
    }
    return  [self.controllerArray objectAtIndex:currentIndex];;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController{
    return  [self.controllerArray indexOfObject:viewController];
}
static NSUInteger pendingViewControllerIndex;
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSLog(@"%s",__FUNCTION__);
    UIViewController * viewController = pendingViewControllers.firstObject;
    pendingViewControllerIndex = [self indexOfViewController:viewController];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"%s",__FUNCTION__);
    if (completed) {
        [self.topSelectorScrollerView selectItemView:(int)pendingViewControllerIndex];
//        BaseTableViewController * ctr = (BaseTableViewController *) [self.controllerArray  objectAtIndex:pendingViewControllerIndex];
//        [ctr refreshView];
    }
}

#pragma mark - TopSelectorScrollerView delegate

-(TopSelectorScrollerView *)topSelectorScrollerView
{
    if (!_topSelectorScrollerView) {
        _topSelectorScrollerView = [TopSelectorScrollerView defaultTopSelectorScrollerView];
        _topSelectorScrollerView.selectorDelegate = self;
        [_topSelectorScrollerView buildUI];
    }
    return _topSelectorScrollerView;
}

//+(TopSelectorScrollerView *)defaultTopSelectorScrollerView
//{
//    TopSelectorScrollerView *_topSelectorScrollerView = [[TopSelectorScrollerView alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
//    _topSelectorScrollerView.showsHorizontalScrollIndicator = NO;
//    _topSelectorScrollerView.tabItemNormalColor = KT_UIColorWithRGB(97, 100, 113);// KT_HEXCOLOR(0x868686);
//    _topSelectorScrollerView.tabItemSelectedColor =KT_UIColorWithRGB(240, 40, 50);// KT_HEXCOLOR(0xbb0b15);
//    //        _topSelectorScrollerView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]\
//    stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
////    [_topSelectorScrollerView buildUI];
//    return _topSelectorScrollerView;
//}
-(NSArray *)tabsOfScrollView:(TopSelectorScrollerView *)scrollerView
{
    NSMutableArray * titles = [NSMutableArray arrayWithCapacity:0];
    [self.controllerArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController * ctr = [self.controllerArray objectAtIndex:idx];
        [titles addObject:ctr.title];
    }];
    return titles;
}

-(CGSize)slideTabTextSize:(TopSelectorScrollerView *)scrollerView
{
    return CGSizeMake(200/3, 40);
} 
-(void)topSelectorScrollerView:(TopSelectorScrollerView *)view didselectTab:(NSUInteger)tabtag
{
    NSLog(@"%lu",(unsigned long)tabtag);
    if (tabtag < pendingViewControllerIndex) {
     [self.pageViewController setViewControllers:@[[self.controllerArray objectAtIndex:tabtag]] direction:(UIPageViewControllerNavigationDirectionReverse) animated:YES completion:nil];
    }
    else
     [self.pageViewController setViewControllers:@[[self.controllerArray objectAtIndex:tabtag]] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];
    [self selectViewControllerWithIndex:tabtag];
}

-(void)selectViewControllerWithIndex:(NSInteger)index
{
}
@end
