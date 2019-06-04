//
//  BlueToothVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BlueToothVC.h"
#import "JWBluetoothManage.h"
#import "MBProgressHUD.h"
@interface BlueToothVC () <UITableViewDataSource,UITableViewDelegate>{
    JWBluetoothManage * manage;
}
#define WeakSelf __block __weak typeof(self)weakSelf = self;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@end

@implementation BlueToothVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蓝牙列表";
    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    [self _createTableView];
    manage = [JWBluetoothManage sharedInstance];
    WeakSelf
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakSelf.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakSelf.rssisArray = [NSMutableArray arrayWithArray:rssis];
        [weakSelf.tableView reloadData];
    } failure:^(CBManagerState status) {
        [ProgressShow alertView:self.view Message:[ProgressShow getBluetoothErrorInfo:status] cb:nil];
    }];
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        weakSelf.title = @"蓝牙列表";
    };
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"icon_back_arrow_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;

}
- (void)backItemClick {
    [manage stopScanPeripheral];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    WeakSelf
    [super viewWillAppear:animated];
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
            weakSelf.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
            [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"] setObject:@"绑定成功" forKey:@"BluetoothState"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
    
}
#pragma mark tableview medthod
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    CBPeripheral *peripherral = [self.dataSource objectAtIndex:indexPath.row];
    if (peripherral.state == CBPeripheralStateConnected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"名称:%@",peripherral.name];
    NSNumber * rssis = self.rssisArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"强度:%@",rssis];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBPeripheral *peripheral = [self.dataSource objectAtIndex:indexPath.row];
    [ProgressShow alertView:self.view Message:@"连接中..." asy:^{
        NSString *bistate = [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"] objectForKey:@"BluetoothState"];
        if (![bistate isEqualToString:@"绑定成功"]) {
            [ProgressShow alertView:self.view Message:@"此打印机已有别的设备连接" cb:nil];
        }
    }];
    [manage connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
            self.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
            [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"] setObject:@"绑定成功" forKey:@"BluetoothState"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadData];
            });
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) _createTableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    if (![self.view.subviews containsObject:_tableView]) {
        [self.view addSubview:_tableView];
    }else{
        [_tableView reloadData];
    }
}



@end
