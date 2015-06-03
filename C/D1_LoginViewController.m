//
//  D1_LoginViewController.m
//  JXL
//
//  Created by BooB on 15-5-2.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_LoginViewController.h"
#import "JXLCommon.h"
#import "jxl.h"
#import "D1_RegisterView1Controller.h"
#import "HTTPSEngine.h"
#import "GlobalData.h"

@interface D1_LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt_acount;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_acount;
@property (weak, nonatomic) IBOutlet UILabel *lbl_secret;

@property (strong,nonatomic) UIView * logbtnview;
@property (strong,nonatomic) UIButton * forgetbtn;
@property (strong,nonatomic) UIButton * fastregistbtn;

@end

@implementation D1_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationbar setTitle:@"登录"];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
    [self showhbnavigationbarBackItem:YES];
    
    self.view.backgroundColor = JXL_COLOR_THEME;
    [self.view addSubview:self.logbtnview];
    [self.view addSubview:self.forgetbtn];
    [self.view addSubview:self.fastregistbtn];
    [self configViews];
    [self observeTapgestureWithSuperView:self.view target:self sel:@selector(viewTap:)];
    
    NSString * psd = [GlobalData sharedInstance].m_password;
    NSString * phone = [GlobalData sharedInstance].m_mobile;
    NSString * email = [GlobalData sharedInstance].m_email;
    if (email) {
        self.txt_acount.text = email;
    }
    if (phone) {
        self.txt_acount.text = phone;
    }
    if (psd) {
        self.txt_password.text = psd;
    }
    
    self.txt_acount.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txt_password.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lbl_title.textColor = KT_UIColorWithRGB(93, 93, 93);
    self.lbl_acount.textColor = KT_UIColorWithRGB(98, 98, 98);
    self.lbl_secret.textColor = KT_UIColorWithRGB(98, 98, 98);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.statusBarStyleDefault = NO;
}
-(IBAction)viewTap:(id)sender
{
    [self.txt_acount resignFirstResponder];
    [self.txt_password resignFirstResponder];
}
-(IBAction)forgetsecret:(id)sender
{
    D1_RegisterView1Controller * ctr = [[D1_RegisterView1Controller alloc] init];
    [ctr.navigationbar setTitle:@"忘记密码"];
    [self.navigationController pushViewController:ctr animated:YES];
    
}
-(IBAction)login:(id)sender
{
    [self viewTap:nil];
    NSString * phone = self.txt_acount.text.trim;
    NSString * psw = self.txt_password.text.trim;
    NSString * email = nil;
    
    if (!phone.length) {
        [self presentMessageTips_:@"请输入账号"];
        return;
    }
    if (!psw.length) {
        [self presentMessageTips_:@"请输入密码"];
        return;
    }
    if ([phone isEmail]) {
        email = phone;
        phone = nil;
    }
    [self presentLoadingTips:@"登录中..."];
    [[HTTPSEngine sharedInstance] fetch_loginMemberWithPhone:phone
                                                       email:email
                                                    password:psw
                                                    response:^(NSDictionary *Dictionary) {
                                                        [self dismissAllTips];
                                                        if ([Dictionary isErrorObject]) {
                                                            APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
                                                            [self presentMessageTips_:error.m_errorMsg];
                                                        }
                                                        else
                                                        {
                                                            [GlobalData sharedInstance].m_mobile = phone;
                                                            [GlobalData sharedInstance].m_password = psw;
                                                            [GlobalData sharedInstance].m_email = email;
                                                            
                                                            RES_Login_Info * loginfo = [LoginModel encodeDiction:Dictionary];
                                                            if (loginfo.m_headpic.length) {
                                                                loginfo.m_headpic = [NSString stringWithFormat:@"%@",loginfo.m_headpic];
                                                            }
                                                            [GlobalData sharedInstance].m_login_info = loginfo;
                                                            
                                                                NSLog(@"%@",Dictionary);
                                                            [GlobalData sharedInstance].m_mid = [GlobalData sharedInstance].m_login_info.m_mid;
                                                            
                                                            [self presentMessageTips_:@"登陆成功" dismisblock:^{
//
                                                                SEND_HBSIGNAL(NSStringFromClass([D1_LoginViewController class]), @"login", [GlobalData sharedInstance].m_res_perfectmember)
                                                                [self backtoparent:nil];
                                                            }];
                                                        }
                                                    } errorHandler:^(NSError *error) {
                                                        
                                                    }];
}

-(IBAction)fastregist:(id)sender
{
    D1_RegisterView1Controller * ctr = [[D1_RegisterView1Controller alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)configViews
{
    self.bgview.layer.borderColor = [UIColor whiteColor].CGColor;
    self.bgview.layer.borderWidth = 0.6;
    self.bgview.layer.cornerRadius = 5;
}


-(UIButton *)fastregistbtn
{
    if (!_fastregistbtn) {
        _fastregistbtn = [ToolsFunc CreateButtonWithFrame:CGRectMake(self.logbtnview.width - 80, self.logbtnview.bottom + 2, 80, 20)
                                                   andTxt:@"快速注册"
                                               andTxtSize:12
                                                 andImage:nil
                                              andTXTColor:[UIColor blackColor]
                                                   target:self
                                                 selector:@selector(fastregist:)
                                                superview:self.view tag:11];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"快速注册"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [_fastregistbtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _fastregistbtn;
}
-(UIButton *)forgetbtn
{
    if (!_forgetbtn) {
        _forgetbtn =  [ToolsFunc CreateButtonWithFrame:CGRectMake(0, self.logbtnview.bottom + 2, 80, 20)
                                                andTxt:@"忘记密码"
                                            andTxtSize:12
                                              andImage:nil
                                           andTXTColor:[UIColor blackColor]
                                                target:self
                                              selector:@selector(forgetsecret:)
                                             superview:self.view tag:12];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"忘记密码"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [_forgetbtn setAttributedTitle:str forState:UIControlStateNormal];
        
    }
    return _forgetbtn;
}

-(UIView *)logbtnview
{
    if (!_logbtnview) {
       UIView * logview = [JXL_Common BigButtonview:CGRectMake(0, self.bgview.bottom + 10, SCREEN_WIDTH, 70) btnframe:CGRectMake(10, 20, SCREEN_WIDTH - 20, 40)  title:@"立即登录" target:self sel:@selector(login:)];
        [self.view addSubview:logview];
        _logbtnview = logview;
    }
    return _logbtnview;
}
@end
