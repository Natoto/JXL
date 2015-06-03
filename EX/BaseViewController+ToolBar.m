//
//  BaseViewController+ToolBar.m
//  JXL
//
//  Created by BooB on 15/5/19.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseViewController+ToolBar.h"
#import "ToolsFunc.h"

@implementation BaseViewController(ToolBar)


-(NSMutableArray *)addToolBarWithFrames:(NSArray *)frames titles:(NSArray *)titles images:(NSArray *)images selectors:(NSArray *)selectors
{
    if (frames.count != 3) {
#warning 传入的数据必须为 左中右三个按钮 返回也是三个按钮
        return nil;
    }
    NSMutableArray * buttons = [[NSMutableArray alloc] initWithCapacity:0];
    [self navigationtoolsbar];
    [self.navigationtoolsbar drawtoplinelayer];
    //    [self showhbnavigationbarBackItem:YES];
    
    [frames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSValue * rectvalue = [frames objectAtIndex:idx];
        UIButton * writebtn = [self createButtons:rectvalue.CGRectValue imge:[images objectAtIndex:idx] title:[titles objectAtIndex:idx] slectror:NSSelectorFromString([selectors objectAtIndex:idx])];
        [self setButtonLayer:writebtn];
        [buttons addObject:writebtn];
    }];
    
    UIControl * Leftview = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [Leftview addSubview:buttons[0]];
    self.navigationtoolsbar.leftItem = Leftview;
    
    UIView * centerview = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 200, 44)];
    [centerview addSubview:buttons[1]];
    [self.navigationtoolsbar setTitleView:centerview];
    self.navigationtoolsbar.rightItem = buttons[2];
    return buttons;
}

-(void)setButtonLayer:(UIButton *)button
{
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth= 0.6;
    button.showsTouchWhenHighlighted = YES;
}

-(UIButton *)createButtons:(CGRect)frame imge:(NSString *)imagename title:(NSString *)title slectror:(SEL)selectror
{
    UIButton * button = [ToolsFunc CreateButtonWithFrame:frame
                                                  andTxt:title
                                              andTxtSize:12
                                                andImage:[UIImage imageNamed:imagename]
                                             andTXTColor:[UIColor grayColor]
                                                  target:self
                                                selector:selectror
                                               superview:nil
                                                     tag:10];
    return button;
}

@end
