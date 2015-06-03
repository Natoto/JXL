//
//  B1_ANewsViewController.m
//  JXL
//
//  Created by BooB on 15/5/4.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "B1_ANewsViewController.h"
#import "NIAttributedLabel.h"
#import "HTTPSEngine.h"
#import "jxl.h" 
#import "B2_NewsCommentViewController.h"
#import "ReplyInputAccessoryView.h"
#import "D1_LoginViewController.h"
#import "RootViewController.h"
#import "ShareModel.h"

@interface B1_ANewsViewController ()<UIWebViewDelegate>
@property(nonatomic,strong) NIAttributedLabel * lbl_title;
@property(nonatomic,strong) NIAttributedLabel * lbl_time;
@property(nonatomic,strong) NIAttributedLabel * lbl_content;
@property(nonatomic,strong) UIScrollView      * scrollview;
@property(nonatomic,strong) UIImageView       * img_content;
@property(nonatomic,retain) UIButton          * btn_comment;
@property(nonatomic,retain) UIButton          * btn_reply;
@property(nonatomic,retain) UIWebView         * webView;
@property(nonatomic,retain) ReplyInputAccessoryView  * view_input;
@property(nonatomic,retain) UIView                   * maskview;
@end

@implementation B1_ANewsViewController

#define FONT_SIZE_LABEL     14
#define WIDTH_PROFILE       35.0
#define WIDTH_DIANZAN       30.0
#define X_TO_RIGHT          10.0
#define X_TO_LEFT           10.0
#define Y_TO_TOP            10.0
#define HEIGHT_NAME_TIME    25.0
#define HEIGHT_YINYONG      30.0
#define HEIGHT_PROFILE      WIDTH_PROFILE
#define Y_TO_BOTTOM         5.0

#define WIDTH_CONTENT (CGRectGetWidth([UIScreen mainScreen].bounds) - WIDTH_PROFILE - WIDTH_DIANZAN - X_TO_RIGHT - 2* X_TO_LEFT)


-(id)initWithNewsId:(NSString *)news_id mid:(NSString *)mid
{
    self = [super init];
    if (self) {
        self.m_news_id = news_id;
        self.m_mid = mid;
    }
    return self;
}

-(void)addToolBar
{
    [self navigationtoolsbar];
    [self.navigationtoolsbar drawtoplinelayer];
    //    [self showhbnavigationbarBackItem:YES];
    
    UIView * centerview = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 200, 44)];
    
    UIButton * writebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [writebtn setImage:[UIImage imageNamed:@"item_write"] forState:UIControlStateNormal];
    [writebtn addTarget:self action:@selector(wirtecomment:) forControlEvents:UIControlEventTouchUpInside];
    writebtn.frame = CGRectMake(centerview.width - 50, 0, 44, 44);
    [centerview addSubview:writebtn];
    self.btn_reply = writebtn;

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * bgimg = [UIImage imageNamed:@"item_comment"];
    bgimg = [bgimg stretchableImageWithLeftCapWidth:bgimg.size.width/2 topCapHeight:bgimg.size.height/2];
    [button setBackgroundImage:bgimg forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
    [button setTitle:@"122" forState:UIControlStateNormal];
    button.frame = CGRectMake(writebtn.left - 40, 10, 30, 22);
    button.center = CGPointMake(writebtn.left - 60 , centerview.centerY);
    [button addTarget:self action:@selector(gotocomment:) forControlEvents:UIControlEventTouchUpInside];
    self.btn_comment = button;
    [centerview addSubview:button];
    
    
    [self.navigationtoolsbar setTitleView:centerview];
    self.navigationtoolsbar.height = 44;
    self.navigationtoolsbar.frame = CGRectMake(0, self.view.height - self.navigationtoolsbar.height, self.view.width, self.navigationtoolsbar.height);
    [self.navigationtoolsbar setBackgroundColor:KT_UIColorWithRGB(236, 236, 236)];
    [self.navigationtoolsbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"back_gray"] target:self selector:@selector(backtoparent:)];
    [self.navigationtoolsbar setrightBarButtonItemWithImage:[UIImage imageNamed:@"item_share"] target:self selector:@selector(share:)];
    self.navigationtoolsbar.rightItem.width = 50;
    self.navigationtoolsbar.rightItem.left = self.navigationtoolsbar.titleView.right;
    self.navigationtoolsbar.rightItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. 
    [self addToolBar];
    [self.view addSubview:self.webView];
//    [self scrollview];
//    [self.view addSubview:_scrollview];
//    [self lbl_title];
//    [self.scrollview addSubview:_lbl_title];
//    [self lbl_time];
//    [self.scrollview addSubview:_lbl_time];
//    [self img_content];
//    [self.scrollview addSubview:_img_content];
//    [self lbl_content];
//    [self.scrollview addSubview:_lbl_content];
    
    [self refreshView];
    ADDOBSERVER_KEYBOARD_HIDE_NOTIFY(self, @selector(keyboardwillhide:))
    ADDOBSERVER_KEYBOARD_SHOW_NOTIFY(self, @selector(keyboardwillshow:))
}
-(void)dealloc
{
    REMOVEOBSERVER_KEYBOARD_HIDE_NOTIFY(self)
    REMOVEOBSERVER_KEYBOARD_SHOW_NOTIFY(self)
}
-(void)refreshView
{
    [[HTTPSEngine sharedInstance] fetch_findNewsByIdWithID:self.m_news_id mid:self.m_mid response:^(NSDictionary *Dictionary) {
      
        if ([Dictionary isErrorObject]) {
            APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips_:error.m_errorMsg];
            return ;
        }
//        ANews * news = [FindNewsByIDModel encodeDiction:Dictionary];
         NSString * key = [NSString stringWithFormat:@"findNewsById%@",self.m_news_id];
        NSString * m_content = GET_OBJECT_OF_USERDEFAULT(key);
        [self.webView loadHTMLString:m_content baseURL:nil];
        
//        self.lbl_title.text = news.m_title;
//        [self loadImage:news.m_thumb];
//        self.lbl_time.text = [ToolsFunc datefromstring:[NSString stringWithFormat:@"%@",news.m_addtime]];
//        self.lbl_content.text = [NSString stringWithFormat:@"%@",news.m_content];
//        [self layoutSubViews];
        [self.btn_comment setTitle:self.m_newcomment forState:UIControlStateNormal];
    } errorHandler:^(NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.statusBarStyleDefault = YES;
    [super viewWillAppear:animated];
}
-(IBAction)gotocomment:(id)sender
{
    B2_NewsCommentViewController * ctr =[[B2_NewsCommentViewController alloc] init];
    ctr.m_cid = self.m_news_id;
    ctr.m_type = fetch_messge_type_news;
    [self.navigationController pushViewController:ctr animated:YES];
    
}
-(IBAction)wirtecomment:(id)sender
{
    if (![GlobalData sharedInstance].m_mid ) { 
        [[RootViewController sharedInstance] rootpresentLoginViewController];
        return;
    }
    
    [self.view_input becomeFirstResponder];
}
-(IBAction)share:(id)sender
{
//    [self presentMessageTips:@"分享"];
    if ([self.image isUrl]) {
        UIImageView * img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:self.image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [[ShareModel sharedInstance] openShareViewWithViewController:self content:self.title fontIndex:0 image:image];
        }];
    }
    else
    {
        [[ShareModel sharedInstance] openShareViewWithViewController:self content:self.title fontIndex:0 image:[UIImage imageNamed:@"logo"]];
    }

    
}
-(IBAction)backtoparent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadImage:(NSString *)imgurl
{
    if (!imgurl) {
        return;
    }
    [self.img_content sd_setImageWithURL:[NSURL URLWithString:imgurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}


-(IBAction)replyConfirm:(id)sender
{
    NSString * contentstr = self.view_input.content;
    NSLog(@"contentstr %@",contentstr);
    [self.view_input resignFirstResponder];
    
    
    [[HTTPSEngine sharedInstance] fetch_newscommentWithCid:self.m_news_id mid:[GlobalData sharedInstance].m_mid content:contentstr type:fetch_messge_type_news reply_id:nil reply_mid:nil response:^(NSDictionary *Dictionary) {
        if ([Dictionary isErrorObject]) {
            APIBaseObject * error =[APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips_:error.m_errorMsg];
        }
        else
        {
            self.view_input.content = @"";
            [self presentMessageTips_:@"回复成功"];
            [self refreshView];
        }
        NSLog(@"%@",Dictionary);
    } errorHandler:^(NSError *error) {
        
    }];
}

-(IBAction)replyCancel:(id)sender
{
    [self.view_input resignFirstResponder];
}

-(void)keyboardwillhide:(NSNotification *)notity
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.maskview removeFromSuperview];
        self.view_input.alpha = 0;
        self.view_input.frame = CGRectMake(0, self.view.height , self.view.width, 150);
        
    }];
}
-(void)keyboardwillshow:(NSNotification *)notify
{
    CGSize size = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view_input.alpha = 1;
        self.view_input.frame = CGRectMake(0, self.view.height - size.height - 150, self.view.width, 150);
        
        [self.view insertSubview:[self maskview] belowSubview:self.view_input];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)layoutSubViews
{
    CGSize contentSize1 = [self.lbl_title sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];;
    CGSize contentSize2 = [self.lbl_time  sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];;
    CGSize contentSize3 = [self.lbl_content sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];;
    self.lbl_title.height = contentSize1.height;
    self.lbl_time.height = contentSize2.height;
    self.lbl_content.height = contentSize3.height;
    
    self.lbl_time.top = self.lbl_title.bottom + 5;
    self.img_content.top = self.lbl_time.bottom + 5;
    self.lbl_content.top = self.img_content.bottom + 5;
    self.scrollview.contentSize = CGSizeMake(self.view.width, self.lbl_content.bottom);
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self presentLoadinghud];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self dismissAllTips];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self dismissAllTips];
}
#pragma mark - setter getter

-(UIImageView *)img_content
{
    if (!_img_content) {
        _img_content = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.lbl_time.bottom +5, 200, 100)];
        _img_content.image = [UIImage imageWithColor:[UIColor lightTextColor] size:_img_content.size];
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        _img_content.center = CGPointMake(self.scrollview.width/2, 100 + self.lbl_time.bottom +5);
    }
    return _img_content;
}

-(NIAttributedLabel *)lbl_title
{
    if (!_lbl_title) {
        _lbl_title =  [B1_ANewsViewController CreateLabelWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 80) andTxt:@"" fontsize:18];
        _lbl_title.text = @"TITLE";
    }
    return _lbl_title;
}

-(NIAttributedLabel *)lbl_time
{
    if (!_lbl_time) {
        _lbl_time = [B1_ANewsViewController CreateLabelWithFrame:CGRectMake(10, self.lbl_title.bottom, self.lbl_title.width, 20) andTxt:@"" fontsize:10];
        _lbl_time.textColor = [UIColor grayColor];
        _lbl_time.text = @"2015-05-04";
    }
    return _lbl_time;
}

-(NIAttributedLabel *)lbl_content
{
    if (!_lbl_content) {
        _lbl_content = [B1_ANewsViewController CreateLabelWithFrame:CGRectMake(10, self.img_content.bottom, self.lbl_title.width, self.scrollview.height - self.lbl_title.bottom) andTxt:@"" fontsize:FONT_SIZE_LABEL];
    }
    return _lbl_content;
}

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, HEIGHT_NAVIGATIONCTR)];;
        _webView.delegate =self;
    }
    return _webView;
}

-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, HEIGHT_NAVIGATIONCTR)];
       
    }
    return _scrollview;
    
}

+(CGFloat)heightOfContent:(NSString *)contentstr
{
    
    CGFloat   y_label = Y_TO_TOP ;
  
    static NIAttributedLabel* contentLabel = nil;
    
    if (!contentLabel) {
        contentLabel = [B1_ANewsViewController CreateLabelWithFrame:CGRectZero andTxt:contentstr fontsize:FONT_SIZE_LABEL];
        CGRect frame = contentLabel.frame;
        frame.size.width = WIDTH_CONTENT;
        contentLabel.frame = frame;
    }
    else {
        // reuse contentLabel and reset frame, it's great idea from my mind
        contentLabel.frame = CGRectZero;
        CGRect frame = contentLabel.frame;
        frame.size.width = WIDTH_CONTENT;
        contentLabel.frame = frame;
    }
    contentLabel.text = contentstr;
    
    CGSize contentSize = [contentLabel sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];
    
    return  y_label + contentSize.height + Y_TO_BOTTOM + 10;
}


+ (NIAttributedLabel *)CreateLabelWithFrame:(CGRect)frame andTxt:(NSString *)TXT fontsize:(NSUInteger)size
{
    NIAttributedLabel *label=[[NIAttributedLabel alloc] initWithFrame:frame];
    
    //    label.frame= CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, optimumSize.height);
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font=[UIFont systemFontOfSize:size];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentLeft;
    return label;
}



-(ReplyInputAccessoryView *)view_input
{
    if (!_view_input) {
        _view_input = [[ReplyInputAccessoryView alloc] initWithFrame:CGRectMake(0, self.view.height, UISCREEN_WIDTH, 150)];
        _view_input.alpha =0;
        [_view_input addConfirmTarget:self action:@selector(replyConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [_view_input addCloseTarget:self action:@selector(replyCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_view_input];
    }
    return _view_input;
}

-(UIView *)maskview
{
    if (!_maskview) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _maskview = view;
    }
    return _maskview;
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
