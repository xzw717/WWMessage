//
//  StoreInformationViewController.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/10.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreInformationViewController.h"
#import "StoreInformationCell.h"
@interface StoreInformationViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *storeInformationTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation StoreInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"店铺信息";
    [self.view addSubview:self.storeInformationTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreInformationCell class]) forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];;
    cell.informationDataDict = dict;
    return cell;
}
- (UITableView *)storeInformationTableView {
    if (!_storeInformationTableView) {
        _storeInformationTableView = [[UITableView alloc]init];
        _storeInformationTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _storeInformationTableView.delegate = self;
        _storeInformationTableView.dataSource = self;
        _storeInformationTableView.rowHeight = 55;
        _storeInformationTableView.tableFooterView = [UIView new];
        [_storeInformationTableView registerClass:[StoreInformationCell class] forCellReuseIdentifier:NSStringFromClass([StoreInformationCell class])];
    }
    return _storeInformationTableView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[
                                                      @{@"店铺名称":[NameSingle shareInstance].name},
                                                      @{@"店铺类型":[NameSingle shareInstance].role},
                                                      @{@"联系方式":[NameSingle shareInstance].mobile}]];
//        @{@"店铺logo":@""},  @{@"店铺分类":@"美食"},
    }
    return _dataArray;
}
@end
