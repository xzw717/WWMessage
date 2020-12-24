//
//  BonusExchangeViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BonusExchangeViewModel.h"
#import "BonusExchangeModel.h"

@implementation BonusExchangeViewModel
+ (void)bonusExchaneViewmodelRequstandViewControllerTitle:(NSString *)str AndBack:(void(^)(id sender))exchaneBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,HQJBScoreQueryInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        BonusExchangeModel *model = [BonusExchangeModel mj_objectWithKeyValues:dic[@"result"]];
        
        exchaneBlock(model);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
}

+ (void)bonusExchangSubmitRequstWithAmount:(NSString *)amount andPassword:(NSString *)psw andViewControllerTitle:(NSString *)str andcardId:(NSString *)accountid andbonusBlock:(void(^)(id sender))blocks {
    
    static NSString *urlType;
    NSDictionary *dict;
    if ([str isEqualToString:@"积分兑现"]||[str isEqualToString:@"预约积分兑现"]) {
        urlType = HQJBCashExchangeInterface;
        static NSString *exchangeType;
        if ([str isEqualToString:@"积分兑现"]) {
            exchangeType = @"1";
        }else{
            exchangeType = @"56";
        }
        dict = @{@"memberid":MmberidStr,
                               @"accountid":accountid,
                               @"amount":amount,
                               @"tradepwd":psw,
                               @"roleType":[NameSingle shareInstance].membertype,
                               @"merchantType":@([Classifyid integerValue]),
                               @"exchangeType":exchangeType,
                               @"hash":HashCode
        };
    } else {
        urlType = HQJBDrawCashInterface;
        dict = @{@"memberid":MmberidStr,
        @"accountid":accountid,
        @"amount":amount,
        @"tradepwd":psw,
        @"roleType":[NameSingle shareInstance].membertype,
        @"merchantType":@([Classifyid integerValue]),
        @"hash":HashCode};
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,urlType];
        
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
          !blocks ? : blocks(dic);
   
        
        
        
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
  
}

@end
