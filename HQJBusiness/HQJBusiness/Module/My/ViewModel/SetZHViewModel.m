//
//  SetZHViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/19.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetZHViewModel.h"
#import "SetZHModel.h"

@implementation SetZHViewModel
+ (void)getBonusZHCashZHWithBlock:(void(^)(id sender))proportion {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetZhRateInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            SetZHModel *model = [SetZHModel mj_objectWithKeyValues:dic[@"result"]];
            proportion(model);
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
}

+ (void)setBonusZH:(NSString *)bonus andCashZH:(NSString *)cash andViewController:(UIViewController *)zw_self {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBSetZhRateInterface];
    NSDictionary *dict = @{@"memberid":MmberidStr,
                           @"bonuszh":bonus,
                           @"cashzh":cash};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            [ManagerEngine SVPAfter:@"操作成功" complete:^{
                [zw_self.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}



@end
