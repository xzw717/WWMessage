//
//  XDShopViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDShopViewController.h"
#import "XDShopTableViewCell.h"
#import "HQJWebViewController.h"
#import "AppDelegate.h"
#import "XDShopServiceManagementViewController.h"
#import "HQJWebViewController.h"
#import "ContactManagerViewController.h"
#import "MyViewModel.h"
@interface XDShopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *xdShopTableView;
@property (nonatomic, strong) NSArray <NSString *>*titleArray;
@property (nonatomic, assign) NSInteger state;  /// 状态（0.成功 1.待审核 2.已提交 3.已拒绝）
@property (nonatomic, strong) NSString *failreason; /// 失败原因
@property (nonatomic, strong) NSString *peugeotid; /// XD 商家类型
@end

@implementation XDShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zw_title = @"XD商企";
    self.titleArray = @[@"企业基础信息",@"XD商企合同",@"XD商企服务费用"];
    [self.view addSubview:self.xdShopTableView];
    self.state = 0;
    [self requstState];
}

- (void)requstState {
    [MyViewModel getXdShopAuditWithCompletion:^(NSDictionary *dict) {
        self.state = [dict[@"type"] integerValue];
        self.failreason = dict[@"failreason"];
        self.peugeotid = dict[@"peugeotid"];
        [self.xdShopTableView reloadData];
    }];
}


- (void)jumpH5 {
    
    HQJWebViewController *webVC = [[HQJWebViewController alloc]init];
    webVC.zwNavView.hidden = YES;
    //    webVC.webUrlStr = @"http://120.26.53.18/#/test";
    webVC.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&mobile=%@&type=%@&peugeotid=%@",HQJBH5UpDataDomain,HQJBXdshopmsgInterface,Shopid,Mmobile,@(self.state),self.peugeotid];
    [self.navigationController pushViewController:webVC animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDShopTableViewCell class]) forIndexPath:indexPath];
    [cell setTitle:self.titleArray[indexPath.row]];
    if (indexPath.row == 0) {
        
        [cell setSubTitle:self.state];
    }
    return cell;
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.state == 1) {
            [self.navigationController popToRootViewControllerAnimated:NO];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarController *tabViewController = (UITabBarController *) appDelegate.window.rootViewController;
            [tabViewController setSelectedIndex:2];
        }  else if (self.state == 2) {
            [self jumpH5];
        }  else if (self.state == 3) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审核失败" message:self.failreason preferredStyle:UIAlertControllerStyleAlert]
            ;
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *changeAction = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self jumpH5];
                
            }];
            [alert addAction:cancelAction];
            [alert addAction:changeAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }  else if (self.state == 4) {
            [self jumpH5];
            
        }
        
        
        
        
        
    } else if (indexPath.row == 1) {
        ContactManagerViewController *cmvc = [[ContactManagerViewController alloc]initWithContactType:YES];
        [self.navigationController pushViewController:cmvc animated:YES];
    } else {
        XDShopServiceManagementViewController *ssmVC = [[XDShopServiceManagementViewController alloc]init];
        [self.navigationController pushViewController:ssmVC animated:YES];
    }
    
    
}

- (UITableView *)xdShopTableView {
    if (!_xdShopTableView) {
        _xdShopTableView = [[UITableView alloc]init];
        _xdShopTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _xdShopTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _xdShopTableView.delegate = self;
        _xdShopTableView.dataSource = self;
        [_xdShopTableView registerClass:[XDShopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XDShopTableViewCell class])];
        _xdShopTableView.tableFooterView = [UIView new];
        
    }
    return _xdShopTableView;
}

@end
