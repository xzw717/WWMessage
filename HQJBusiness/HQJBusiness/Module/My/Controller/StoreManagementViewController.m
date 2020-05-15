//
//  StoreManagementViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreManagementViewController.h"
#import "BasicInformationViewController.h"

@interface StoreManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *storeManagementTableView;
@property (nonatomic, strong) NSMutableArray <NSString *>*cellTitleArray;
@end

@implementation StoreManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"店铺管理";
     
    self.view.backgroundColor = DefaultBackgroundColor;
    self.cellTitleArray = [NSMutableArray arrayWithArray:@[@"基本信息",@"合同管理",@"升级管理",@"商品发布"]];
    [self.view addSubview:self.storeManagementTableView];
    
}

- (UITableView *)storeManagementTableView {
    if (!_storeManagementTableView) {
        _storeManagementTableView = [[UITableView alloc]init];
        _storeManagementTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);;
        _storeManagementTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _storeManagementTableView.delegate = self;
        _storeManagementTableView.dataSource = self;
        [_storeManagementTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _storeManagementTableView.tableFooterView = [UIView new];
        
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
    
    if (indexPath.row == 0) {
         cell.detailTextLabel.text=@"去完善";

    } else if (indexPath.row == 1) {
        cell.detailTextLabel.text=@"99";

    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
 
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 3) {
        BasicInformationViewController *BIVC = [[BasicInformationViewController alloc]initWithTitle:self.cellTitleArray[indexPath.row]];
        [self.navigationController pushViewController:BIVC animated:YES];
    }
    
}
@end