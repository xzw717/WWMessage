//
//  DealViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DealViewController.h"
#import "CashSalesViewController.h"
#import "BonusExchangeViewController.h"
#import "BuyZHViewController.h"
#import "SetZHViewController.h"
#import "NewWithdrawViewController.h"

@interface DealViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *dealTableView;
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation DealViewController
-(UITableView *)dealTableView {
    if ( _dealTableView == nil ) {
        _dealTableView = [[UITableView alloc]init];
        _dealTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _dealTableView.backgroundColor = DefaultBackgroundColor;
        _dealTableView.delegate = self;
        _dealTableView.dataSource = self;
        
        _dealTableView.scrollEnabled = NO;
        //        [_dealTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        footerView.backgroundColor = DefaultBackgroundColor;
        
        _dealTableView.tableFooterView = footerView;
        
        
        
        [self.view addSubview:_dealTableView];
    }
    
    
    return _dealTableView;
}

-(NSArray *)titleArray {
    if ( _titleArray == nil ) {
        if ([[NameSingle shareInstance].role containsString:@"股份"]||[[NameSingle shareInstance].role containsString:@"命运"]) {
            _titleArray = @[@[@"现金销售",
                              @"积分兑现",
                              @"预约积分兑现",
                              @"现金提现"],
                            @[[NSString stringWithFormat:@"购买%@值",HQJValue]]];
            
        } else if ([[NameSingle shareInstance].role containsString:@"合作"]) {
            _titleArray = @[@[@"现金销售",
                              @"现金提现",
                              @"预约积分兑现"],
                            @[[NSString stringWithFormat:@"购买%@值",HQJValue]]];
        } else {
            if ([NameSingle shareInstance].peugeotid == 6) {
                _titleArray = @[@[@"现金销售",
                                  @"现金提现",
                                  @"预约积分兑现"],
                                  @[[NSString stringWithFormat:@"购买%@值",HQJValue]]];
                
            } else {
                _titleArray = @[@[@"现金提现"],@[@"预约积分兑现"]];
                
            }
        }
    }
    return _titleArray;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = DefaultBackgroundColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.titleArray.count == 1) {
        return 1;
    }else {
        if (section == 0) {
            NSArray *arry = self.titleArray[0];
            return arry.count;
        } else {
            NSArray *arrys = self.titleArray[1];
            
            return arrys.count;
            
        }
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellID = @"cellid";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
        cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HQJLog(@"[NameSingle shareInstance].role = %@",[NameSingle shareInstance].role);

    if ([[NameSingle shareInstance].role containsString:@"股份"]||[[NameSingle shareInstance].role containsString:@"命运共同体"]) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            CashSalesViewController * CVC = [[CashSalesViewController alloc]init];
            [self.navigationController pushViewController:CVC animated:YES];
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            BonusExchangeViewController *BVC = [[BonusExchangeViewController alloc]init];
            BVC.ViewControllerTitle = @"积分兑现";
            [self.navigationController pushViewController:BVC animated:YES];
        } else if (indexPath.section == 0 && indexPath.row == 2){
            if ([CanUseBookScore isEqualToString:@"YES"]) {
                BonusExchangeViewController *BVC = [[BonusExchangeViewController alloc]init];
                BVC.ViewControllerTitle = @"预约积分兑现";
                [self.navigationController pushViewController:BVC animated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"暂无权限"];
            }
        } else if (indexPath.section == 0 && indexPath.row == 3){
            NewWithdrawViewController *BVC = [[NewWithdrawViewController alloc]init];
            //            BVC.ViewControllerTitle = @"现金提现";
            [self.navigationController pushViewController:BVC animated:YES];
            

        } else if (indexPath.section == 1 && indexPath.row == 0){
            
            
            BuyZHViewController *buyVC = [[BuyZHViewController alloc]init];
            [self.navigationController pushViewController:buyVC animated:YES];
            
            
        } else {
            
            SetZHViewController *SVC = [[SetZHViewController alloc]init];
            
            [self.navigationController pushViewController:SVC animated:YES];
            
            
        }
        
        

    } else if ([[NameSingle shareInstance].role containsString:@"合作商家"]) {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            CashSalesViewController * CVC = [[CashSalesViewController alloc]init];
            [self.navigationController pushViewController:CVC animated:YES];
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            NewWithdrawViewController *BVC = [[NewWithdrawViewController alloc]init];
            //            BVC.ViewControllerTitle = @"现金提现";
            [self.navigationController pushViewController:BVC animated:YES];
        } else if (indexPath.section == 0 && indexPath.row == 2){
            if ([CanUseBookScore isEqualToString:@"YES"]) {
                BonusExchangeViewController *BVC = [[BonusExchangeViewController alloc]init];
                BVC.ViewControllerTitle = @"预约积分兑现";
                [self.navigationController pushViewController:BVC animated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"暂无权限"];
            }
        }  else if (indexPath.section == 1 && indexPath.row == 0){
            
            
            BuyZHViewController *buyVC = [[BuyZHViewController alloc]init];
            [self.navigationController pushViewController:buyVC animated:YES];
            
            
        } else {
            
            SetZHViewController *SVC = [[SetZHViewController alloc]init];
            
            [self.navigationController pushViewController:SVC animated:YES];
            
            
        }
        
    } else {
        if ([NameSingle shareInstance].peugeotid == 6) {
            if (indexPath.section == 0 && indexPath.row == 0) {
                CashSalesViewController * CVC = [[CashSalesViewController alloc]init];
                [self.navigationController pushViewController:CVC animated:YES];
            } else if (indexPath.section == 0 && indexPath.row == 1) {
                NewWithdrawViewController *BVC = [[NewWithdrawViewController alloc]init];
                //            BVC.ViewControllerTitle = @"现金提现";
                [self.navigationController pushViewController:BVC animated:YES];
            } else if (indexPath.section == 0 && indexPath.row == 2){
                if ([CanUseBookScore isEqualToString:@"YES"]) {
                    BonusExchangeViewController *BVC = [[BonusExchangeViewController alloc]init];
                    BVC.ViewControllerTitle = @"预约积分兑现";
                    [self.navigationController pushViewController:BVC animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"暂无权限"];
                }
            } else if (indexPath.section == 1 && indexPath.row == 0){
                
                
                BuyZHViewController *buyVC = [[BuyZHViewController alloc]init];
                [self.navigationController pushViewController:buyVC animated:YES];
                
                
            } else {
                
                SetZHViewController *SVC = [[SetZHViewController alloc]init];
                
                [self.navigationController pushViewController:SVC animated:YES];
                
                
            }
            
            
            
        } else {
            if (indexPath.section == 0 && indexPath.row == 0) {
                NewWithdrawViewController *BVC = [[NewWithdrawViewController alloc]init];
                [self.navigationController pushViewController:BVC animated:YES];
            }else{
                if ([CanUseBookScore isEqualToString:@"YES"]) {
                    BonusExchangeViewController *BVC = [[BonusExchangeViewController alloc]init];
                    BVC.ViewControllerTitle = @"预约积分兑现";
                    [self.navigationController pushViewController:BVC animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"暂无权限"];
                }
            }
        }
      
    }
    
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"交易";
    self.view.backgroundColor = DefaultBackgroundColor;
    [self.dealTableView reloadData];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    
}
//-(BOOL)backOnAnInterface {
//   return  [super backOnAnInterface];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
