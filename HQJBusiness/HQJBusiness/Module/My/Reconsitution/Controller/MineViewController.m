//
//  MineViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MineViewController.h"
#import "PersonInfoViewController.h"

#import "MineHeadView.h"

#import "MineViewModel.h"

#import "MineCell.h"

#import "ShopModel.h"




#define HeadViewHeight 260/3.f
#define TableViewCellHeight 50.f
#define TableViewSectionHeight 40/3.f


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)MineHeadView *headView;

@property (nonatomic,strong)MineViewModel *viewModel;

@property (nonatomic,strong)ShopModel *model;
@end

@implementation MineViewController

-(UITableView *)tableView {
    if ( _tableView == nil ) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - ToolBarHeight);
        _tableView.backgroundColor = DefaultBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = self.headView;
        
        [_tableView registerClass:[MineCell class] forCellReuseIdentifier:NSStringFromClass([MineCell class])];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requst];
        }];
        _tableView.mj_header = header;
        header.lastUpdatedTimeLabel.hidden = YES;
    }

    return _tableView;
}

- (MineHeadView *)headView{
    if (_headView == nil) {
        _headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, HeadViewHeight)];
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTapClick)];
        [_headView addGestureRecognizer:headTap];
    }
    return _headView;
}

- (void)headTapClick{
    PersonInfoViewController *pivc = [[PersonInfoViewController alloc]init];
    [self.navigationController pushViewController:pivc animated:YES];
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
    [self initDatas];
    [self addSubViews];
}

- (void)initDatas{
    _model = [[ShopModel alloc]init];
}

#pragma mark --- 请求
- (void)requst {
    @weakify(self);
    
    [self.viewModel  setMyrequstBlock:^(ShopModel * model) {
        @strongify(self);
        self.model = model;
        
        [NameSingle shareInstance].name = model.realname; // --- 单例存商家名字
//        [NameSingle shareInstance].role = xzw_model.role;   //  -----   存商家类型
//        [NameSingle shareInstance].mobile = xzw_model.mobile;
//        [NameSingle shareInstance].memberid = xzw_model.memberid;
        self.headView.model = model;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    [self.viewModel setMyrequstErrorBlock:^{
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
    }];
    [self.viewModel myRequst];
}

- (void)addSubViews{
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHiddenshadowImage = YES;
    if (MmberidStr) {
        [self requst];
    }
    self.isHiddenshadowImage = YES;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isHiddenshadowImage = NO;

}
#pragma mark --- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return TableViewCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
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
