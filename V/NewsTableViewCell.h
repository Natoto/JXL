//
//  NewsTableViewCell.h
//  JXL
//
//  Created by BooB on 15-4-20.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

static NSString * key_newstableviewcell_photo = @"key_newstableviewcell_photo";
static NSString * key_newstableviewcell_title = @"key_newstableviewcell_title";
static NSString * key_newstableviewcell_views = @"key_newstableviewcell_views";
static NSString * key_newstableviewcell_other = @"key_newstableviewcell_other";
static NSString * key_newstableviewcell_dianzan = @"key_newstableviewcell_dianzan";

static NSString * key_newstableviewcell_isproject = @"key_newstableviewcell_isproject";
static NSString * key_newstableviewcell_projectstate = @"key_newstableviewcell_projectstate";
static NSString * key_newstableviewcell_projectlocation = @"key_newstableviewcell_projectlocation";
@interface NewsTableViewCell : BaseTableViewCell

+(CGFloat)heightOfCell;
@end
