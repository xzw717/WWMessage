//
//  IntegralManagementViewController.m
//  HQJBusiness
//
//  Created by Ethan on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "IntegralManagementViewController.h"
#import "RewardsRecordViewController.h"

@interface IntegralManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *integralManagementTableView;
@end

@implementation IntegralManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"积分管理";
    [self.view addSubview:self.integralManagementTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"会员消费奖励积分";
        
    } else {
        cell.textLabel.text = @"XD商家活动积分";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardsRecordViewController *vc = [[RewardsRecordViewController alloc]init];
    vc.isMembersRewards =  indexPath.row == 0 ? YES : NO;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (UITableView *)integralManagementTableView {
    if (!_integralManagementTableView) {
        _integralManagementTableView = [[UITableView alloc]init];
        _integralManagementTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _integralManagementTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _integralManagementTableView.delegate = self;
        _integralManagementTableView.dataSource = self;
        [_integralManagementTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _integralManagementTableView.tableFooterView = [UIView new];
        
    }
    return _integralManagementTableView;
}
@end
