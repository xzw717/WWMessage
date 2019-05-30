//
//  BlueToothVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BlueToothVC.h"
#import "JWBluetoothManage.h"

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
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)printe{
    if (manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"物物地图";
    NSString *str2 = @"Wuwu Map";
    NSString *str3 = @"订单详情";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendText:str2 alignment:HLTextAlignmentCenter];
    [printer appendText:str3 alignment:HLTextAlignmentCenter];
    [printer appendSeperatorLine];
    
    [printer appendText:@"用户信息" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendText:@"130******890" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendSeperatorLine];
    
    [printer appendText:@"订单详情" alignment:HLTextAlignmentLeft];
    [printer appendLeftText:@"假装我是一个方便面" middleText:@"x109" rightText:@"99999.99" isTitle:NO];
    //    [printer appendNewLine];
    
    [printer appendLeftText:@"飞流直下三千尺，疑似银河落九天999999999999999999999999999999999999" middleText:@"x109" rightText:@"889.99" isTitle:NO];
    //    [printer appendNewLine];
    
    [printer appendLeftText:@"上海许氏专用订单一条" middleText:@"x109" rightText:@"9.09" isTitle:NO];
    //    [printer appendNewLine];
    
    [printer appendLeftText:@"许某人爱喝的可口可乐" middleText:@"x109" rightText:@"9999.99" isTitle:NO];
    
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"总计商品数" value:@"2"];
    [printer appendTitle:@"金    额" value:@"￥1000"];
    
    [printer appendSeperatorLine];
    [printer appendTitle:@"订单编号" value:@"MS1234567890"];
    [printer appendTitle:@"下单时间" value:@"2017-06-14"];
    [printer appendFooter:@"感谢您选择【物物地图】，欢迎您再次光临!"];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    WeakSelf
    [super viewWillAppear:animated];
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
            weakSelf.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
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
    [manage connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
            self.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
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
