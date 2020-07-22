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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBScoreQueryInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        BonusExchangeModel *model = [BonusExchangeModel mj_objectWithKeyValues:dic[@"result"]];
        
        exchaneBlock(model);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
}

+ (void)bonusExchangSubmitRequstWithAmount:(NSString *)amount andPassword:(NSString *)psw andViewControllerTitle:(NSString *)str andcardId:(NSString *)accountid andbonusBlock:(void(^)(id sender))blocks {
    
    static NSString *urlType;
    if ([str isEqualToString:@"积分兑现"]) {
        urlType = HQJBCashExchangeInterface;
    } else {
        urlType = HQJBDrawCashInterface;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,urlType];
    NSDictionary *dict = @{@"memberid":MmberidStr,
                               @"accountid":accountid,
                           @"amount":amount,
                           @"roleType":[NameSingle shareInstance].role,
                           @"merchantType":Classifyid,
                           @"tradepwd":psw};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
          !blocks ? : blocks(dic);
   
        
        
        
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
  
}

@end
