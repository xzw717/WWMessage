//
//  MessageVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ContactManagerViewController.h"
#import "PersonInfoCell.h"
#import "ShopManagerCell.h"
#import "ContactManagerHeadView.h"

#define TableViewCellHeight 140.f/3
#define HeadHeight  132/3.f
#define TableViewTopSpace 40/3.f
@interface ContactManagerViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, assign) NSInteger topTag;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ContactManagerHeadView *headView;

@end

@implementation ContactManagerViewController

-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[PersonInfoCell class] forCellReuseIdentifier:NSStringFromClass([PersonInfoCell class])];
        [_tableView registerClass:[ShopManagerCell class] forCellReuseIdentifier:NSStringFromClass([ShopManagerCell class])];
        
    }
    
    return _tableView;
}

- (ContactManagerHeadView *)headView{
    if (_headView == nil) {
        _headView = [[ContactManagerHeadView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HeadHeight) andTitleArray:@[@"已签合同",@"待签合同",@"更新申请"]];
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
    self.title = @"合同管理";
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
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonInfoCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"商家合同";
    return cell;
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
