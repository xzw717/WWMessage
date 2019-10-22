//
//  GoodsReleaseViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/12.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsReleaseViewModel.h"
#import "ReleaseRulesVC.h"

@implementation GoodsReleaseViewModel
- (NSArray<NSArray <NSString *>*> *)keyAry {
    if (!_keyAry) {
        _keyAry =  @[@[@""],
                     @[@"商品标题",
                       @"分类"],
                     @[@"商品目录",
                       @"商品售价(元)",
                       @"折扣比例",
                       @"折后价(元)",
                       @"库存",
                       @"商品介绍"]];
    }
    return _keyAry;
}
- (NSArray<NSArray <NSString *>*> *)placeholderAry {
    if (!_placeholderAry) {
        _placeholderAry =  @[@[@""],
                     @[@"请输入商品标题",
                       @"美食"],
                     @[@"",
                       @"请输入商品售价",
                       @"0.9",
                       @"系统自动计算",
                       @"请输入库存数量",
                       @"请输入商品介绍"]];
    }
    return _placeholderAry;
}
#pragma mark --- ReleaseButtonViewDelegate
- (void)clickRealeaseBtn {
    
    HQJLog(@"点击了发布");
    
}
- (void)clickSaveBtn {
    HQJLog(@"点击了保存");
    
}

- (void)clickRulesbutton {
    ReleaseRulesVC *vc = [[ReleaseRulesVC alloc]initWithNavType:HQJNavigationBarWhite];
    vc.webUrlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainDeccaName,HQJBReleaseSpecificationInterface];
    vc.isInitiative = YES;
    [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];
}

@end
