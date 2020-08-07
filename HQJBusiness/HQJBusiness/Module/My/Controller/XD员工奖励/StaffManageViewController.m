//
//  StaffManageViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/27.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//


#import "StaffManageViewController.h"
#import "BasicInformationViewController.h"
#import "UpgradeManagementViewController.h"
#import "HQJWebViewController.h"
#import "ContactManagerViewController.h"
#import "StoreInfoViewModel.h"
#import "StoreInfoModel.h"
#import "MemberStaffListViewController.h"
#import "StaffRoleViewController.h"
#import "RewardsRecordViewController.h"
#import "RewardSetViewController.h"

@interface StaffManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *staffManagementTableView;
@property (nonatomic, strong) NSMutableArray <NSString *>*cellTitleArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*cellImageArray;

@property (nonatomic, strong) StoreInfoModel *infoModel;
@end

@implementation StaffManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"员工管理";

    self.cellTitleArray = [NSMutableArray arrayWithArray:@[@"员工列表",
                                                           @"员工角色",
                                                           @"商家会员",
                                                           @"奖励记录",
                                                           @"奖励设置"]];
    self.cellImageArray = [NSMutableArray arrayWithArray:@[@"icon_Employeelist",
                                                           @"icon_Employeerole",
                                                           @"icon_StoreVIP",
                                                           @"icon_Rewardrecord",
                                                           @"icon_Rewardsettings"]];

    [self.view addSubview:self.staffManagementTableView];
//    @weakify(self);
//    [StoreInfoViewModel requstStoreInfoWithModel:^(StoreInfoModel * _Nonnull model) {
//        @strongify(self);
//        self.infoModel = model;
//        [self.staffManagementTableView reloadData];
//    }];
}

- (UITableView *)staffManagementTableView {
    if (!_staffManagementTableView) {
        _staffManagementTableView = [[UITableView alloc]init];
        _staffManagementTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);;
        _staffManagementTableView.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
        _staffManagementTableView.delegate = self;
        _staffManagementTableView.dataSource = self;
        [_staffManagementTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _staffManagementTableView.tableFooterView = [UIView alloc];
        
    }
    return _staffManagementTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.cellTitleArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.cellTitleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:self.cellImageArray[indexPath.row]];
//    if (indexPath.row == 0) {
//        cell.detailTextLabel.text= self.infoModel.state == 0 ? @"未完善" : @"已完善";
//
//    } else if (indexPath.row == 1) {
//        cell.detailTextLabel.text= [NSString stringWithFormat:@"%ld",(long)self.infoModel.pactCount];
//
//    }
    if (indexPath.row == self.cellTitleArray.count - 1) {
        cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
 
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ) {
        MemberStaffListViewController *biVC = [[MemberStaffListViewController alloc]initWithListStyle:stafflistStyle];
        [self.navigationController pushViewController:biVC animated:YES];
    }
    if (indexPath.row == 1) {
        StaffRoleViewController *addRoleVC = [[StaffRoleViewController alloc]init];
        [self.navigationController pushViewController:addRoleVC animated:YES];
    }
    if (indexPath.row == 2) {
        MemberStaffListViewController *biVC = [[MemberStaffListViewController alloc]initWithListStyle:memberListStle];
        [self.navigationController pushViewController:biVC animated:YES];
    }
    if (indexPath.row == 3) {
        RewardsRecordViewController *rewardsRecordVC = [[RewardsRecordViewController alloc]init];
        [self.navigationController pushViewController:rewardsRecordVC animated:YES];
    }
    if (indexPath.row == 4) {
        RewardSetViewController *addRoleVC = [[RewardSetViewController alloc]init];
        [self.navigationController pushViewController:addRoleVC animated:YES];
    }
}
@end


