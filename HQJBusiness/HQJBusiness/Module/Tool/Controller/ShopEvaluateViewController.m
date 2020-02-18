//
//  MessageVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopEvaluateViewController.h"
#import "ShopEvaluateCell.h"
#import "ContactManagerHeadView.h"
#import "EvaluateDetailViewController.h"
#define TableViewCellHeight 120.f
#define HeadHeight  132/3.f
#define TableViewTopSpace 40/3.f
@interface ShopEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, assign) NSInteger topTag;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ContactManagerHeadView *headView;

@end

@implementation ShopEvaluateViewController

-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[ShopEvaluateCell class] forCellReuseIdentifier:NSStringFromClass([ShopEvaluateCell class])];
        
    }
    
    return _tableView;
}

- (ContactManagerHeadView *)headView{
    if (_headView == nil) {
        _headView = [[ContactManagerHeadView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HeadHeight) andTitleArray:@[@"全部待评",@"买家已评",@"买家未评"]];
        _headView.selectIndex = 0;
        @weakify(self);
        [_headView setItemBlock:^(NSInteger selectedIndex) {
            @strongify(self);
            self.topTag = selectedIndex;
            [self.tableView reloadData];
        }];
    }
    return _headView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"商品评价";
    [self addSubViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarWhite;
    self.isHideShadowLine = YES;
}
- (void)addSubViews{
    [self.view addSubview:self.tableView];
}
#pragma mark --- DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"tool_emptypages"];
}

#pragma mark --- UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TableViewTopSpace;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopEvaluateCell class]) forIndexPath:indexPath];
    CellLine(cell);
    return cell;
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EvaluateDetailViewController *edVc = [[EvaluateDetailViewController alloc]init];
    [self.navigationController pushViewController:edVc animated:YES];
}


@end
