//
//  StoreManagementViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreManagementViewController.h"
#import "BasicInformationViewController.h"
#import "UpgradeManagementViewController.h"
#import "HQJWebViewController.h"
#import "ContactManagerViewController.h"
#import "StoreInfoViewModel.h"
#import "StoreInfoModel.h"
#import "StaffManageViewController.h"

@interface StoreManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *storeManagementTableView;
@property (nonatomic, strong) NSMutableArray <NSString *>*cellTitleArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*cellImageArray;

@property (nonatomic, strong) StoreInfoModel *infoModel;
@end

@implementation StoreManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"店铺管理";
    self.cellTitleArray = [NSMutableArray arrayWithArray:@[@"基本信息",
                                                           @"合同管理",
                                                           @"升级管理",
                                                           @"商品发布",
                                                           @"员工管理"]];
    self.cellImageArray = [NSMutableArray arrayWithArray:@[@"icon_essentialinformation",
                                                           @"icon_contractmanagement",
                                                           @"icon_Upgrademanagement",
                                                           @"icon_Productrelease",
                                                           @"icon_Employeemanagement"]];

    [self.view addSubview:self.storeManagementTableView];
    @weakify(self);
    [StoreInfoViewModel requstStoreInfoWithModel:^(StoreInfoModel * _Nonnull model) {
        @strongify(self);
        self.infoModel = model;
        [self.storeManagementTableView reloadData];
    }];
}

- (UITableView *)storeManagementTableView {
    if (!_storeManagementTableView) {
        _storeManagementTableView = [[UITableView alloc]init];
        _storeManagementTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);;
        _storeManagementTableView.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
        _storeManagementTableView.delegate = self;
        _storeManagementTableView.dataSource = self;
        [_storeManagementTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _storeManagementTableView.tableFooterView = [UIView alloc];
        
    }
    return _storeManagementTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.cellTitleArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.cellTitleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:self.cellImageArray[indexPath.row]];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text= self.infoModel.state == 0 ? @"未完善" : @"已完善";

    } else if (indexPath.row == 1) {
        cell.detailTextLabel.text= [NSString stringWithFormat:@"%ld",(long)self.infoModel.pactCount];

    }
    if (indexPath.row == self.cellTitleArray.count - 1) {
        cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
 
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 3) {
        BasicInformationViewController *BIVC = [[BasicInformationViewController alloc]initWithTitle:self.cellTitleArray[indexPath.row]];
        [self.navigationController pushViewController:BIVC animated:YES];
    }
    if (indexPath.row == 2) {
        HQJWebViewController *webvc = [[HQJWebViewController alloc]init];
        webvc.webTitleString = @"升级规则";
        webvc.zwNavView.hidden = YES;
        webvc.webUrlStr = [NSString  stringWithFormat:@"%@%@?shopid=%@",HQJBH5UpDataDomain
                           ,HQJBUpgradeRuleInterface,Shopid];
        [self.navigationController pushViewController:webvc animated:YES];
    }
    if (indexPath.row == 1) {
        ContactManagerViewController *cMVC = [[ContactManagerViewController alloc]initWithContactType:NO];
        [self.navigationController pushViewController:cMVC animated:YES];
    }
    if (indexPath.row == 4) {
        StaffManageViewController *sMvc = [[StaffManageViewController alloc]init];
        [self.navigationController pushViewController:sMvc animated:YES];
    }
}
@end
