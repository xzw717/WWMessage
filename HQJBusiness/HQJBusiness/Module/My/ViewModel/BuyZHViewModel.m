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

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBZhQueryInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        BonusExchangeModel *model = [BonusExchangeModel mj_objectWithKeyValues:dic[@"result"]];
        buyBlock(model);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
}

+ (void)generateTradeidRequstAmount:(NSString *)amount andBlock:(void(^)(id Tradeid))sender {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBPurchseZhUsingScoreInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr,
                           @"amount":amount};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            if (sender) {
                sender(dic[@"result"]);
            }
            
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}


+(void)payRequstWithAmount:(NSString *)amount andPassword:(NSString *)psw andPopViewController:(ZW_ViewController *)zw_self {
 
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBPurchseZhUsingScoreInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr,
                               @"tradepwd":psw,
                               @"amount":amount};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            zw_self.viewControllerName = @"DealViewController";
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            [ManagerEngine SVPAfter:@"购买成功" complete:^{
                [zw_self popViews];
            }];
            
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
}
@end
