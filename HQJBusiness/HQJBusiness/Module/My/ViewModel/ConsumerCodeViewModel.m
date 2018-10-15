//
//  ConsumerCodeViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ConsumerCodeViewModel.h"


@implementation ConsumerCodeViewModel
+(void)QrCodeRequst:(NSString *)code  andBlock:(void(^)(void))sender{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@salecode/shopcheckcode.action?memberid=%@&sale_code=%@",HQJBBounsOrder,MmberidStr,code];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        HQJLog(@"%@",dic[@"resultMsg"][@"state"]);
            NSDictionary *infoDict = @{@"state":dic[@"resultMsg"][@"state"],
                                       @"salecode": dic[@"resultMsg"][@"salecode"] ? dic[@"resultMsg"][@"salecode"] : @"",
                                       @"orderid":dic[@"resultMsg"][@"orderid"] ? dic[@"resultMsg"][@"orderid"] : @""};
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"Qrcode" object:nil userInfo: infoDict];
        
       
        sender();
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
}

- (void)useConsumerCode:(NSString *)code success:(void(^)(void))success {
    NSString *url = [NSString stringWithFormat:@"%@salecode/employcode.action?memberid=%@&sale_code=%@",HQJBBounsOrder,MmberidStr,code];
    @weakify(self);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url complete:^(NSDictionary *dic) {
        @strongify(self);
        if ([dic[@"resultCode"]integerValue] == 2200) {
            [self alertMessage:@"核销成功"];
            if (success) {
                success ();
            }
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

- (void)inquireGoods:(NSString *)orederid complete:(void (^)(OrderVerificationModel *model))complete {
    NSString *url = [NSString stringWithFormat:@"%@order/queryOrder.action?orderid=%@",HQJBBounsOrder,orederid];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"]integerValue] == 2000) {
            OrderVerificationModel *model = [OrderVerificationModel mj_objectWithKeyValues:dic[@"resultMsg"]];
            
            
            if (complete) {
                complete (model);
            }
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}





- (void)alertMessage:(NSString *)mesg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:mesg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [[ManagerEngine currentViewControll] presentViewController:alert animated:YES completion:nil];
}
@end
