//
//  D1_OpinionReportViewController.m
//  JXL
//
//  Created by 跑酷 on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_OpinionReportViewController.h"
#import "SZTextView.h"
#import "UIView+Gesture.h"
#import "NSObject+HBHUD.h"
#import "jxl.h"
@interface D1_OpinionReportViewController ()
@property (weak, nonatomic) IBOutlet UIView *v_background;
@property (weak, nonatomic) IBOutlet SZTextView *txt_opinion;
@property (weak, nonatomic) IBOutlet UITextField *fld_conect;

@end

@implementation D1_OpinionReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationbar];
    [self showhbnavigationbarBackItem:YES];
    [self.navigationbar setTitle:@"意见反馈"];
    [self userDefaultBackground];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self.navigationbar setrightBarButtonItemWithTitle:@"提交" target:self selector:@selector(submit:)];
    
    self.txt_opinion.placeholder = @"请留下您的宝贵的意见和建议，我们将努力改进(不少于五个字)";
    self.txt_opinion.layer.borderColor = [UIColor grayColor].CGColor;
    self.txt_opinion.layer.borderWidth = 0.6;
    self.fld_conect.layer.borderWidth = 0.6;
    self.fld_conect.text = [GlobalData sharedInstance].m_login_info.m_phone;
    self.fld_conect.layer.borderColor = [UIColor grayColor].CGColor;
    self.v_background.backgroundColor = JXL_COLOR_THEME;
    // Do any additional setup after loading the view from its nib.
    [self.v_background addTapGesture_to_resignFirstResponder];
    
}

-(void)submit:(id)sender
{
    [[HTTPSEngine sharedInstance] fetch_feedbackWithmid:[GlobalData sharedInstance].m_mid phone:self.fld_conect.text content:self.txt_opinion.text response:^(NSString *responsejson) {
        if ([responsejson isEqualToString:@"1"]) {
            [self presentMessageTips:@"提交成功,谢谢您的反馈" dismisblock:^{
                [self backtoparent:nil];
            }];

        }
        else
        {
            [self presentMessageTips_:responsejson];
        }
    } errorHandler:^(NSError *error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
