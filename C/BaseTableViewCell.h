

//       _      ______
//	/\ _\ \    /\  __ \
//	\   _  \   \ \  __<
//	 \ \  \ \   \ \_____\
//	  \/   \/    \/_____/
//
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//


#define HBLOG(SS) NSLog(@"%@",SS);

#import <UIKit/UIKit.h>
#import "CELL_STRUCT_KEY.h"
@interface BaseTableViewCell : UITableViewCell
@property(nonatomic,assign) BOOL RoundCircleType;
@property(nonatomic,strong) NSIndexPath * indexPath;
@property(nonatomic,assign) SEL selector;
@property(nonatomic,assign) id  delegate;
@property(nonatomic,assign) id  cellstruct;
@property(nonatomic,retain) NSString* subvalue2;
@property(nonatomic,weak) id object;
@property(nonatomic,weak) id object2;
@property(nonatomic,assign) BOOL imageRight;
@property(nonatomic,assign) BOOL CornerRadius;
@property(nonatomic,retain) NSMutableDictionary * dictionary;
-(void)setcelldictionary:(NSMutableDictionary *)dictionary;
-(void)setcellimageRight:(BOOL)imageRight;
-(void)setcellpicturecolor:(NSString *)picturecolor;
-(void)setcellobject:(id)object;
-(void)setcellobject2:(id)object;
-(void)setcelldelegate:(id)delegate;
-(void)setcellProfile:(NSString *)profile;
-(void)setcellTitle:(NSString *)title;
-(void)setcellTitleColor:(NSString *)color;
-(void)setcellValue:(NSString *)value;
-(void)setcellValue2:(NSString *)value;
-(void)setcellplaceholder:(NSString *)placeholder;
-(void)setcellArray:(NSMutableArray *)array;
-(void)setinputAccessoryView:(NSString *)inputAccessoryView;
-(void)setinputView:(NSString *)inputView;
-(void)setcelldetailtitle:(NSString *)detailtitle;
-(void)setcellimageCornerRadius:(BOOL)CornerRadius;
//-(void)setcellAction:(SEL)action;
@end
