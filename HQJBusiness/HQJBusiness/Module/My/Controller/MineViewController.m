//
//  MineViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MineViewController.h"

#import "MineHeadView.h"

#import "MineViewModel.h"

#import "MineCell.h"

#import "MineLogoutCell.h"
#define HeadViewHeight 130.f

#define TableViewCellHeight 50.f
#define TableViewSectionHeight 40/3.f


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)MineHeadView *headView;

@property (nonatomic,strong)MineViewModel *viewModel;



@end

@implementation MineViewController

-(UITableView *)tableView {
    if ( _tableView == nil ) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, NavigationControllerHeight + HeadViewHeight, WIDTH, HEIGHT- NavigationControllerHeight - ToolBarHeight - HeadViewHeight);
        _tableView.backgroundColor = DefaultBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[MineCell class] forCellReuseIdentifier:NSStringFromClass([MineCell class])];
        [_tableView registerClass:[MineLogoutCell class] forCellReuseIdentifier:NSStringFromClass([MineLogoutCell class])];
        
    }
    
    return _tableView;
}

- (MineHeadView *)headView{
    if (_headView == nil) {
        _headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, HeadViewHeight)];
    }
    return _headView;
}

- (MineViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[MineViewModel alloc]initWithViewContoller:self];
    }
    return _viewModel;
}


#pragma mark --
#pragma mark ---
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}


- (void)addSubViews{
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
#pragma mark --- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return TableViewCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    if (section == self.viewModel.cellDataArray.count - 1 ) {
        return 100.f;
    }
    return TableViewSectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = DefaultBackgroundColor;
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.cellDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.cellDataArray[section] count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel cellManageWithTableView:tableView cellForRowAtIndexPath:indexPath];
    
}

#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel selectCellForIndex:indexPath];
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
