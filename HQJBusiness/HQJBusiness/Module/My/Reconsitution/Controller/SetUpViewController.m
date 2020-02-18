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
#import "MineLogoutCell.h"
#import "JPUSHService.h"
#import "LoginViewController.h"

#import "AppDelegate.h"
@interface SetUpViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation SetUpViewController

-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 2;
        _tableView.sectionHeaderHeight = 2;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[SetCell class] forCellReuseIdentifier:NSStringFromClass([SetCell class])];
        [_tableView registerClass:[SetBindingCell class] forCellReuseIdentifier:NSStringFromClass([SetBindingCell class])];
        [_tableView registerClass:[MineLogoutCell class] forCellReuseIdentifier:NSStringFromClass([MineLogoutCell class])];
        
        _tableView.tableFooterView = [UIView new];
        
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
    
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
    } else if (indexPath.section == 1) {
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [self setindexAry:indexPath.section][indexPath.row];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            CellLine(cell);
            
        }
        return cell;
    }else{
        MineLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineLogoutCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    } else{
         [self removeData];
         [self.navigationController popViewControllerAnimated:YES];
         
         LoginViewController *loginVC =[[LoginViewController alloc]init];
         ZWNavigationController *Nav= [[ZWNavigationController alloc]initWithRootViewController:loginVC];
         AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
         
         [UIView transitionWithView:delegate.window
                           duration:0.5
                            options: UIViewAnimationOptionTransitionFlipFromRight
                         animations:^{
                             delegate.window.rootViewController = Nav;
                             
                         }
                         completion:nil];
     }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"设置";
    self.navType = HQJNavigationBarBlue;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarBlue;
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
    } else if (index == 1){
        return @[@"版本"];
    }else{
        return @[@"退出登录"];
    }
    
}
#pragma mark --
#pragma mark --- 删除用户信息
-(void)removeData {
    
    [FileEngine fileRemove:fileLoginStyle];    //  ---用户登录信息
    [FileEngine fileRemove:fileDefaultStyle];  // ---手机号等信息
    [FileEngine fileRemove:fileHomeDataStyle];  // -- 积分信息
    [FileEngine fileRemove:filePathlocationStyle]; // --- 用户类型
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld %@ %ld",iResCode,iAlias,seq);
        if (iResCode) {
            
        }
        
    } seq:1];
    [JPUSHService removeNotification:nil];
}



@end
