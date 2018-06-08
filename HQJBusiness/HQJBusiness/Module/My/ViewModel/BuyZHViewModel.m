//
//  BuyZHViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BuyZHViewModel.h"
#import "BonusExchangeModel.h"

@implementation BuyZHViewModel
+(void)buyZH:(void(^)(id sender))buyBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/zhGet/memberid/%@",AppSel_URL,MmberidStr];
    HQJLog(@"%@",urlStr);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        BonusExchangeModel *model = [BonusExchangeModel mj_objectWithKeyValues:dic[@"result"]];
        buyBlock(model);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
}

+ (void)generateTradeidRequstAmount:(NSString *)amount andBlock:(void(^)(id Tradeid))sender {
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/generateTradeid/memberid/%@/amount/%@",AppSel_URL,MmberidStr,amount];
    HQJLog(@"链接是：%@",urlStr);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            if (sender) {
                sender(dic[@"result"]);
            }
            
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
        }
        
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];

}


+(void)payRequstWithAmount:(NSString *)amount andPassword:(NSString *)psw andPopViewController:(ZW_ViewController *)zw_self {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/zhGetByBonusAction/amount/%@/tradepwd/%@/memberid/%@",AppSel_URL,amount,psw,MmberidStr];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            zw_self.viewControllerName = @"DealViewController";
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            [ManagerEngine SVPAfter:@"购买成功" complete:^{
                [zw_self popViews];
            }];
            
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
        }
        
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}
@end
