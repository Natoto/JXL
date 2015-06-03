//
//  D1_PersonalPageCell.m
//  JXL
//
//  Created by BooB on 15/5/18.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D1_PersonalPageCell.h"
#import "JXLCommon.h"
#import "UIViewAdditions.h"
#import "MemberCommnetsModel.h"
#import "ToolsFunc.h"
#import "JXL_Define.h"
#import "EXUILabel.h"

@implementation D1_PersonalPageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setcellTitle:(NSString *)title{};
-(void)setcellProfile:(NSString *)profile{};

-(void)setcellobject:(id)object
{
    AMemberCommnet * amc = (AMemberCommnet *)object;
    if (amc) {
        self.lbl_comment.text = amc.content;
        self.lbl_yinyong.text = amc.title;
        if (amc.addtime.length) {
            self.lbl_time.text = [ToolsFunc datefromstring:amc.addtime format:@"dd/MM"];
            NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.lbl_time.text];
            NSDictionary * dictionary = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:30]};
            [attributedString addAttributes:dictionary range:NSMakeRange(0, 2)];
            self.lbl_time.attributedText = attributedString;
        }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.separatorInset = UIEdgeInsetsMake(0, 90, 0, 0);
    self.lbl_time.frame = CGRectMake(10, 0, 80, 50);
    self.lbl_comment.frame = CGRectMake(self.lbl_time.right, self.lbl_time.top, self.width - self.lbl_time.right - 10, 30);
    self.lbl_yinyong.frame = CGRectMake(self.lbl_comment.left, self.lbl_comment.bottom, self.width - self.lbl_comment.left - 10, 50);
    
}

-(UILabel *)lbl_comment
{
    GET_COMMON_LABEL(_lbl_comment, self.contentView, ;);
    return _lbl_comment;
}

-(UILabel *)lbl_time
{
    GET_COMMON_LABEL(_lbl_time, self.contentView,
                     _lbl_time.textAlignment = NSTextAlignmentLeft;);
    return _lbl_time;
}

-(EXUILabel *)lbl_yinyong
{
    if (!_lbl_yinyong) {\
            _lbl_yinyong = [[EXUILabel alloc] initWithFrame:CGRectZero andInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            _lbl_yinyong.backgroundColor =  KT_UIColorWithRGB(247, 247, 247);
            _lbl_yinyong.numberOfLines = 3;
            KT_CORNER_RADIUS(_lbl_yinyong, 5);
            [self.contentView addSubview:_lbl_yinyong];
        }
    return _lbl_yinyong;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
