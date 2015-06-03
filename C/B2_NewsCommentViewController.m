//
//  B2_NewsCommentViewController.m
//  JXL
//
//  Created by 跑酷 on 15/5/5.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "B2_NewsCommentViewController.h"
#import "jxl.h"
#import "B2_NewsCommentaCell.h"
#import "NSString+HBExtension.h"
#import "ReplyInputAccessoryView.h"
#import "D1_LoginViewController.h"
#import "RootViewController.h"
@interface B2_NewsCommentViewController ()
@property(nonatomic,retain) NSArray * dataArray;
//@property(nonatomic,retain) UITextField * txt_reply;
@property(nonatomic,retain) UIView * maskview;
@property(nonatomic,retain) ReplyInputAccessoryView  * view_input;

@property(nonatomic,retain) NSString * m_reply_id;
@property(nonatomic,retain) NSString * m_reply_mid;
@end

@implementation B2_NewsCommentViewController

-(void)dealloc
{
    REMOVEOBSERVER_KEYBOARD_HIDE_NOTIFY(self)
    REMOVEOBSERVER_KEYBOARD_SHOW_NOTIFY(self)
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    ADDOBSERVER_KEYBOARD_HIDE_NOTIFY(self, @selector(keyboardwillhide:))
    ADDOBSERVER_KEYBOARD_SHOW_NOTIFY(self, @selector(keyboardwillshow:));
    [self addToolBar];
    
    self.tableView.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - self.navigationtoolsbar.height - 20);
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
   
    [self refreshView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.statusBarStyleDefault = YES;
}

-(void)refreshView
{
    [[HTTPSEngine sharedInstance] fetch_newsCommentListWithcid:self.m_cid type:self.m_type page:1 pagesize:20 response:^(NSDictionary *Dictionary) {
        
        if ([Dictionary isErrorObject]) {
            
            APIBaseObject * error = [APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips:error.m_errorMsg dismisblock:^{
//                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            self.dataArray = [NewsCommentListModel encodeDiction:Dictionary];
            [self dataChange:self.dataArray];
        }
    } errorHandler:^(NSError *error) {
        
    }];
}
-(void)dataChange:(NSArray *)array
{
    if (!array) {
        return;
    }
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(NewsCommentList * obj, NSUInteger idx, BOOL *stop) {
        
        CELL_STRUCT * cellstruct = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:@"B2_NewsCommentaCell" placeholder:@"" accessory:NO sel_selctor:@selector(cellselectaction:) delegate:self];
        if (0 == idx) {
            cellstruct.sectionheight = 40;
            cellstruct.sectiontitle = @"评论列表";
        }
        NSString * namestr = JOIN_STR(obj.m_memberName, @"   ", obj.m_typeName);
        NSString * contentstr = obj.m_content;
        NSString * replycontentstr = obj.m_reply_content;
        NSString * replynamestr = JOIN_STR(obj.m_reply_name, @"   ", obj.m_reply_typeName);
        cellstruct.cellheight = [B2_NewsCommentaCell heightOfCell:namestr content:contentstr replyname:replynamestr replycontent:replycontentstr];
        cellstruct.selectionStyle = NO;
        cellstruct.object = obj;
        NSDictionary * celldic = @{key_cellstruct_background:[UIColor whiteColor],
                                   key_newscommentcell_content:contentstr,
                                   key_newscommentcell_name:namestr,
                                   key_newscommentcell_profile:obj.m_memberName_pic,
                                   key_newscommentcell_replycontent:replycontentstr,
                                   key_newscommentcell_replyname:replynamestr
                                   };
        cellstruct.dictionary = [NSMutableDictionary dictionaryWithDictionary:celldic];
        [dictionary setObject:cellstruct forKeyedSubscript:KEY_INDEXPATH(0, idx)];
    }];
    self.dataDictionary = dictionary;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addToolBar
{
    [self navigationtoolsbar];
    [self.navigationtoolsbar drawtoplinelayer];
    //    [self showhbnavigationbarBackItem:YES];
    
    UIView * centerview = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 250, 30)];
    
    centerview.backgroundColor = [UIColor whiteColor];
//    centerview.layer.borderColor = [UIColor grayColor].CGColor;
//    centerview.layer.borderWidth = 0.6;
    KT_LAYERBOARDER_COLOR(centerview, 0.6, [UIColor grayColor]);
    
    UIButton * writebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [writebtn setImage:[UIImage imageNamed:@"item_write"] forState:UIControlStateNormal];
    [writebtn setTitle:@"我来说两句" forState:UIControlStateNormal];
    writebtn.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
    writebtn.titleLabel.font = [UIFont systemFontOfSize:12];
    writebtn.showsTouchWhenHighlighted = YES;
    [writebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [writebtn addTarget:self action:@selector(wirtecomment:) forControlEvents:UIControlEventTouchUpInside];
    writebtn.frame = CGRectMake(5, 0, 200, 30);
    
    [centerview addSubview:writebtn];
    [self.navigationtoolsbar setTitleView:centerview];
    centerview.height = 30;
    centerview.centerY = 22;
    centerview.left = 80;
    centerview.width = 200;
    
//    self.navigationtoolsbar.frame = CGRectMake(0, self.view.height - self.navigationtoolsbar.height, self.view.width, self.navigationtoolsbar.height);
    [self.navigationtoolsbar setBackgroundColor:KT_UIColorWithRGB(236, 236, 236)];
    [self.navigationtoolsbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"back_gray"] target:self selector:@selector(backtoparent:)];
    
//    [self.navigationtoolsbar setrightBarButtonItemWithImage:[UIImage imageNamed:@"item_share"] target:self selector:@selector(share:)];
}

#pragma mark - action
-(IBAction)cellselectaction:(id)sender
{
    if (![GlobalData sharedInstance].m_mid ) {
        [[RootViewController sharedInstance] rootpresentLoginViewController];
        return;
    } 
    
    CELL_STRUCT * cellstruct = (CELL_STRUCT *)sender;
    NewsCommentList * comment = (NewsCommentList *)cellstruct.object;
    if ([comment.m_mid is:[GlobalData sharedInstance].m_mid]) {
        [self presentMessageTips:@"自己不能评论自己！"];
        return;
    }
    self.m_reply_id = comment.m_id;
    self.m_reply_mid = comment.m_mid ;
    [self.view_input becomeFirstResponder];

}

-(IBAction)backtoparent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)wirtecomment:(id)sender
{
    if (![GlobalData sharedInstance].m_mid ) {
        [[RootViewController sharedInstance] rootpresentLoginViewController];
        return;
    }

    [self.view_input becomeFirstResponder];
}


-(IBAction)replyConfirm:(id)sender
{
    NSString * contentstr = self.view_input.content;
    NSLog(@"contentstr %@",contentstr);
   [self replyWithContentstr:self.view_input.content reply_id:self.m_reply_id reply_mid:self.m_reply_mid];
   [self.view_input resignFirstResponder];
 }

-(void)replyWithContentstr:(NSString *)contentstr reply_id:(NSString *)reply_id reply_mid:(NSString *)reply_mid
{
    
    [[HTTPSEngine sharedInstance] fetch_newscommentWithCid:self.m_cid mid:[GlobalData sharedInstance].m_mid content:contentstr type:self.m_type reply_id:reply_id reply_mid:reply_mid response:^(NSDictionary *Dictionary) {
        if ([Dictionary isErrorObject]) {
            APIBaseObject * error =[APIBaseObject encodeDiction:Dictionary];
            [self presentMessageTips_:error.m_errorMsg];
        }
        else
        {
            self.view_input.content = @"";
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
        self.m_reply_mid = nil;
        self.m_reply_id = nil;
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

//-(UITextField *)txt_reply
//{
//    if (!_txt_reply) {
//        _txt_reply = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.bottom, 100, 20)];
//        _txt_reply.backgroundColor = [UIColor greenColor];
//        [self.view addSubview:_txt_reply];
//        _txt_reply.inputAccessoryView = self.view_input;
//    }
//    return _txt_reply;
//}


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
@end
