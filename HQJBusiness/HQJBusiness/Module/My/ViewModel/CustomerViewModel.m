//
//  CustomerViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CustomerViewModel.h"
#import "CustomerModel.h"

@implementation CustomerViewModel



+(void)intoRequstZHRatio:(void(^)(id sender))intoBlock {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetMerchantZHRateInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        intoBlock(dic[@"result"][@"cashZH"]);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
    
}


+ (void)customerrequstNumer:(NSString *)numer andSender:(void(^)(id sender))customerBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetConsumerInfoByMobileInterface];
    NSDictionary *dict = @{@"mobile":numer,
                           @"membertype":@1};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        CustomerModel *model = [CustomerModel mj_objectWithKeyValues:dic[@"result"]];
        customerBlock(model);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}


+ (void)submitRequstCustomerid:(NSString *)cusId andZH:(NSString *)zh andPsw:(NSString *)psw andAmount:(NSString *)amount andReturn:(void(^)(id sneder))submitBlcok {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBCashSalesInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr,
                           @"cusid":cusId,
                           @"zh":zh,
                           @"amount":amount,
                           @"tradepwd":psw};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        submitBlcok(dic[@"msg"]);

    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
 
}


@end
