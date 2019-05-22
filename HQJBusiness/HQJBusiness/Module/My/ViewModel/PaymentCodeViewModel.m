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
- (void)paymentCodeRequstList:(void(^)(NSArray *models))codelist codelistNull:(void(^)(void))isNull {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"type":@0}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBPayCodeInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            NSArray *modelArray = [PaymentCodeModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            !codelist ? :codelist(modelArray);
        }
        if ([dic[@"code"]integerValue] == 49001) {
            !isNull ? : isNull();
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

- (void)paymentCodeDeletList:(NSString *)codeid complete:(void(^)(void))complete {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"id":codeid}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBDelPayCodeInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            !complete ? : complete();
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

- (void)paymentCodeAddList:(NSString *)codeurl codetype:(NSString *)type complete:(void (^)(NSString *str))complete {
    /// UTF-8 编码
    NSString * encodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)codeurl, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"codeurl":encodeString,@"codetype":type}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBAddPayCodeInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            !complete ? : complete(dic[@"msg"]);
        
    } andError:^(NSError *error) {
    } ShowHUD:YES];
}
@end
