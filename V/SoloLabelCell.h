//
//  SoloLabelCell.h
//  JXL
//
//  Created by 跑酷 on 15/5/21.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "BaseTableViewCell.h"
@class NIAttributedLabel;
@interface SoloLabelCell : BaseTableViewCell
@property(nonatomic,retain) NIAttributedLabel * m_Label;

+(CGFloat)heighofCell:(NSString *)content;
@end
