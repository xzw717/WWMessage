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


#define StoreMenuWidth  130.f;
#define StoreMenuRowHeight  57.f;
#define StoreMenuIconMargin  16.4f;
#define StoreMenuTextMargin  10.f;
#define StoreMenuFont  [UIFont systemFontOfSize:16.f];
#define StoreMenuSeparatorInset  UIEdgeInsetsMake(0, 40, 0, 0);


@interface StoreViewModel()
@property (nonatomic, strong) UIViewController *storeViewModel_self;

@end
@implementation StoreViewModel
- (instancetype)initWithTargetObjct:(id)object
{
    self = [super init];
    if (self) {
        self.storeViewModel_self = object;


    }
    return self;
}

#pragma mark --- 导航控制器菜单
- (void)navMenu:(UIView *)view {
    HQJPopMenuConfiguration *configuration = [HQJPopMenuConfiguration defaultConfiguration];
    configuration.menuWidth = StoreMenuWidth;
    configuration.menuRowHeight = StoreMenuRowHeight;
    configuration.menuIconMargin = StoreMenuIconMargin;
    configuration.menuTextMargin = StoreMenuTextMargin;
    configuration.textFont = StoreMenuFont;
    configuration.separatorInset = StoreMenuSeparatorInset;
    configuration.textAlignment = NSTextAlignmentLeft;
    //        @weakify(self);
    NSArray *itemTitAry = @[@"扫一扫", @"功能设置"];
    NSArray *itemImgAry = @[@"menu_scan", @"menu_set"];
    [HQJMenu showForSender:view withMenuArray:itemTitAry imageArray:itemImgAry configuration:configuration doneBlock:^(NSInteger selectedIndex) {
        if (selectedIndex == 0) {
            ScanViewController *sVC =[[ScanViewController alloc]init];
            [self.storeViewModel_self presentViewController:sVC animated:YES completion:nil];
        } else {
            FunctionSetVC *fVC = [[FunctionSetVC alloc]init];
            [self.storeViewModel_self.navigationController pushViewController:fVC animated:YES];
        }
    } dismissBlock:^{
        
    }];
    
}

#pragma mark --- 剥离控制器中的cell 
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        StoreMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreMainCell class]) forIndexPath:indexPath];
        //        cell.itemAry = .mutableCopy;
        cell.itemAry = [self modelAry][indexPath.section];
        [cell setClickItemblock:^(NSString * _Nonnull title) {
            NSLog(@"你点击了：%@",title);
        }];
        cell.titleArray = self.titleAry[indexPath.section];
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
       viewController = [[DetailViewController alloc]init];
    } else if ([ary.lastObject isEqualToString:@"订单管理"]) {
        viewController = [[OrderManageVC alloc]init];
    } else if ([ary.lastObject isEqualToString:@"商品管理"]) {
      viewController = [[GoodsManageVC alloc]init];
    }
    [self.storeViewModel_self.navigationController pushViewController:viewController animated:YES];

}

- (NSArray *)modelAry {
    if (!_modelAry) {
        _modelAry =@[@[@"今日积分",@"今日现金",@"今日RY值支出"],
                     @[@"今日订单数",@"商品订单",@"收款订单",@"已核销订单",@"待付款",@"待评价",@"待核销订单",@"+"],
                     @[],
                     @[@"出售中",@"已下架",@"草稿中",@"添加商品"]];
    }
    return _modelAry;
}

- (NSArray *)titleAry {
    if (!_titleAry) {
        _titleAry = @[@[@"store_transactionData",@"交易数据"],@[@"store_orderManagement",@"订单管理"],@[],@[@"store_commodityManagement",@"商品管理"]];
    }
    return _titleAry;
}

@end



