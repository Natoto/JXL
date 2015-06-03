//
//  CommonView.h
//  JXL
//
//  Created by BooB on 15-5-1.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CELL_STRUCT.h"


#define AS_CELL_STRUCT_JXLCOMMON(OBJ) @property(nonatomic,retain) CELL_STRUCT * cell_struct_##OBJ;


#define GET_CELL_STRUCT_ALLPARA_WITH(OBJ,TITLE,SELECTENABLE,ACCESSORY,HEIGHT,IMAGERIGHT,IMAGECORNER,TARGET,SELECTOR) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [JXL_Common cell_x_x_struct:@#TITLE detailvalue:nil footerheight:20 selectionStyle:SELECTENABLE  accessory:ACCESSORY cellheight:HEIGHT imageRight:IMAGERIGHT imageCornerRadius:IMAGECORNER target:TARGET selectAction:SELECTOR];\
}\
return _cell_struct_##OBJ;}

#define GET_CELL_STRUCT_WITH(OBJ,TITLE,TARGET,SELECTOR) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [JXL_Common cell_x_x_struct:@#TITLE detailvalue:nil footerheight:20 selectionStyle:YES  accessory:NO cellheight:40 imageRight:NO imageCornerRadius:NO picture:nil target:TARGET selectAction:SELECTOR];\
}\
return _cell_struct_##OBJ;}

#define GET_CELL_STRUCT_WITH_OBJ_TITLE_IMAGE(OBJ,TITLE,IMAGE,TARGET,SELECTOR) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [JXL_Common cell_x_x_struct:@#TITLE detailvalue:nil \
                    footerheight:20 \
                    selectionStyle:YES  \
                    accessory:NO \
                    cellheight:40 \
                    imageRight:NO \
                    imageCornerRadius:NO \
                    picture:IMAGE \
                    target:TARGET \
                    selectAction:SELECTOR \
                    background:[UIColor whiteColor] ];\
}\
return _cell_struct_##OBJ;}


#define GET_CELL_STRUCT_DICTIONARY(OBJ,DIC) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [JXL_Common cell_x_x_structWithDictionary:DIC];\
}\
return _cell_struct_##OBJ;}



#define GET_A0_FIRSTPAGE_CELL(OBJ,CELLNAME,HEIGHT) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:@"" cellclass:CELLNAME placeholder:@"" accessory:NO sel_selctor:@selector(selectAction:) delegate:self];\
cell1_0.cellheight = HEIGHT;  \
cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:[UIColor clearColor]}];\
cell1_0.subvalue1 = @"xib";\
cell1_0.selectionStyle = NO;\
_cell_struct_##OBJ = cell1_0;\
}\
return _cell_struct_##OBJ;\
}

#define GET_COMMON_LABEL(_LABEL,_SUPERVIEW,_OTHER) \
if (!_LABEL) {\
_LABEL = [[UILabel alloc] init];\
if (_SUPERVIEW) {\
[_SUPERVIEW addSubview:_LABEL]; _OTHER;\
}\
}\


#define GET_CELL_STRUCT_(OBJ,TITLE) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
if (!_cell_struct_##OBJ) {\
_cell_struct_##OBJ = [JXL_Common cell_x_x_struct:@#TITLE detailvalue:nil footerheight:0 selectionStyle:YES accessory:YES cellheight:44 imageRight:NO imageCornerRadius:NO picture:nil target:self selectAction:@selector(selectAction:) background:[UIColor whiteColor]];\
}\
return _cell_struct_##OBJ;\
}

#define GET_CELL_SELECT_ACTION(SENDER) -(IBAction)selectAction:(CELL_STRUCT *)SENDER


@interface JXL_Common : NSObject

+(UIView *)BigButtonview:(CGRect)frame btnframe:(CGRect)buttonFrame title:(NSString *)title target:(id)target sel:(SEL)selector;

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title target:(id)target selectAction:(SEL)selectAction;


+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title detailvalue:(NSString *)detailvalue footerheight:(CGFloat)footerheight selectionStyle:(BOOL)selectionStyle accessory:(BOOL)accessory target:(id)target selectAction:(SEL)selectAction;


+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title detailvalue:(NSString *)detailvalue footerheight:(CGFloat)footerheight selectionStyle:(BOOL)selectionStyle accessory:(BOOL)accessory  picture:(NSString *)picture target:(id)target selectAction:(SEL)selectAction;


+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title detailvalue:(NSString *)detailvalue footerheight:(CGFloat)footerheight selectionStyle:(BOOL)selectionStyle accessory:(BOOL)accessory  picture:(NSString *)picture background:(UIColor *)backgroundcolor target:(id)target selectAction:(SEL)selectAction;

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                     cellheight:(CGFloat)cellheight
                     imageRight:(BOOL)imageRight
              imageCornerRadius:(BOOL)imageCornerRadius
                        picture:(NSString *)picture
                         target:(id)target
                   selectAction:(SEL)selectAction
                     background:(UIColor *)backgroundcolor;

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                     cellheight:(CGFloat)cellheight
                     imageRight:(BOOL)imageRight
              imageCornerRadius:(BOOL)imageCornerRadius
                        picture:(NSString *)picture
                         target:(id)target
                   selectAction:(SEL)selectAction
                     background:(UIColor *)backgroundcolor
                     titlecolor:(NSString *)titlecolor;

+(CELL_STRUCT *)cell_x_x_structWithDictionary:(NSDictionary *)dictionary;

+(UIColor *)colorWithStructKey:(NSString *)key;

+(UILabel *)get_label:(UILabel *)label superview:(UIView *)superview;
+(UIButton *)get_button:(UIButton *)button superview:(UIView *)superview;
+(UIImageView *)get_imageview:(UIImageView *)imageview superview:(UIView *)superview;

+(UIView *)BigCenterButtonview:(CGRect)frame btnframe:(CGRect)buttonFrame title:(NSString *)title target:(id)target sel:(SEL)selector;
@end
