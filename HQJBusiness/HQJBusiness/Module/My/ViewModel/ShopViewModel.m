//
//  ShopViewModel.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/4.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopViewModel.h"
#import "AppDelegate.h"
@implementation ShopViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}
- (NSArray *)sectionTitleArray {
    if (!_sectionTitleArray) {
        _sectionTitleArray = @[@"",
                               @"店铺管理",
                               @"交易管理",
                               @"商圈管理"];
    }
    
    return _sectionTitleArray;
}
- (NSArray<NSArray<ShopModel *> *> *)sourceArray {
    if (!_sourceArray) {
        self.sourceArray = [NSMutableArray array];
        
        NSArray *rowTitleWithImageArray = @[@[@{@"sp_number":@"+0.00",
                                                @"sp_title":@"当日积分"},
                                              @{@"sp_number":@"+0.00",
                                                @"sp_title":@"当日现金"},
                                              @{@"sp_number":@"+0.00",
                                                @"sp_title":@"当日积分"}],
                                            @[@{@"sp_image":@"icon_home_shop",
                                                @"sp_title":@"店铺管理",
                                                @"sp_action":@"StoreManagementViewController"},
                                              @{@"sp_image":@"icon_home_customer",
                                                @"sp_title":@"客户管理",
                                                @"sp_action":@""},
                                              @{@"sp_image":@"icon_home_commodity",
                                                @"sp_title":@"商品管理",
                                                @"sp_action":@""},
                                              @{@"sp_image":@"icon_home_XDinformation",
                                                @"sp_title":@"XD信息",
                                                @"sp_action":@"XDShopViewController"}],
                                            @[@{@"sp_image":@"icon_home_integral",
                                                @"sp_title":@"积分管理",
                                                @"sp_action":@"IntegralManagementViewController"},
                                              @{@"sp_image":@"icon_home_detailed",
                                                @"sp_title":@"明细管理",
                                                @"sp_action":@"DetailViewController"},
                                              @{@"sp_image":@"icon_home_transaction",
                                                @"sp_title":@"交易管理",
                                                @"sp_action":@"DealViewController"},
                                              @{@"sp_image":@"icon_home_order",
                                                @"sp_title":@"订单管理",
                                                @"sp_action":@"OrderViewController"},
                                              @{@"sp_image":@"icon_home_review",
                                                @"sp_title":@"待审核申请",
                                                @"sp_action":@"ToAuditViewController"},
                                              @{},
                                              @{},
                                              @{}],
                                            @[@{@"sp_image":@"icon_home_business",
                                                @"sp_title":@"XD商企",
                                                @"sp_action":@""},
                                              @{@"sp_image":@"icon_home_community",
                                                @"sp_title":@"利益命运共同体",
                                                @"sp_action":@"JumpH5ViewController"},
                                              @{},
                                              @{}]];
        NSLog(@"rowTitleWithImageArray:%@",rowTitleWithImageArray);
        [rowTitleWithImageArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *allData = [NSMutableArray array];
            allData = [ShopModel mj_objectArrayWithKeyValuesArray:obj];
            NSLog(@"alldata:%@",allData);
            if (allData.count == 0) {
                [_sourceArray addObject:@[]];
                
            } else {
                [_sourceArray addObject:allData];
                
            }
        }];
        
    }
    return _sourceArray;
}
- (void)clickItemWithIndexPath:(NSIndexPath *)index
                     dataArray:(NSArray <NSArray<ShopModel *> *> *)ary {
    NSString *vcTitle = ary[index.section][index.row].sp_action;
    
    if ([ary[index.section][index.row].sp_title containsString:@"XD商企"]) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UITabBarController *tabViewController = (UITabBarController *) appDelegate.window.rootViewController;
        [tabViewController setSelectedIndex:2];
        return;
    }
    if ([vcTitle isEqualToString:@""] || vcTitle == nil) {
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
        [SVProgressHUD dismissWithDelay:1.f];

        return;
    }
//    if ([ary[index.section][index.row].sp_title containsString:@"利益命运共同体"]) {
//        if ([Ttypeid integerValue] != 19 && [Ttypeid integerValue] != 20 ) {
//            [SVProgressHUD showInfoWithStatus:@"暂无权限"];
//            [SVProgressHUD dismissWithDelay:1.f];
//            return;
//
//        }
//    }
    if (vcTitle && ![vcTitle isEqualToString:@""]) {
        UIViewController *vc = [[NSClassFromString(vcTitle) alloc]init];
        NSDictionary *dict = ary[index.section][index.row].sp_parameter;
        if (dict) {
            NSArray *dicKey = [dict allKeys];
            for (int i = 0; i < dicKey.count; i ++) {
                SEL setSel = [self creatSetterWithPropertyName:dicKey[i]];
                if ([vc respondsToSelector:setSel]) {
                    ///2.2 获取字典中key对应的value
                    NSString  *value = [NSString stringWithFormat:@"%@", dict[dicKey[i]]];
                    
                    ///2.3 把值通过setter方法赋值给实体类的属性
                    [vc performSelectorOnMainThread:setSel
                                         withObject:value
                                      waitUntilDone:[NSThread isMainThread]];
                }
                
            }
            
        }
        
        
        [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES] ;
    }
    
}

- (SEL)creatSetterWithPropertyName:(NSString *)propertyName{
    
    //1.首字母大写
    propertyName = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] capitalizedString]];
    
    //2.拼接上set关键字
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    
    //3.返回set方法
    return NSSelectorFromString(propertyName);
}

@end
