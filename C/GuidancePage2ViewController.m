//
//  GuidancePage2ViewController.m
//  JXL
//
//  Created by BooB on 15/5/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "GuidancePage2ViewController.h"
#import "UIViewAdditions.h"
#import "ToolsFunc.h"
#import "JXL_Define.h"
@interface GuidancePage2ViewController ()
@property(nonatomic,retain) NSMutableArray * buttons;

@property(nonatomic,retain) NSArray     * buttonsFrames;
@property(nonatomic,retain) NSArray     * firstButtonsFrames;
@end

@implementation GuidancePage2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KT_UIColorWithRGB(109, 193, 242);
    NSArray * items = @[@"学习",@"寻创业伙伴",@"找项目",@"活动",@"融资",@"导师"];
    NSArray * colors = @[KT_UIColorWithRGB(70, 201, 19),
                         KT_UIColorWithRGB(141, 137, 242),
                         KT_UIColorWithRGB(241, 147, 40),
                         KT_UIColorWithRGB(37, 96, 185),
                         KT_UIColorWithRGB(185, 62, 215),
                         KT_UIColorWithRGB(123, 137, 255)];
    self.buttons = [NSMutableArray arrayWithCapacity:0];
    [items enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        NSValue * rectvalue = [self.firstButtonsFrames objectAtIndex:idx];
        
        UIButton * button = [self createButtonWithFrame:rectvalue.CGRectValue title:title color:[colors objectAtIndex:idx]];
     
        [self.view addSubview:button];
        [self.buttons addObject:button];
    }];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{ 
}

-(void)selectCurrentView
{
    [UIView animateWithDuration:2 animations:^{
        [self.buttons enumerateObjectsUsingBlock:^(UIButton * button, NSUInteger idx, BOOL *stop) {
            NSValue *rectvalue = [self.buttonsFrames objectAtIndex:idx];
            button.frame = rectvalue.CGRectValue;
            KT_CORNER_PROFILE(button);
        }];
    }];
}

-(UIButton * )createButtonWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color
{
    UIButton * button = [ToolsFunc CreateButtonWithFrame:frame andTxt:title];
    button.backgroundColor = color;
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    KT_CORNER_PROFILE(button);
    return button;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#define  biggestwidth   150
#define  biggerwidth   (biggestwidth - 60)
#define  bigwidth   (biggerwidth - 20)
#define  smallwidth   (bigwidth - 10)

-(NSArray *)firstButtonsFrames
{
    if (!_firstButtonsFrames) {
        //找项目
        CGRect zxmrect = CGRectMake(0, UISCREEN_HEIGHT/2, smallwidth, smallwidth);
        //        zxmrect.origin = CGPointMake(self.view.width/2, self.view.height/2);
        //学习
        CGRect xxrect =  CGRectMake(0, 500, smallwidth, smallwidth);
        //需找创业伙伴
        CGRect xzxmrect = CGRectMake(0, 0, smallwidth, smallwidth);
        //活动
        CGRect hdrect = CGRectMake(UISCREEN_WIDTH, UISCREEN_HEIGHT, smallwidth, smallwidth);
        //融资
        CGRect rzrect = CGRectMake(UISCREEN_WIDTH, UISCREEN_HEIGHT, smallwidth, smallwidth);
        
        //导师
        CGRect dsrect =  CGRectMake(UISCREEN_WIDTH, UISCREEN_HEIGHT, smallwidth, smallwidth);
        //    NSValue * zhaoxiangmu = [NSValue valueWithCGRect:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
        _firstButtonsFrames = @[[NSValue valueWithCGRect:xxrect],
                                [NSValue valueWithCGRect:xzxmrect],
                                [NSValue valueWithCGRect:zxmrect],
                                [NSValue valueWithCGRect:hdrect],
                                [NSValue valueWithCGRect:rzrect],
                                [NSValue valueWithCGRect:dsrect],
                                ];
    }
    return _firstButtonsFrames;
}


-(NSArray *)buttonsFrames
{
    if (!_buttonsFrames) {
        //找项目
        CGRect zxmrect = CGRectMake(0, 0, biggestwidth, biggestwidth);
        zxmrect.origin = CGPointMake(UISCREEN_WIDTH/2 - biggestwidth/2, UISCREEN_HEIGHT/2 - biggestwidth/2 - 20);
        //学习
        CGRect xxrect =  CGRectMake(zxmrect.origin.x - smallwidth , zxmrect.origin.y - smallwidth/2, smallwidth, smallwidth);
        //需找创业伙伴
        CGRect xzxmrect = CGRectMake(zxmrect.origin.x - bigwidth, zxmrect.origin.y + zxmrect.size.height, bigwidth, bigwidth);
        //活动
        CGRect hdrect = CGRectMake(zxmrect.origin.x + biggestwidth, zxmrect.origin.y - 10 , bigwidth, bigwidth);
        //融资
        CGRect rzrect = CGRectMake(zxmrect.origin.x + biggestwidth - 10, hdrect.origin.y + bigwidth , biggerwidth, biggerwidth);
        
        //导师
        CGRect dsrect =  CGRectMake(zxmrect.origin.x + biggestwidth - 10, rzrect.origin.y + biggerwidth, bigwidth, bigwidth);
        _buttonsFrames = @[[NSValue valueWithCGRect:xxrect],
                           [NSValue valueWithCGRect:xzxmrect],
                           [NSValue valueWithCGRect:zxmrect],
                           [NSValue valueWithCGRect:hdrect],
                           [NSValue valueWithCGRect:rzrect],
                           [NSValue valueWithCGRect:dsrect],
                           ];
    }
    return _buttonsFrames;
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
