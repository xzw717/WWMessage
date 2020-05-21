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
#import "ContactManagerViewController.h"
@interface XDShopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *xdShopTableView;
@property (nonatomic, strong) NSArray <NSString *>*titleArray;

@end

@implementation XDShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.zw_title = @"XD商家";
    self.titleArray = @[@"企业基础信息",@"XD商家合同",@"XD商家服务费用"];
    [self.view addSubview:self.xdShopTableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
           
    return self.titleArray.count;
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDShopTableViewCell class]) forIndexPath:indexPath];
    [cell setTitle:self.titleArray[indexPath.row]];
    if (indexPath.row == 0) {
        [cell setSubTitle:@"未填写"];
    }
    return cell;
    
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController popToRootViewControllerAnimated:NO];
          AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
          UITabBarController *tabViewController = (UITabBarController *) appDelegate.window.rootViewController;
          [tabViewController setSelectedIndex:3];
    } else if (indexPath.row == 1) {
        ContactManagerViewController *cmvc = [[ContactManagerViewController alloc]init];
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
