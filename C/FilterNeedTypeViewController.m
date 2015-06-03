//
//  FilterNeedTypeViewController.m
//  JXL
//
//  Created by BooB on 15/5/24.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "FilterNeedTypeViewController.h"
#import "jxl.h"
@interface FilterNeedTypeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UITableView * firstTableView;
@property(nonatomic,retain) UITableView * secondTableView;

@property(nonatomic,retain) NSString   *  m_selectxuqiuitem;
@property(nonatomic,retain) NSString   *  m_selectmoneyitem;
AS_ARRAY(xuqiu)
AS_ARRAY(moneyitems)
//
//
//
//
@end


@implementation FilterNeedTypeViewController



//GET_CELL_SELECT_ACTION(cellstruct)
//{
//    if(self.delegate && [self.delegate respondsToSelector:@selector(FilterNeedTypeViewController:selectItem:)])
//    {
//        [self.delegate FilterNeedTypeViewController:self selectItem:cellstruct.title];
//        [self backtoparent:nil];
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self userDefaultConfigWithTitle:@"选择需求类别"];
    
    UIImage * graybackimg = [UIImage imageNamed:@"white_back_btn"];
//    graybackimg = [graybackimg imageWithTintColor:[UIColor grayColor]];
    [self.navigationbar setleftBarButtonItemWithImage:graybackimg target:self selector:@selector(cancel:)];
    [self.navigationbar setrightBarButtonItemWithTitle:@"选择" target:self selector:@selector(comfirm:)];
    
    self.m_xuqiu = @[@"找员工",@"找导师",@"寻找资金",@"寻求合作"];
    self.m_moneyitems = @[[self formatMoney:@1 max:@5],
                          [self formatMoney:@5 max:@10],
                          [self formatMoney:@10 max:@20],
                          [self formatMoney:@20 max:@30],
                          [self formatMoney:@30 max:@50],
                          [self formatMoney:@50 max:@70],
                          [self formatMoney:@70 max:@100],
                          [self formatMoneymix:@100]];
    
    [self showMoneySelector:NO];
}

-(NSString *)formatMoney:(NSNumber *)min max:(NSNumber *)max
{
    return [NSString stringWithFormat:@"%@万-%@万",min,max];
}
-(NSString *)formatMoneymix:(NSNumber *)min
{
    return [NSString stringWithFormat:@"%@万以上",min];
}

-(void)userDefaultConfigWithTitle:(NSString *)title
{
    [self userDefaultBackground];
    [self.navigationbar setTitle:title];
    [self showhbnavigationbarBackItem:YES];
    [self.navigationbar setBackgroundColor:JXL_COLOR_THEME_NAVIGATIONBAR];
//    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
}


-(void)cancel:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(cancelSelectFilterNeedTypeViewController:)])
    {
        [self.delegate cancelSelectFilterNeedTypeViewController:self];
    }
    [self backtoparent:nil];
}

-(void)comfirm:(id)sender
{
    if (!self.m_selectmoneyitem) {
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(FilterNeedTypeViewController:selectItem:)])
        {
            NSString * title =self.m_selectxuqiuitem;
            self.m_selectxuqiuitem = title;
            [self.delegate FilterNeedTypeViewController:self selectItem:title ];
            [self showMoneySelector:NO];
            [self backtoparent:nil];
            
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(FilterNeedTypeViewController:selectItem:money:)]) {
            NSString * money = self.m_selectmoneyitem;
            [self.delegate FilterNeedTypeViewController:self selectItem:@"寻找资金" money:money];
            [self backtoparent:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.firstTableView) {
        return self.m_xuqiu.count;
    }
    else if(tableView == self.secondTableView)
    {
        return self.m_moneyitems.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView == self.firstTableView) {
        cell.textLabel.text = [self.m_xuqiu objectAtIndex:indexPath.row];
    }
    else if(tableView == self.secondTableView)
    {
        cell.textLabel.text = [self.m_moneyitems objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstTableView) {
        
        NSString * title = [self.m_xuqiu objectAtIndex:indexPath.row];
        self.m_selectxuqiuitem = title;
        self.m_selectmoneyitem = nil;
        if ([title isEqualToString:@"寻找资金"]) {
            [self.secondTableView reloadData];
            [self showMoneySelector:YES];
        }
        else
        {
            [self showMoneySelector:NO];
        }
        
    }
    else if(tableView == self.secondTableView)
    {
        NSString * money = [self.m_moneyitems objectAtIndex:indexPath.row];
        self.m_selectmoneyitem = money;
    }
}

-(void)showMoneySelector:(BOOL)show
{
    if (show) {
        self.firstTableView.width = self.view.width/2;
        self.secondTableView.width = self.view.width/2;
        self.secondTableView.left = self.view.width/2 +1;
        self.secondTableView.hidden = NO;
    }
    else
    {
        self.firstTableView.width = self.view.width;
        self.secondTableView.width = 0;
        self.secondTableView.left = self.view.width;
        self.secondTableView.hidden = YES;
    }
}

-(UITableView *)firstTableView
{
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationbar.bottom, self.view.width/2, HEIGHT_NAVIGATIONCTR)];
        _firstTableView.delegate = self;
        _firstTableView.dataSource = self;
        [self.view addSubview:_firstTableView];
    }
    return _firstTableView;
}

-(UITableView *)secondTableView
{
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.width/2 + 1, self.navigationbar.bottom, self.view.width/2, HEIGHT_NAVIGATIONCTR)];
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        [self.view addSubview:_secondTableView];
    }
    return _secondTableView;
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
