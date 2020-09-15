//
//  IntegralManagementViewController.m
//  HQJBusiness
//
//  Created by Ethan on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "IntegralManagementViewController.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
    
    
    
    
    
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
