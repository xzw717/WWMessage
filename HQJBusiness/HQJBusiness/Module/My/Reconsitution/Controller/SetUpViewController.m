//
//  SetUpViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/3.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetUpViewController.h"
#import "InformationViewController.h"
#import "SetCell.h"
#import "BlueToothVC.h"
#import "SetBindingCell.h"

@interface SetUpViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation SetUpViewController


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self setindexAry:section].count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        SetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SetCell class]) forIndexPath:indexPath];
        cell.textLabel.text = [self setindexAry:indexPath.section][indexPath.row];
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
        if (indexPath.row == 0) {
            SetBindingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SetBindingCell class]) forIndexPath:indexPath];
            cell.textLabel.text = [self setindexAry:indexPath.section][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            HQJLog(@"绑定状态 ：%@",BindingEquipment);
            cell.isHiddenLabel = ![BindingEquipment isEqualToString:@"绑定成功"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
        if (indexPath.row == 1) {
            
            if ([userDefaults objectForKey:@"AutomaticallyPrintOrders"] == nil) {
                cell.setSwitch.on = NO;
                [self setUserDefaults:NO userKey:@"AutomaticallyPrintOrders"];
            } else {
                BOOL a = [[userDefaults objectForKey:@"AutomaticallyPrintOrders"] isEqualToString:@"开"] ? YES : NO;
                cell.setSwitch.on =a;
                
            }
            [cell setClickSwitchBlock:^(BOOL switchBlock) {
                [self setUserDefaults:switchBlock userKey:@"AutomaticallyPrintOrders"];
                HQJLog(@"自动打印订单：%@",switchBlock ? @"开启" : @"关闭");
            }];
        } else if (indexPath.row == 2) {
            if ([userDefaults objectForKey:@"newOrder"] == nil) {
                cell.setSwitch.on = YES;
                
                [self setUserDefaults:YES userKey:@"newOrder"];
            } else {
                BOOL a = [[userDefaults objectForKey:@"newOrder"] isEqualToString:@"开"] ?YES : NO;
                cell.setSwitch.on = a;
            }
            [cell setClickSwitchBlock:^(BOOL switchBlock) {
                [self setUserDefaults:switchBlock userKey:@"newOrder"];
                HQJLog(@"新订单语音提醒：%@",switchBlock ? @"开启" : @"关闭");
                
            }];
        } else if (indexPath.row == 3) {
            if ([userDefaults objectForKey:@"CollectMoney"] == nil) {
                cell.setSwitch.on = YES;
                
                [self setUserDefaults:YES userKey:@"CollectMoney"];
            } else {
                BOOL a = [[userDefaults objectForKey:@"CollectMoney"] isEqualToString:@"开"] ? YES : NO;
                cell.setSwitch.on = a;
            }
            [cell setClickSwitchBlock:^(BOOL switchBlock) {
                [self setUserDefaults:switchBlock userKey:@"CollectMoney"];
                HQJLog(@"收钱到账语音提醒：%@",switchBlock ? @"开启" : @"关闭");
            }];
        }
        return cell;
    } else {
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [self setindexAry:indexPath.section][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            CellLine(cell);
            
        }
        return cell;
    }

}

- (void)setUserDefaults:(BOOL)obj userKey:(NSString *)key {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
    [userDefaults setObject:obj == YES ? @"开" : @"关" forKey:key];
    [userDefaults synchronize];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     if (indexPath.section == 0 && indexPath.row == 0) {
        //        if (![BindingEquipment isEqualToString:@"连接成功"]) {
        
        BlueToothVC * vc =[[BlueToothVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        //        }
    }  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"设置";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginAfter) name:@"changeBonus" object:nil];
    
}

- (void)loginAfter {
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (NSArray *)setindexAry:(NSInteger)index {
    if (index == 0) {
        return @[@"绑定打印设备",
                 @"自动打印订单",
                 @"新订单语音提醒",
                 @"收钱到账语音提醒"];
    } else {
        return @[@"版本"];
    }
    
}

-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 2;
        _tableView.sectionHeaderHeight = 2;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[SetCell class] forCellReuseIdentifier:NSStringFromClass([SetCell class])];
        [_tableView registerClass:[SetBindingCell class] forCellReuseIdentifier:NSStringFromClass([SetBindingCell class])];
        
        
        _tableView.tableFooterView = [UIView new];
        
    }
    
    return _tableView;
}


@end
