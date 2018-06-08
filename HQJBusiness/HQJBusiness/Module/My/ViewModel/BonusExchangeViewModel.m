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
+(void)bonusExchaneViewmodelRequstandViewControllerTitle:(NSString *)str AndBack:(void(^)(id sender))exchaneBlock {
    
    static NSString *urlType;
    if ([str isEqualToString:@"积分兑现"]) {
        urlType = @"bonusChange";
    } else {
        urlType = @"cashChange";
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/%@/memberid/%@",AppSel_URL,urlType,MmberidStr];

    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        BonusExchangeModel *model = [BonusExchangeModel mj_objectWithKeyValues:dic[@"result"]];

        exchaneBlock(model);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
}

+(void)bonusExchangSubmitRequstWithAmount:(NSString *)amount andPassword:(NSString *)psw andViewControllerTitle:(NSString *)str andcardId:(NSString *)accountid andbonusBlock:(void(^)(id sender))blocks {
    
    static NSString *urlType;
    if ([str isEqualToString:@"积分兑现"]) {
        urlType = @"bonusChangeAction";
    } else {
        urlType = @"cashChangeAction";
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/%@/amount/%@/tradepwd/%@/memberid/%@/accountid/%@",AppSel_URL,urlType,amount,psw,MmberidStr,accountid];
    
//    HQJLog(@"dizhi :%@",urlStr);
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        
        if (blocks) {
            blocks(dic);
        }
        
    
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}

@end
