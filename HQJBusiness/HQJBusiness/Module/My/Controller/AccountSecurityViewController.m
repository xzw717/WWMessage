//
//  AccountSecurityViewController.m
//  HQJBusiness
//   账号安全
//  Created by Ethan on 2021/6/9.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AccountSecurityViewController.h"
#import "ShopModel.h"
#import "ShopViewModel.h"
#import "InformationViewController.h"
#import "ForgetPswViewController.h"
#import "ChangePswViewController.h"
#import "ChangeTradePswViewController.h"
#import "PaymentCodeViewController.h"



@interface AccountSecurityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *accountSecurityTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceAry;
@property (nonatomic, strong) ShopViewModel *viewModel;
@end

@implementation AccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"账号安全";
    [self.view addSubview:self.accountSecurityTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceAry[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShopModel *model = self.dataSourceAry[indexPath.section][indexPath.row];
    cell.textLabel.text = model.sp_title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [self.viewModel clickItemWithIndexPath:indexPath dataArray:self.dataSourceAry];
    if (indexPath.row == 0)  {
        if ([[ManagerEngine pswTitleWithType:[ManagerEngine pswType:YES]] isEqualToString:@"设置登录密码"]) {
            ForgetPswViewController *fpVC = [[ForgetPswViewController alloc]init];
            fpVC.isForget = NO;
            [self.navigationController pushViewController:fpVC animated:YES];
        } else {
            ChangePswViewController *ChangePswVC =[[ChangePswViewController alloc]initWithLoginPassWordType:[ManagerEngine pswType:YES]];
            [self.navigationController pushViewController:ChangePswVC animated:YES];
        }
        
        
    } else if (indexPath.row == 1){
        
        ChangeTradePswViewController *CTVC = [[ChangeTradePswViewController alloc]initWithPasswordType:[ManagerEngine pswType:NO]];
        [self.navigationController pushViewController:CTVC animated:YES];
    } else {
        PaymentCodeViewController * PCVC = [[PaymentCodeViewController alloc]init];
        [self.navigationController pushViewController:PCVC animated:YES];
        
    }
}
- (UITableView *)accountSecurityTableView {
    if (!_accountSecurityTableView) {
        _accountSecurityTableView = [[UITableView alloc]init];
        _accountSecurityTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _accountSecurityTableView.delegate = self;
        _accountSecurityTableView.dataSource = self;
        _accountSecurityTableView.tableFooterView = [UIView new];
        _accountSecurityTableView.rowHeight = 44.f;
        [_accountSecurityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
    }
    return _accountSecurityTableView;
}
- (NSMutableArray *)dataSourceAry {
    if (!_dataSourceAry) {
        _dataSourceAry = [NSMutableArray array];
        NSArray *rowTitleWithImageArray = [NSArray array];
        if ([[NameSingle shareInstance].role containsString:@"股份"] || [[NameSingle shareInstance].role containsString:@"合作商家"]||[[NameSingle shareInstance].role containsString:@"命运共同体"]) {
            rowTitleWithImageArray = @[
                @[[[ManagerEngine pswTitleWithType:[ManagerEngine pswType:YES]] isEqualToString:@"设置登录密码"] ?
                  @{@"sp_image":@"",
                    @"sp_title":@"设置登录密码",
                    @"sp_action":@"ForgetPswViewController", @"sp_parameter":@{@"isForget":@(NO)}} : @{@"sp_image":@"",
                                                                                                       @"sp_title":@"修改登录密码",
                                                                                                       @"sp_action":@"ChangePswViewController"},
                  
                  
                  @{@"sp_image":@"",
                    @"sp_title":@"修改交易密码",
                    @"sp_action":@"ChangeTradePswViewController"},
             
                  
                  @{@"sp_image":@"",
                    @"sp_title":@"收款码管理",
                    @"sp_action":@"PaymentCodeViewController"}],
            ];
        } else {
            rowTitleWithImageArray = @[
                @[[[ManagerEngine pswTitleWithType:[ManagerEngine pswType:YES]] isEqualToString:@"设置登录密码"] ?
                  @{@"sp_image":@"",
                    @"sp_title":@"设置登录密码",
                    @"sp_action":@"ForgetPswViewController", @"sp_parameter":@{@"isForget":@(NO)}} : @{@"sp_image":@"",
                                                                                                       @"sp_title":@"修改登录密码",
                                                                                                       @"sp_action":@"ChangePswViewController"},
                  
                  
                  @{@"sp_image":@"",
                    @"sp_title":@"修改交易密码",
                    @"sp_action":@"ChangeTradePswViewController"}],
            ];
        }
   
        
        [rowTitleWithImageArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *allData = [NSMutableArray array];
            allData = [ShopModel mj_objectArrayWithKeyValuesArray:obj];
            [_dataSourceAry addObject:allData];
            
            
        }];
        
    }
    return _dataSourceAry;
}
- (ShopViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShopViewModel alloc]init];
    }
    return _viewModel;
}
@end
