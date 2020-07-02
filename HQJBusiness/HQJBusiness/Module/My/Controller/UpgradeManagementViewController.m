//
//  UpgradeManagementViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/6/16.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UpgradeManagementViewController.h"
#import "UpgradeManagementTableViewCell.h"

@interface UpgradeManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *upgradeTableView;
@end

@implementation UpgradeManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"升级管理";
    [self.view addSubview:self.upgradeTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    UpgradeManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UpgradeManagementTableViewCell class]) forIndexPath:indexPath];
    
    if (indexPath.row == 3) {
        [cell setCellType:indexPath.row contentText:@"【物物地图】APP平台商家分为：物联商家、联盟商家、合作商家和股份商家。商家首次成功入驻默认为“物联商家”。在商家充分了解平台的企业文化及经营模式后，由商家自主申请升级。逐级申请，不可跨级申请 \n物联商家 ---》 联盟商家：\n①、为【物物地图】APP会员提供店铺最低价；\n②、为【物物地图】APP会员提供折扣，最低9.5折；\n联盟商家 ---》 合作商家：\n①、为【物物地图】APP会员提供店铺最低价；\n②、为【物物地图】APP会员提供折扣，最低9.5折；\n③、赠送【物物地图】APP会员RY值；\n合作商家 ---》 股份商家：\n ①、为【物物地图】APP会员提供店铺最低价；\n②、为【物物地图】APP会员提供折扣，最低9.5折；\n③、赠送【物物地图】APP会员RY值；"];

    } else {
        [cell setCellType:indexPath.row contentText:@"测试数据11111111"];

    }
    
    return cell;
    
    
    
    
    
}

- (UITableView *)upgradeTableView {
    if (!_upgradeTableView) {
        _upgradeTableView = [[UITableView alloc]init];
        _upgradeTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _upgradeTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _upgradeTableView.delegate = self;
        _upgradeTableView.dataSource = self;
        _upgradeTableView.backgroundColor = [UIColor whiteColor];
        [_upgradeTableView registerClass:[UpgradeManagementTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UpgradeManagementTableViewCell class])];
        _upgradeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _upgradeTableView.tableFooterView = [UIView new];
        UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 460/3)];
        header.image = [UIImage imageNamed:@"picture"];
        _upgradeTableView.tableHeaderView = header;
    }
    return _upgradeTableView;
}
@end
