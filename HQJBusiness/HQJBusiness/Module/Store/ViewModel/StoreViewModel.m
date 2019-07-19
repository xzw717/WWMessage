//
//  StoreViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreViewModel.h"
#import "HQJMenu.h"
#import "ScanViewController.h"
#import "FunctionSetVC.h"
#import "StoreMainCell.h"
#import "StoreADCell.h"
#import "DetailViewController.h"
#import "OrderManageVC.h"
#import "GoodsManageVC.h"
#import "MenuModel.h"
#import "MenuManager.h"
#import "ManuallyAddViewController.h"
#import "VerificationOrderDetailsViewController.h"
#import "OrderViewController.h"
#import "GoodsReleaseVC.h"
#import "CatalogueVC.h"
#import "ReleaseRulesVC.h"
#define StoreMenuWidth  130.f;
#define StoreMenuRowHeight  57.f;
#define StoreMenuIconMargin  16.4f;
#define StoreMenuTextMargin  10.f;
#define StoreMenuFont  [UIFont systemFontOfSize:16.f];
#define StoreMenuSeparatorInset  UIEdgeInsetsMake(0, 40, 0, 0);
//C

@interface StoreViewModel()
@property (nonatomic, strong) UIViewController *storeViewModel_self;

@end
@implementation StoreViewModel
- (instancetype)initWithTargetObjct:(id)object
{
    self = [super init];
    if (self) {
        self.storeViewModel_self = object;
        [self storeViewModel_notifi];
    }
    return self;
}
- (void)storeViewModel_notifi {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(operationItem:) name:CreateStoreTreasure object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertView:) name:@"Qrcode" object:nil];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)alertView:(NSNotification *)infos {
    NSInteger  stateCode = [infos.userInfo[@"state"] integerValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (stateCode == -1) {
            [ManagerEngine alertMessage:@"消费码不存在"];
            
        } else if (stateCode == 1) {
            
            VerificationOrderDetailsViewController *vc = [[VerificationOrderDetailsViewController alloc]initWithNavType:HQJNavigationBarWhite orderId:infos.userInfo[@"orderid"] consumerCode:infos.userInfo[@"salecode"]];
            [self.storeViewModel_self.navigationController pushViewController:vc animated:YES];
            
            
            
        } else if (stateCode == 2) {
            
            [ManagerEngine alertMessage:@"已使用"];
            
        } else if (stateCode == 3) {
            
            [ManagerEngine alertMessage:@"已退款"];
            
        } else if (stateCode == 4) {
            
            [ManagerEngine alertMessage:@"已过期"];
        }
        
    });
    
    
}
- (void)operationItem:(NSNotification *)notifi {
    NSString *isHide = notifi.userInfo[@"isHide"];
    if ([isHide isEqualToString:@"开"]) {
        [self.titleAry removeLastObject];
        [self.modelAry removeLastObject];

    } else {
        [self.titleAry addObject:[self openingStoreAry]];
        [self.modelAry addObject:@[]];
    }
    [self.vm_storetableView reloadData];
}

#pragma mark --- 导航控制器菜单
- (void)navMenu:(UIView *)view {
    NSArray *itemTitAry = @[@"扫一扫", @"功能设置"];
    NSArray *itemImgAry = @[@"menu_scan", @"menu_set"];
    [MenuManager menushowForSender:view withMenuArray:itemTitAry imageArray:itemImgAry textAlignment:NSTextAlignmentLeft doneBlock:^(NSInteger selectedIndex) {
        if (selectedIndex == 0) {
            ScanViewController *sVC =[[ScanViewController alloc]init];
            [sVC setDismissBlock:^{
                ManuallyAddViewController *mVC = [[ManuallyAddViewController alloc]initWithNavType:HQJNavigationBarWhite];
                [self.storeViewModel_self.navigationController pushViewController:mVC animated:YES];
            }];
            [self.storeViewModel_self presentViewController:sVC animated:YES completion:nil];
        } else {
            FunctionSetVC *fVC = [[FunctionSetVC alloc]initWithNavType:HQJNavigationBarWhite];
            [self.storeViewModel_self.navigationController pushViewController:fVC animated:YES];
        }
    }];
    

}

#pragma mark --- 剥离控制器中的cell 
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        StoreMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreMainCell class]) forIndexPath:indexPath];
        //        cell.itemAry = .mutableCopy;
        [cell setClickItemblock:^(NSString * _Nonnull title) {
            NSLog(@"你点击了：%@",title);
            if ([title isEqualToString:@"添加商品"]) {
                
                [ManagerEngine goodsRelease];
       
            }
        }];
        cell.titleArray = self.titleAry[indexPath.section];
        cell.itemAry = [self modelAry][indexPath.section];

        return cell;
        
    } else  {
        StoreADCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreADCell class])];
        [cell setClickADButtonBlock:^(NSString * _Nonnull btnTitle) {
            NSLog(@"你点击了：%@",btnTitle);
        }];
        return cell;
    }
}

- (void)selectCellForIndex:(NSIndexPath *)index {
    NSArray *ary = self.titleAry[index.section];
    UIViewController *viewController;
    if ([ary.lastObject isEqualToString:@"交易数据"]) {
       viewController = [[DetailViewController alloc]initWithNavType:HQJNavigationBarWhite];
    } else if ([ary.lastObject isEqualToString:@"订单管理"]) {
        viewController = [[OrderViewController alloc]initWithNavType:HQJNavigationBarWhite];
    } else if ([ary.lastObject isEqualToString:@"商品管理"]) {
      viewController = [[GoodsManageVC alloc]initWithNavType:HQJNavigationBarWhite];
    }
    [self.storeViewModel_self.navigationController pushViewController:viewController animated:YES];

}

- (NSMutableArray *)modelAry {
    if (!_modelAry) {
        BOOL ishide = [[[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  objectForKey:CreateStoreTreasureKey] boolValue];
        if (ishide) {
            _modelAry =@[
                         @[@"今日积分",@"今日现金",@"今日RY值支出"],
                         @[@"今日订单数",@"商品订单",@"收款订单",@"已核销订单",@"待付款",@"待评价",@"待核销订单",@"+"],
                         @[],
                         @[@"出售中",@"已下架",@"草稿中",@"添加商品"]].mutableCopy;
        } else {
//            NSLog(@"%@",);
            _modelAry =@[
                         @[@"今日积分",@"今日现金",@"今日RY值支出"],
                         @[@"今日订单数",@"商品订单",@"收款订单",@"已核销订单",@"待付款",@"待评价",@"待核销订单",@"+"],
                         @[],
                         @[@"出售中",@"已下架",@"草稿中",@"添加商品"],
                         [[NSUserDefaults standardUserDefaults] objectForKey:@"ToolItem"]].mutableCopy;
        }
     
    }
    return _modelAry;
}

- (NSArray *)openingStoreAry {
    return  @[@"shop_store-opening",@"开店宝典"];
}

- (NSMutableArray *)titleAry {
    if (!_titleAry) {
  
        BOOL ishide = [[[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  objectForKey:CreateStoreTreasureKey] boolValue];
        if (ishide) {
            _titleAry = @[
                          @[@"store_transactionData",@"交易数据"],
                          @[@"store_orderManagement",@"订单管理"],
                          @[],
                          @[@"store_commodityManagement",@"商品管理"]].mutableCopy;
        } else {
            _titleAry = @[
                          @[@"store_transactionData",@"交易数据"],
                          @[@"store_orderManagement",@"订单管理"],
                          @[],
                          @[@"store_commodityManagement",@"商品管理"],
                          [self openingStoreAry]].mutableCopy;
        }
    }
    return _titleAry;
}

@end



