//
//  SetViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/21.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetViewController.h"
#import "LoginViewController.h"
#import "InformationViewController.h"
#import "ChangePswViewController.h"
#import "ChangeTradePswViewController.h"
#import "HelpMeViewController.h"
#import "PaymentCodeViewController.h"
#import "AppDelegate.h"
#import "SetCell.h"
#import "BlueToothVC.h"
#import "SetBindingCell.h"

@interface SetViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *setTableView;
@property (nonatomic,strong)NSArray *titleAry;
@property (nonatomic,strong)UILabel *backLoginLabel;
@property (nonatomic,strong)UILabel *versionLabel;
@end

@implementation SetViewController


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 4;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section > 2) return 1;
    return [self setindexAry:section].count;
    
    
    
//    if (section == 0) {
//        return 3;
//    } else if (section == 1) {
//
//        return 3;
//    } else {
//
//        return 1;
//
//    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section !=3) {
        return 10;
    } else {
        
        return 30;
    }
  
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self setindexAry:indexPath.section][indexPath.row];
        /***右侧小箭头***/
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 3) {
             CellLine(cell);
        }
        return cell;

    } else if (indexPath.section == 1) {
      
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
    }  else if (indexPath.section ==2){
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [self setindexAry:indexPath.section][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 2) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
                cell.accessoryType = UITableViewCellAccessoryNone;
                CellLine(cell);
                
            }
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CellLine(cell);
        
        [cell addSubview:self.backLoginLabel];
        
        return cell;

    }
 
    
}

- (void)setUserDefaults:(BOOL)obj userKey:(NSString *)key {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
    [userDefaults setObject:obj == YES ? @"开" : @"关" forKey:key];
    [userDefaults synchronize];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            InformationViewController *IFVC =[[InformationViewController alloc]init];
            [self.navigationController pushViewController:IFVC animated:YES];
            
        }else if (indexPath.row == 1)  {

            ChangePswViewController *ChangePswVC =[[ChangePswViewController alloc]init];
            [self.navigationController pushViewController:ChangePswVC animated:YES];
        
        } else if (indexPath.row == 2){
            ChangeTradePswViewController *CTVC = [[ChangeTradePswViewController alloc]init];
            CTVC.pswType = 2;
            [self.navigationController pushViewController:CTVC animated:YES];
        } else {
            PaymentCodeViewController * PCVC = [[PaymentCodeViewController alloc]init];
            [self.navigationController pushViewController:PCVC animated:YES];

        }
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
//        if (![BindingEquipment isEqualToString:@"连接成功"]) {
        
            BlueToothVC * vc =[[BlueToothVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
//        }
    } else if (indexPath.section== 2) {
        
        if (indexPath.row != 2) {
            HelpMeViewController *Hvc = [[HelpMeViewController alloc]init];
            
            switch (indexPath.row) {
                case 0:
                    Hvc.SetWEBStr =@"www.chenjianping.com/Application/HQJ/View/Seller/sysInforms.html";
                    
                    Hvc.titleNameStr =@"系统通知";
                    
                    break;
                case 1:
                    Hvc.SetWEBStr =@"www.chenjianping.com/Application/HQJ/View/Seller/helFeed.html";
                    Hvc.titleNameStr =@"帮助与反馈";
                    break;
                    
                default:
                    break;
            }
            [self.navigationController pushViewController:Hvc animated:YES];
        }
        
    } else if (indexPath.section== 3){
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

#pragma mark --
#pragma mark --- 删除用户信息
-(void)removeData {
    
    [FileEngine fileRemove:fileLoginStyle];    //  ---用户登录信息
    [FileEngine fileRemove:fileDefaultStyle];  // ---手机号等信息
    [FileEngine fileRemove:fileHomeDataStyle];  // -- 积分信息
    [FileEngine fileRemove:filePathlocationStyle]; // --- 用户类型
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.setTableView];
    self.zw_title = @"设置";

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.setTableView reloadData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginAfter) name:@"changeBonus" object:nil];
    
}

- (void)loginAfter {
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (NSArray *)setindexAry:(NSInteger)index {
    if (index == 0) {
        if ([[NameSingle shareInstance].role isEqualToString:@"股份商家"] || [[NameSingle shareInstance].role isEqualToString:@"合作商家"]||[[NameSingle shareInstance].role isEqualToString:@"命运共同体"]) {
            return @[@"个人信息",
                     @"登录密码修改",
                     @"交易密码修改",
                     @"收款码设置"];
        } else {
            return @[@"个人信息",
                     @"登录密码修改",
                     @"交易密码修改"];
        }
     
    } else if (index == 1) {
        return @[@"绑定打印设备",
                 @"自动打印订单",
                 @"新订单语音提醒",
                 @"收钱到账语音提醒"];
    } else if (index == 2) {
        return @[@"系统通知",
                 @"帮助与反馈",
                 @"版本"];
    } else {
        return nil;
    }
    
}

#pragma mark --
#pragma mark --- 去修改密码界面
-(void)goChangePswTitle:(NSString *)tit{
//    ChangePswViewController *CVC = [[ChangePswViewController alloc]init];
//    CVC.title = tit;
//    [self.navigationController pushViewController:CVC animated:YES];
}


-(UITableView *)setTableView {
    if (!_setTableView) {
    
        _setTableView = [[UITableView alloc]init];
        _setTableView.frame = CGRectMake(0, kNAVHEIGHT, WIDTH, HEIGHT - kNAVHEIGHT);
        _setTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _setTableView.delegate = self;
        
        _setTableView.dataSource = self;
        _setTableView.sectionFooterHeight = 2;
        _setTableView.sectionHeaderHeight = 2;
        [_setTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_setTableView registerClass:[SetCell class] forCellReuseIdentifier:NSStringFromClass([SetCell class])];
        [_setTableView registerClass:[SetBindingCell class] forCellReuseIdentifier:NSStringFromClass([SetBindingCell class])];


        _setTableView.tableFooterView = [UIView new];
        
    }
    
    return _setTableView;
}

-(UILabel *)backLoginLabel {
    if (!_backLoginLabel) {
        _backLoginLabel = [[UILabel alloc]init];
        _backLoginLabel.font = [UIFont systemFontOfSize:17];
        _backLoginLabel.frame = CGRectMake(0, 0, WIDTH, 44);
        _backLoginLabel.textColor = [UIColor redColor];
        _backLoginLabel.text = @"退出登录";
        _backLoginLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _backLoginLabel;
}

-(UILabel *)versionLabel {
    
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc]init];
        _versionLabel.font = [UIFont systemFontOfSize:12];
        _versionLabel.textColor = [ManagerEngine getColor:@"999999"];
        _versionLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        
        
    }
    
    
    return _versionLabel;
}
@end
