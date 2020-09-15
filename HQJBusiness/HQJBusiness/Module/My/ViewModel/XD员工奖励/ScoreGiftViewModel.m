//
//  ScoreGiftViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ScoreGiftViewModel.h"

@implementation ScoreGiftViewModel
+ (void)senderCodePhone:(NSString *)phone complete:(void(^)(id responsObject))complete{
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@",WWLDomainName,WWLSendSmsInterface];
//    [[RequstManager getAFManager]HQJWuWuMapRequestDetailsUrl:strUrl parameters:@{@"mobile":phone,@"itype":@"4"} complete:^(id dic) {
//        HQJLog(@"验证码连接：%@",dic);
//        if ([dic[@"code"]integerValue] == WWLInterfaceCodeSuccess ) {
//            [MBProgressHUD showSuccess:@"验证码发送成功"];
//        } else {
//            [MBProgressHUD showError:@"验证码发送成功"];
//        }
//
//        complete(dic);
//    } andError:^(NSError *error) {
//
//    } showHUD:RequstAlertLoadingCustom alertText:@"验证码发送中"];
    
    
}
+ (void)sunmitGifterInfo:(NSString *)mobile smsCode:(NSString *)smsCode complete:(void(^)(id responsObject))completeBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBXdFlowInterface];
//    NSDictionary *dict = @{@"shopid":shopid,
//                           @"peugeotid":peugeotid};
//
//    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
//        if ([dic[@"resultCode"] integerValue] == 1800) {
//            if (completion) {
//                completion(dic[@"resultMsg"]);
//            }
//
//        }else{
//            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
//        }
//
//    } andError:^(NSError *error) {
//
//    } ShowHUD:NO];
    
}
@end
