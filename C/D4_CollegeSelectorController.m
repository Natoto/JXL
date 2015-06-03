//
//  D4_CollegeSelectorController.m
//  JXL
//
//  Created by BooB on 15/5/3.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "D4_CollegeSelectorController.h"
#import "jxl.h"
#import "JXL_Define.h"
#import "CollegeDataModel.h"

@interface D4_CollegeSelectorController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UITableView *   provicetableview;
@property(nonatomic,retain) UITableView *   citiestableview;
@property(nonatomic,retain) UITableView *   collegestableview;
@property(nonatomic,retain) NSIndexPath *   proviceIndexPath;

@property(nonatomic,retain) NSArray     * data_provices;
@property(nonatomic,retain) NSArray     * data_cities;
@property(nonatomic,retain) NSArray     * data_coleges;

@property(nonatomic,retain) CollegeDataModel * collegeModel;
@property(nonatomic,retain) UIView       * bgview;
@property(nonatomic,retain) UIButton    *  rightButton;
@end

#define TAG_TABLEVIEW_COLLEGE   531253
#define TAG_TABLEVIEW_CITY      531252
#define TAG_TABLEVIEW_PROVICE   531251

@implementation D4_CollegeSelectorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JXL_COLOR_THEME;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.navigationbar setTitle:@"选择学校"];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
     [self.navigationbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"white_back_btn"] target:self selector:@selector(cancel:)];
    self.rightButton = [self.navigationbar setrightBarButtonItemWithTitle:@"选择" target:self selector:@selector(confirm:)];
    //    [self userDefaultBackground];
    self.view.backgroundColor = JXL_COLOR_THEME;
    
    [self.provicetableview reloadData];
    
}

-(id)init
{
    self = [super init];
    if (self) {
        [self collegeModel];
    }
    return self;
}

-(void)cancel:(id)sender
{
    if (self.selectordelegate && [self.selectordelegate respondsToSelector:@selector(cencelSelectD4_CollegeSelectorController:)]) {
        [self.selectordelegate cencelSelectD4_CollegeSelectorController:self];
    }
    [self backtoparent:nil];
}
-(void)loadView
{
    [super loadView];
    [self.view   addSubview:self.bgview];
    [self.bgview addSubview:self.provicetableview];
    [self.bgview addSubview:self.citiestableview];
    [self.bgview addSubview:self.collegestableview];
    
}

-(IBAction)confirm:(id)sender
{
    NSIndexPath * selectPath0 = [self.citiestableview indexPathForSelectedRow];
    NSArray * array = [self.data_cities objectAtIndex:selectPath0.section];
    CITY_STRUCT * citystruct = [array objectAtIndex:selectPath0.row];
    
    NSIndexPath * selectPath = [self.collegestableview indexPathForSelectedRow];
    COLLEGE_STRUCT * collegestruct = [self.data_coleges objectAtIndex:selectPath.row];
    NSLog(@"select college %@ %@",collegestruct.m_name,collegestruct.m_id);
    if (self.selectordelegate && [self.selectordelegate respondsToSelector:@selector(D4_CollegeSelectorController:selectCollegeName:collegeID:)]) {
        [self.selectordelegate D4_CollegeSelectorController:self selectCollegeName:collegestruct.m_name collegeID:collegestruct.m_id];
        [self backtoparent:nil];
    }
    else if (self.selectordelegate && [self.selectordelegate respondsToSelector:@selector(D4_CollegeSelectorController:selectCollageCityName:selectCollegeCityID:selectCollegeName:collegeID:)]) {
        [self.selectordelegate D4_CollegeSelectorController:self selectCollageCityName:citystruct.m_name selectCollegeCityID:citystruct.m_sx selectCollegeName:collegestruct.m_name collegeID:collegestruct.m_id];
        [self backtoparent:nil];
    }
}

-(void)relayoutSubviewsWithSelectTableView:(UITableView *)tableview
{
    [UIView animateWithDuration:0.5 animations:^{
        if (tableview.tag == TAG_TABLEVIEW_COLLEGE) {
            self.bgview.left = - 100;
        }
        else if (tableview.tag == TAG_TABLEVIEW_CITY) {
            self.bgview.left = 0;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - tableview delegate 
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == TAG_TABLEVIEW_PROVICE)
    {
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == TAG_TABLEVIEW_CITY) {
        return self.data_cities.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == TAG_TABLEVIEW_CITY) {
        NSArray * array = [self.data_cities objectAtIndex:section];
        return array.count;
    }
    else if(tableView.tag == TAG_TABLEVIEW_COLLEGE)
    {
        return self.data_coleges.count;
    }
    else if(tableView.tag == TAG_TABLEVIEW_PROVICE)
    {
        return self.data_provices.count;
    }
    else  return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == TAG_TABLEVIEW_CITY ) {
        NSArray * array = [self.data_cities objectAtIndex:section];
        CITY_STRUCT * citystruct = [array objectAtIndex:0];
        return citystruct.m_sx;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identify = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (tableView.tag == TAG_TABLEVIEW_PROVICE) {
        cell.textLabel.text = [self.data_provices objectAtIndex:indexPath.row];
    }
    if (tableView.tag == TAG_TABLEVIEW_CITY) {
        NSArray * array = [self.data_cities objectAtIndex:indexPath.section];
        CITY_STRUCT * citystruct = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = citystruct.m_name;
    }
    if (tableView.tag == TAG_TABLEVIEW_COLLEGE) {
        COLLEGE_STRUCT * colstruct = [self.data_coleges objectAtIndex:indexPath.row];
        cell.textLabel.text = colstruct.m_name;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self relayoutSubviewsWithSelectTableView:tableView];
    if (tableView.tag == TAG_TABLEVIEW_PROVICE) {
        self.proviceIndexPath = indexPath;
        NSInteger row = indexPath.row;
        //刷新城市
        NSArray * cityarray  = [self.collegeModel getCitiesWithIndex:row];
        self.data_cities = [self getcitydataarraywithModelCities:cityarray];
        [self.citiestableview reloadSectionIndexTitles];
        [self.citiestableview reloadData];
        
        [self.citiestableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        //刷新学校
        NSArray * array = [self.data_cities objectAtIndex:0];
        CITY_STRUCT * citystruct = [array objectAtIndex:0];
        NSInteger cityindex = [self getcityIndexOf:citystruct];
        self.data_coleges = [self.collegeModel getCollegesWithProviceIndex:self.proviceIndexPath.row cityindex:cityindex];
        [self.collegestableview reloadData];
        [self.collegestableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    }
    if (tableView.tag == TAG_TABLEVIEW_CITY) {
        
        NSArray * array = [self.data_cities objectAtIndex:indexPath.section];
        CITY_STRUCT * citystruct = [array objectAtIndex:indexPath.row];
        NSInteger cityindex = [self getcityIndexOf:citystruct];
        self.data_coleges = [self.collegeModel getCollegesWithProviceIndex:self.proviceIndexPath.row cityindex:cityindex];
        [self.collegestableview reloadData];
        [self.collegestableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    if (tableView.tag == TAG_TABLEVIEW_COLLEGE) {
        
    }
}


#pragma mark - getter setter

//将得到的从xml中得到的城市转换为带section的数组
-(NSArray *)getcitydataarraywithModelCities:(NSArray *)cityarray
{
    NSMutableArray * mtarray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * temparray = [NSMutableArray arrayWithCapacity:0];
    
    __block NSString * sx = nil;
    [cityarray enumerateObjectsUsingBlock:^(CITY_STRUCT * obj, NSUInteger idx, BOOL *stop) {
        if (!sx || ![sx isEqualToString:obj.m_sx]) {
            if (sx) {
                [mtarray addObject:[NSMutableArray arrayWithArray:temparray]];
                [temparray removeAllObjects];
            }
            sx = obj.m_sx;
            [temparray addObject:obj];
        }
        else
        {
            [temparray addObject:obj];
        }
    }];
    if (temparray.count) {
        [mtarray addObject:temparray];
    }
    return mtarray;
}

-(NSInteger)getcityIndexOf:(CITY_STRUCT *)citystruct
{
    NSIndexPath * proviectIndexPath = self.proviceIndexPath;
    if (proviectIndexPath) {
        NSArray * cityarray  = [self.collegeModel getCitiesWithIndex:proviectIndexPath.row];
        __block NSInteger cityIndex = -1;
        [cityarray enumerateObjectsUsingBlock:^(CITY_STRUCT *obj, NSUInteger idx, BOOL *stop) {
            
            if ([obj.m_name isEqualToString:citystruct.m_name]) {
                cityIndex = idx;
            }
        }];
       if(-1 != cityIndex)
        return cityIndex;
    }
    return 0;
}

-(CollegeDataModel *)collegeModel
{
    if (!_collegeModel) {
        _collegeModel = [[CollegeDataModel alloc] init];
    }
    return _collegeModel;
}

-(NSArray *)data_provices
{
    if (!_data_provices) {
        _data_provices = [self.collegeModel provicenames];
    }
    return _data_provices;
}

#define HEIGHT_TOP_TITLE 30
-(UIView *)bgview
{
    if (!_bgview) {
        _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATIONBAR, 100+ SCREEN_WIDTH, HEIGHT_NAVIGATIONCTR)];
        _bgview.backgroundColor = JXL_COLOR_THEME;
        
        UILabel * lbl_pro = [ToolsFunc CreateLabelWithFrame:CGRectMake(0, 0, 100, HEIGHT_TOP_TITLE) andTxt:@"省份"];
        lbl_pro.backgroundColor = [UIColor lightGrayColor];
        [_bgview addSubview:lbl_pro];
        
        UILabel * lbl_city = [ToolsFunc CreateLabelWithFrame:CGRectMake(lbl_pro.right + 1, 0, 120, HEIGHT_TOP_TITLE) andTxt:@"城市"];
        lbl_city.backgroundColor = [UIColor lightGrayColor];
        [_bgview addSubview:lbl_city];
        
        UILabel * lbl_school = [ToolsFunc CreateLabelWithFrame:CGRectMake(lbl_city.right+1, 0, self.view.width - lbl_city.right + 100, HEIGHT_TOP_TITLE) andTxt:@"学校"];
        lbl_school.backgroundColor = [UIColor lightGrayColor];
        [_bgview addSubview:lbl_school];
    }
    return _bgview;
}

-(UITableView *)provicetableview
{
    if (!_provicetableview) {
        UITableView *provicetableview = [[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHT_TOP_TITLE, 100, HEIGHT_NAVIGATIONCTR - HEIGHT_TOP_TITLE) style:UITableViewStylePlain];
        _provicetableview = provicetableview;
        _provicetableview.delegate = self;
        _provicetableview.dataSource = self;
        _provicetableview.tag = TAG_TABLEVIEW_PROVICE;
    }
    return _provicetableview;
}

-(UITableView *)citiestableview
{
    if (!_citiestableview) {
        UITableView *provicetableview = [[UITableView alloc] initWithFrame:CGRectMake(1 + self.provicetableview.right, HEIGHT_TOP_TITLE, 120, HEIGHT_NAVIGATIONCTR - HEIGHT_TOP_TITLE) style:UITableViewStylePlain];
        _citiestableview = provicetableview;
        _citiestableview.delegate = self;
        _citiestableview.dataSource = self;
        _citiestableview.tag = TAG_TABLEVIEW_CITY;
    
    }
    return _citiestableview;
}


-(UITableView *)collegestableview
{
    if (!_collegestableview) {
        UITableView *provicetableview = [[UITableView alloc] initWithFrame:CGRectMake(1 + self.citiestableview.right, HEIGHT_TOP_TITLE, self.view.width - self.citiestableview.right + 100, HEIGHT_NAVIGATIONCTR - HEIGHT_TOP_TITLE) style:UITableViewStylePlain];
        _collegestableview = provicetableview;
        _collegestableview.delegate = self;
        _collegestableview.dataSource = self;
        _collegestableview.tag = TAG_TABLEVIEW_COLLEGE;
    }
    return _collegestableview;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
