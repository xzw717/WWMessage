//
//  PaymentCodeViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2017/10/20.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PaymentCodeViewModel.h"
#import "PaymentCodeModel.h"
@implementation PaymentCodeViewModel
- (void)paymentCodeRequstList:(void(^)(NSArray *models))codelist codelistNull:(void(^)())isNull {
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/payCode/memberid/%@/type/0",AppSel_URL,MmberidStr];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"]integerValue] == 0) {
            NSArray *modelArray = [PaymentCodeModel mj_objectArrayWithKeyValuesArray:dic[@"resultMsg"]];
            !codelist ? :codelist(modelArray);
        }
        if ([dic[@"resultCode"]integerValue] == 49001) {
            !isNull ? : isNull();
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

- (void)paymentCodeDeletList:(NSString *)codeid complete:(void(^)())complete {
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/payCode/memberid/%@/type/2/id/%@",AppSel_URL,MmberidStr,codeid];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"]integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:dic[@"resultHint"]];
            !complete ? : complete();
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

- (void)paymentCodeAddList:(NSString *)codeurl codetype:(NSString *)type complete:(void (^)(NSString *str))complete {
    /// UTF-8 编码
    NSString * encodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)codeurl, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/payCode?memberid=%@&type=1&codetype=%@&codeurl=%@",AppSel_URL,MmberidStr,type,encodeString];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
            !complete ? : complete(dic[@"resultHint"]);
        
    } andError:^(NSError *error) {
    } ShowHUD:YES];
}
@end
