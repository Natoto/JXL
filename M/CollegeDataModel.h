//
//  CollegeDataModel.h
//  JXL
//
//  Created by BooB on 15-5-3.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <Foundation/Foundation.h>


//city name="安康市" sx="A"
@interface CITY_STRUCT : NSObject

@property(nonatomic,retain) NSString * m_name;
@property(nonatomic,retain) NSString * m_sx;
@end

//college name="安康学院" id="2756
@interface COLLEGE_STRUCT : NSObject
@property(nonatomic,strong) NSString * m_name;
@property(nonatomic,strong) NSString * m_id;
@end

@interface CollegeDataModel : NSObject

@property(nonatomic,retain) NSArray * provicenames;

-(NSArray *)provicenames;

/**
 * 得到城市数组 citystruct
 * 参数 proviceindex 省的索引
 */
-(NSArray *)getCitiesWithIndex:(NSInteger)proviceIndex;
/**
 * 得到某一城市所有学校
 * 参数 省索引 市索引
 */
-(NSArray *)getCollegesWithProviceIndex:(NSInteger)proviceindex cityindex:(NSInteger)cityindex;
@end
