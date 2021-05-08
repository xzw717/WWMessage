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
#import "HintView.h"
@interface StoreManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *storeManagementTableView;
@property (nonatomic, strong) NSMutableArray <NSString *>*cellTitleArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*cellImageArray;
@property (nonatomic, assign) NSInteger peugeotid;
@property (nonatomic, strong) StoreInfoModel *infoModel;
@property (nonatomic, assign) NSInteger rolecheckstate;
/// 失败原因
@property (nonatomic, strong) NSString *reason;
/// 合同地址
@property (nonatomic, strong) NSString *signUrl;

@end

@implementation StoreManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"店铺管理";
    self.cellTitleArray = [NSMutableArray array];
    self.cellImageArray = [NSMutableArray array];
    
    [self.view addSubview:self.storeManagementTableView];
 
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @weakify(self);
    [StoreInfoViewModel requstStoreInfoWithModel:^(StoreInfoModel * _Nonnull model) {
        @strongify(self);
        self.infoModel = model;
        if (self.infoModel.pactCount ==  0) {
            [self.cellTitleArray addObject:@"更新信息"];
            [self.cellImageArray addObject:@"icon_Updateinformation"];
        }
        [self.storeManagementTableView reloadData];
    }];
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetShopUpgradeStateInterface];
    
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"shopid":Shopid} complete:^(NSDictionary *dic) {
        self.reason = [dic[@"resultMsg"][@"rolecheckremark"] stringByReplacingOccurrencesOfString:@"_&_" withString:@"\n"];
        self.rolecheckstate = [dic[@"resultMsg"][@"rolecheckstate"] integerValue];
        self.signUrl = dic[@"resultMsg"][@"signUrl"];
        [self.storeManagementTableView reloadData];
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    [self setdataSource];
}
/// 设置数据源
- (void)setdataSource {
    if ([NameSingle shareInstance].peugeotid == 6) {
        if ([LlockedDuration integerValue] == 7 ||([Ttypeid integerValue] == 15 && [LlockedDuration integerValue] == 6)) {
            self.cellTitleArray = [NSMutableArray arrayWithArray:@[@"基本信息",
                                                                   @"合同管理",
                                                                   @"商品发布",
                                                                   @"员工管理"]];
            
            self.cellImageArray = [NSMutableArray arrayWithArray:@[@"icon_essentialinformation",
                                                                   @"icon_contractmanagement",
                                                                   @"icon_Productrelease",
                                                                   @"icon_Employeemanagement"]];
        }else{
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
        }
        
        
    } else {
        if ([LlockedDuration integerValue] == 7 ||([Ttypeid integerValue] == 15 && [LlockedDuration integerValue] == 6)) {
            self.cellTitleArray = [NSMutableArray arrayWithArray:@[@"基本信息",
                                                                   @"合同管理",
                                                                   @"商品发布"]];
            
        }else{
            self.cellTitleArray = [NSMutableArray arrayWithArray:@[@"基本信息",
                                                                   @"合同管理",
                                                                   @"升级管理",
                                                                   @"商品发布"]];
            
        }
        self.cellImageArray = [NSMutableArray arrayWithArray:@[@"icon_essentialinformation",
                                                               @"icon_contractmanagement",
                                                               @"icon_Upgrademanagement",
                                                               @"icon_Productrelease"]];
    }
    
    
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
        cell.detailTextLabel.text= [NSString stringWithFormat:@"%ld",(long)self.infoModel.pactCount + (long)self.infoModel.stayPactCount];
        
    }
    if ([self.cellTitleArray[indexPath.row] isEqualToString:@"更新信息"]) {
        
        
        if (self.rolecheckstate == 9999) {
            cell.detailTextLabel.text= @"去签署合同";
            
        } else if (self.rolecheckstate == 1001) {
            cell.detailTextLabel.text= @"审核失败";
            
        } else if (self.rolecheckstate == 1000 || self.rolecheckstate == 6666) {
            cell.detailTextLabel.text= @"去更新";
            
        } else if (self.rolecheckstate != 1000 && self.rolecheckstate != 1001) {
            cell.detailTextLabel.text= @"审核中";
            
        }
    }
    if (indexPath.row == self.cellTitleArray.count - 1) {
        cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, MAXFLOAT);
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *titleStr =  self.cellTitleArray[indexPath.row];
    if ([titleStr isEqualToString:@"基本信息"] ||[titleStr isEqualToString:@"商品发布"] ) {
        BasicInformationViewController *BIVC = [[BasicInformationViewController alloc]initWithTitle:self.cellTitleArray[indexPath.row]];
        [self.navigationController pushViewController:BIVC animated:YES];
    }
    if ([titleStr isEqualToString:@"升级管理"] ) {
        HQJWebViewController *webvc = [[HQJWebViewController alloc]init];
        webvc.webTitleString = @"升级管理";
        webvc.zwNavView.hidden = YES;
        webvc.webUrlStr = [NSString  stringWithFormat:@"%@%@?shopid=%@",HQJBH5UpDataDomain
                           ,HQJBUpgradeRuleInterface,Shopid];
        [self.navigationController pushViewController:webvc animated:YES];
    }
    if ([titleStr isEqualToString:@"合同管理"]) {
        ContactManagerViewController *cMVC = [[ContactManagerViewController alloc]initWithContactType:NO];
        [self.navigationController pushViewController:cMVC animated:YES];
    }
    if ([titleStr isEqualToString:@"员工管理"]) {
        StaffManageViewController *sMvc = [[StaffManageViewController alloc]init];
        [self.navigationController pushViewController:sMvc animated:YES];
    }
    if ([titleStr isEqualToString:@"更新信息"]) {
        
        if (self.rolecheckstate == 9999) {
            HQJWebViewController *webVC = [[HQJWebViewController alloc]init];
            webVC.webUrlStr = self.signUrl;
            [self.navigationController pushViewController:webVC animated:YES];
        } else if(self.rolecheckstate == 1001) {
            [HintView enrichSubviews:[NSString stringWithFormat:@"%@",self.reason] andSureTitle:@"修改" cancelTitle:@"取消" sureAction:^{
                [ManagerEngine jumpShopManageH5:YES];
            }];
        } else if (self.rolecheckstate == 1000 || self.rolecheckstate == 6666) {
            [ManagerEngine jumpShopManageH5:YES];
            
        }
        
    }
}
@end
