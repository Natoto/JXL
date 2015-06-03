//
//  CollegeDataModel.m
//  JXL
//
//  Created by BooB on 15-5-3.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "CollegeDataModel.h"
#import "DDXML.h"
#import <Foundation/Foundation.h>
#import "DDXMLElementAdditions.h"


@implementation CITY_STRUCT

@end

@implementation COLLEGE_STRUCT

@end

@interface CollegeDataModel()
@property(nonatomic,strong) NSString * XMLStr;

@end

@implementation CollegeDataModel


-(id)init
{
    self = [super init];
    if (self) {
      
        
//        NSError * error;
//        DDXMLElement *ddBody = [[DDXMLElement alloc] initWithXMLString:str error:&error];
//        NSArray * array = [ddBody elementsForName:@"province"];

        [self XMLStr];
        NSArray * array = [self provicenames];
        
        NSArray * citys = [self getCitiesWithIndex:0];
        NSArray * colleges = [self getCollegesWithProviceIndex:0 cityindex:0];
//    	DDXMLElement *nsRoot1 = [ddBody elementWithName:@"root"];
        
    }
    return self;
}

-(NSString *)XMLStr
{
    if (!_XMLStr) {
        NSString * path =[[NSBundle mainBundle] pathForResource:@"college_data" ofType:@"xml"];
        NSString * str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding  error:nil];
        _XMLStr = str;
    }
    return _XMLStr;
}


-(NSArray *)provicenames
{
    if (!_provicenames) {
        NSError * error;
        DDXMLElement *ddBody = [[DDXMLElement alloc] initWithXMLString:self.XMLStr error:&error];
        NSArray * PROVICES = [ddBody elementsForName:@"province"];
        
        NSMutableArray * provicenames = [NSMutableArray arrayWithCapacity:0];
        [PROVICES enumerateObjectsUsingBlock:^(DDXMLElement * obj, NSUInteger idx, BOOL *stop) {
            DDXMLNode * provicename = [obj attributeForName:@"name"];
            [provicenames addObject:[provicename stringValue]];
        }];
        _provicenames = provicenames;
    }
    return _provicenames;
}

/**
 * 得到城市数组 citystruct 
 * 参数 proviceindex 省的索引
 */
-(NSArray *)getCitiesWithIndex:(NSInteger)proviceIndex
{
    NSError * error;
    DDXMLElement *ddBody = [[DDXMLElement alloc] initWithXMLString:self.XMLStr error:&error];
    NSArray * PROVICES = [ddBody elementsForName:@"province"];
    DDXMLElement * APROVICE = [PROVICES objectAtIndex:proviceIndex];
    NSArray *CITIES = [APROVICE elementsForName:@"city"];
    
    NSMutableArray * citiestructs = [NSMutableArray arrayWithCapacity:0];
    [CITIES enumerateObjectsUsingBlock:^(DDXMLElement * obj, NSUInteger idx, BOOL *stop) {
        
        CITY_STRUCT * citystruct = [[CITY_STRUCT alloc] init];
        citystruct.m_name = [[obj attributeForName:@"name"] stringValue];
        citystruct.m_sx = [[obj attributeForName:@"sx"] stringValue];
        [citiestructs addObject:citystruct];
    }];
    return citiestructs;
}


/**
 * 得到某一城市所有学校
 * 参数 省索引 市索引
 */
-(NSArray *)getCollegesWithProviceIndex:(NSInteger)proviceindex cityindex:(NSInteger)cityindex
{
    NSError * error;
    DDXMLElement *ddBody = [[DDXMLElement alloc] initWithXMLString:self.XMLStr error:&error];
    NSArray * provices = [ddBody elementsForName:@"province"];
    DDXMLElement * aprovice = [provices objectAtIndex:proviceindex];
    NSArray *cities = [aprovice elementsForName:@"city"];
    DDXMLElement * acity = [cities objectAtIndex:cityindex];
    NSArray * collegeselements = [acity elementsForName:@"college"];
    
    NSMutableArray * colleges = [NSMutableArray arrayWithCapacity:0];
    [collegeselements enumerateObjectsUsingBlock:^(DDXMLElement * obj, NSUInteger idx, BOOL *stop) {
        
        COLLEGE_STRUCT * citystruct = [[COLLEGE_STRUCT alloc] init];
        citystruct.m_name = [[obj attributeForName:@"name"] stringValue];
        citystruct.m_id = [[obj attributeForName:@"id"] stringValue];
        [colleges addObject:citystruct];
    }];
    return colleges;
}

@end
