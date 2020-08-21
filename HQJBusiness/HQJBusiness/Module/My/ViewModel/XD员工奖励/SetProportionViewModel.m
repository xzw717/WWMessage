//
//  SetProportionViewModel.m
//  HQJBusiness
//
//  Created by Ethan on 2020/8/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetProportionViewModel.h"

@implementation SetProportionViewModel
+ (void)setReward:(NSDictionary *)dic
      completion:(void(^)(void))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBSetupMultiAwardRateInterface];
     NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dict setValue:MmberidStr forKey:@"myid"];
    [dict setValue:HashCode forKey:@"hash"];
   

    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49129) {
            [SVProgressHUD showInfoWithStatus:@"您提交的部分设置失败"];
            !completion? :completion();

        } else if ([dic[@"code"] integerValue] == 49000){
            
            [SVProgressHUD showSuccessWithStatus:@"提交的成功"];

            !completion? :completion();
        } else {
            [SVProgressHUD showErrorWithStatus:@"失败没请重试"];
        }
        } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}
@end
