//
//  ToolVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ToolVC.h"
#import "ToolViewModel.h"
#import "ToolCell.h"

#define TableViewSectionHeight 40.f

#define TableViewCellHeight WIDTH/4

@interface ToolVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ToolViewModel *viewModel;
@end

@implementation ToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}
#pragma mark --- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {

    return TableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TableViewSectionHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel cellManageWithTableView:tableView cellForRowAtIndexPath:indexPath];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return [self.viewModel sectionViewForCell:tableView viewForHeaderInSection:section];
}


#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, NavigationControllerHeight , WIDTH, HEIGHT - NavigationControllerHeight);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[ToolCell class] forCellReuseIdentifier:NSStringFromClass([ToolCell class])];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (ToolViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ToolViewModel alloc]initWithViewContoller:self];
    }
    return _viewModel;
}

@end
