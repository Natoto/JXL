//
//  GuidancePage1ViewController.m
//  JXL
//
//  Created by BooB on 15/5/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "GuidancePage1ViewController.h"
#import "UIViewAdditions.h"
@interface GuidancePage1ViewController ()
@property (strong, nonatomic)  UIImageView *image1;
@property (strong, nonatomic)  UIImageView *image2;
@property (strong, nonatomic)  UIImageView *image3;

@end

@implementation GuidancePage1ViewController


-(CGFloat)heightOfWidth:(CGFloat)width
{
   return  width*(568./320.);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat imgwidth = 150;
    
    self.image1.size = CGSizeMake(imgwidth, [self heightOfWidth:imgwidth]);
    self.image2.size = CGSizeMake(imgwidth, [self heightOfWidth:imgwidth]);
    self.image3.size = CGSizeMake(imgwidth, [self heightOfWidth:imgwidth]);
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1 animations:^{
        self.image3.center = CGPointMake(UISCREEN_WIDTH/2, self.view.height/2 - 50);
        self.image1.center = CGPointMake((UISCREEN_WIDTH)/2 + 30, self.image3.centerY - 40);
        self.image2.center = CGPointMake(UISCREEN_WIDTH/2 - 30, self.image3.centerY - 20);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImageView *)image3
{
    if (!_image3) {
        _image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome_1_03"]];
        [self.view addSubview:_image3];
    }
    return _image3;
}


-(UIImageView *)image2
{
    if (!_image2) {
        _image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome_1_02"]];
        [self.view addSubview:_image2];
    }
    return _image2;
}



-(UIImageView *)image1
{
    if (!_image1) {
        _image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome_1_01"]];
        [self.view addSubview:_image1];
    }
    return _image1;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
