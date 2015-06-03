//
//  B2_NewsComment.m
//  JXL
//
//  Created by 跑酷 on 15/5/5.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "B2_NewsCommentaCell.h"
#import "NIAttributedLabel.h"
#import "ToolsFunc.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"
#import "JXL_Define.h"
#import "UIImageView+WebCache.h"

#define WIDTH_PROFILE 30
#define WIDTH_CONTENT (UISCREEN_WIDTH - WIDTH_PROFILE - 3 * MARGIN_LEFT)

@interface B2_NewsCommentaCell()<NIAttributedLabelDelegate>
@property(nonatomic,retain) NIAttributedLabel * lbl_name;
@property(nonatomic,retain) NIAttributedLabel * lbl_content;
@property(nonatomic,retain) NIAttributedLabel * lbl_reply_name;
@property(nonatomic,retain) NIAttributedLabel * lbl_reply_content;
@property(nonatomic,retain) UIView            * view_reply;
@property(nonatomic,retain) UIImageView       * img_profile;

@end

@implementation B2_NewsCommentaCell

#define FONTSIZE_NAME 12
#define FONTSIZE_CONTENTSIZE 15
#define FONTSIZE_REPLYNAME 12
#define FONTSIZE_REPLYCONTENT 15
#define MARGIN_LEFT 10

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self lbl_name];
        [self view_reply];
        [self lbl_reply_name];
        [self lbl_reply_content];
        [self lbl_content];
    }
    return self;
}


-(void)setcellProfile:(NSString *)profile
{
    
}

-(void)setcellTitle:(NSString *)title
{
    
}

-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    [super setcelldictionary:dictionary];
    
    NSString * profile = [dictionary objectForKey:key_newscommentcell_profile];
    if (profile) {
        self.img_profile.image = [UIImage imageNamed:@"profile"];
        if ([profile hasPrefix:@"http://"]) {
            [self.img_profile sd_setImageWithURL:[NSURL URLWithString:profile] placeholderImage:[UIImage imageNamed:@"profile"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }
    }
  
    self.lbl_name.text          = [dictionary objectForKey:key_newscommentcell_name];
    self.lbl_content.text       = [dictionary objectForKey:key_newscommentcell_content];
    self.lbl_reply_name.text    = [dictionary objectForKey:key_newscommentcell_replyname];
    self.lbl_reply_content.text = [dictionary objectForKey:key_newscommentcell_replycontent];
 
    [self loadSubViews];
}

-(void)loadSubViews
{
    CGSize size1 = [self.lbl_name sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];
    CGSize size2 = [self.lbl_content sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];
    CGSize size3 = [self.lbl_reply_name sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];
    CGSize size4 =  [self.lbl_reply_content sizeThatFits:CGSizeMake(WIDTH_CONTENT, CGFLOAT_MAX)];
    
    self.lbl_name.top = 10;
    self.lbl_name.height = size1.height;
    if (![self.dictionary objectForKey:key_newscommentcell_replycontent]) {
        
        self.view_reply.top = self.lbl_name.bottom + 10;
        self.lbl_reply_name.top = 2;
        self.lbl_reply_name.height = size3.height;
        self.lbl_reply_content.top = self.lbl_reply_name.bottom + 10;
        self.lbl_reply_content.height = size4.height;
        self.view_reply.height = size3.height + size4.height + 14;
        self.lbl_content.top = self.view_reply.bottom;
        self.view_reply.hidden = NO;
    }
    else
    {
        self.view_reply.hidden = YES;
        self.lbl_content.top = self.lbl_name.bottom + 10;
    }
    self.lbl_content.height = size2.height;
    
    
}

+(CGFloat)heightOfCell:(NSString *)name content:(NSString *)content replyname:(NSString *)replyname replycontent:(NSString *)replycontent
{
    CGFloat height1 = [ToolsFunc heightOfNIAttributedLabel:name withwidth:WIDTH_CONTENT fontsize:FONTSIZE_NAME];
    
    height1 = height1 + [ToolsFunc heightOfNIAttributedLabel:content withwidth:WIDTH_CONTENT fontsize:FONTSIZE_NAME];
   
    if (replycontent) {
        if (replyname) {
            height1 = height1 + [ToolsFunc heightOfNIAttributedLabel:replyname withwidth:WIDTH_CONTENT fontsize:FONTSIZE_NAME];
        }
        height1 = height1 + [ToolsFunc heightOfNIAttributedLabel:replycontent withwidth:WIDTH_CONTENT fontsize:FONTSIZE_NAME];
    }
    height1 = height1 + 32;
    height1 = (height1 < 50)? 50:height1;
    
    return height1;
}

-(void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point
{
    NSLog(@"x %f y %f",point.x,point.y);
}
#pragma mark - getter setter 

-(UIImageView *)img_profile
{
    if (!_img_profile) {
        _img_profile = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, 10, 30, 30)];
        _img_profile.backgroundColor = [UIColor grayColor];
        KT_CORNER_PROFILE(_img_profile);
        [self.contentView addSubview:_img_profile];
    }
    return _img_profile;
}

-(NIAttributedLabel *)lbl_name
{
    if (!_lbl_name) {
        _lbl_name = [ToolsFunc CreateNIAttributedLabelWithFrame:CGRectMake(self.img_profile.right + MARGIN_LEFT , 5, WIDTH_CONTENT , 30) andTxt:@"网名 - 普通用户" fontsize:FONTSIZE_NAME];
        _lbl_name.delegate = self;
//        _lbl_name.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_lbl_name];
    }
    return _lbl_name;
}

-(NIAttributedLabel *)lbl_content
{
    if (!_lbl_content) {
        _lbl_content = [ToolsFunc CreateNIAttributedLabelWithFrame:CGRectMake(self.lbl_name.left, self.view_reply.bottom, self.lbl_name.width, 30) andTxt:@"评论  内容..." fontsize:FONTSIZE_CONTENTSIZE];
//        _lbl_content.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_lbl_content];
    }
    return _lbl_content;
}


-(NIAttributedLabel *)lbl_reply_name
{
    if (!_lbl_name) {
        _lbl_reply_name = [ToolsFunc CreateNIAttributedLabelWithFrame:CGRectMake(MARGIN_LEFT, 5, self.contentView.width - MARGIN_LEFT, 30) andTxt:@"网名 - 普通用户" fontsize:FONTSIZE_REPLYNAME];
        _lbl_reply_name.delegate = self;
        [self.view_reply addSubview:_lbl_reply_name];
    }
    return _lbl_reply_name;
}

-(NIAttributedLabel *)lbl_reply_content
{
    if (!_lbl_reply_content) {
         _lbl_reply_content = [ToolsFunc CreateNIAttributedLabelWithFrame:CGRectMake(self.lbl_name.left, self.lbl_reply_name.bottom, self.contentView.width - MARGIN_LEFT, 30) andTxt:@"引用内容..." fontsize:FONTSIZE_REPLYCONTENT];
        [self.view_reply addSubview:_lbl_reply_content];
    }
    return _lbl_reply_content;
}

-(UIView *)view_reply
{
    if (!_view_reply) {
        _view_reply = [[UIView alloc] initWithFrame:CGRectMake(self.img_profile.right + MARGIN_LEFT, self.lbl_name.bottom, WIDTH_CONTENT, 100)];
        _view_reply.backgroundColor = KT_UIColorWithRGB(237., 238, 239);
        [self.contentView addSubview:_view_reply];
    }
    return _view_reply;
}

@end
