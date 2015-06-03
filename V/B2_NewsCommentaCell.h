//
//  B2_NewsComment.h
//  JXL
//
//  Created by 跑酷 on 15/5/5.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewCell.h"

static NSString * key_newscommentcell_name          = @"key_newscommentcell_name";
static NSString * key_newscommentcell_content       = @"key_newscommentcell_content";
static NSString * key_newscommentcell_replyname     = @"key_newscommentcell_replyname";
static NSString * key_newscommentcell_replycontent  = @"key_newscommentcell_replycontent";
static NSString * key_newscommentcell_profile       = @"key_newscommentcell_profile";

@interface B2_NewsCommentaCell : BaseTableViewCell

+(CGFloat)heightOfCell:(NSString *)name content:(NSString *)content replyname:(NSString *)replyname replycontent:(NSString *)replycontent;
@end
