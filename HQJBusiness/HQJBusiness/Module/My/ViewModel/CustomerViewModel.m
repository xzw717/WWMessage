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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/cashSalesShow/memberid/%@",AppSel_URL,MmberidStr];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        intoBlock(dic[@"result"]);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}


+ (void)customerrequstNumer:(NSString *)numer andSender:(void(^)(id sender))customerBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@getMemberInfo/mobile/%@/membertype/customer",Api_URL,numer];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        CustomerModel *model = [CustomerModel mj_objectWithKeyValues:dic[@"result"]];
        customerBlock(model);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO]
    ;
}


+(void)submitRequstCustomerid:(NSString *)cusId andZH:(NSString *)zh andPsw:(NSString *)psw andAmount:(NSString *)amount andReturn:(void(^)(id sneder))submitBlcok {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/cashSales/memberid/%@/cusId/%@/ZH/%@/tradepwd/%@/amount/%@",AppSel_URL,MmberidStr,cusId,zh,psw,amount];

    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
    
            submitBlcok(dic[@"result"][@"errmsg"]);
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}


@end
