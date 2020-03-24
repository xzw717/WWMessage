//
//  PersonInfoViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopInfoViewController.h"

#import "ShopInfoCell.h"
#import "ShopInfoImageCell.h"
#import "ShopInfoTextCell.h"
#import "ShopInfoSetCell.h"
#import "ShopInfoViewModel.h"

#define TableViewCellMinHeight 60.f


#define TableViewCellMaxHeight 200.f

@interface ShopInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)ShopInfoViewModel *viewModel;
@end

@implementation ShopInfoViewController



-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[ShopInfoCell class] forCellReuseIdentifier:NSStringFromClass([ShopInfoCell class])];
        [_tableView registerClass:[ShopInfoImageCell class] forCellReuseIdentifier:NSStringFromClass([ShopInfoImageCell class])];
        [_tableView registerClass:[ShopInfoTextCell class] forCellReuseIdentifier:NSStringFromClass([ShopInfoTextCell class])];
        [_tableView registerClass:[ShopInfoSetCell class] forCellReuseIdentifier:NSStringFromClass([ShopInfoSetCell class])];
        
    }
    
    return _tableView;
}

- (ShopInfoViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[ShopInfoViewModel alloc]initWithViewContoller:self];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"基本信息";
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(0, 0, 50, 30);
    saveButton.backgroundColor = [UIColor whiteColor];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.layer.masksToBounds = YES;
    saveButton.layer.cornerRadius = 15.f;
    [saveButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:40.f/3];
    @weakify(self);
    [saveButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
        [self saveShopInfo];

    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = barRightItem;
    
    
    [self addSubViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarBlue;
}
- (void)addSubViews{
    [self.view addSubview:self.tableView];
}

#pragma mark --- UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.viewModel.cellDataArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.cellDataArray[section] count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 0;
    return 40.f/3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 3) return TableViewCellMinHeight;
    return TableViewCellMaxHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel cellManageWithTableView:tableView cellForRowAtIndexPath:indexPath];

}

#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel selectCellForIndex:indexPath];
}


- (void)saveShopInfo{
    [self.viewModel updateShopInformation];
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
