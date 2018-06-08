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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/zhSet/memberid/%@",AppSel_URL,MmberidStr];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            SetZHModel *model = [SetZHModel mj_objectWithKeyValues:dic[@"result"]];
            proportion(model);
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

+ (void)setBonusZH:(NSString *)bonus andCashZH:(NSString *)cash andViewController:(UIViewController *)zw_self {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/zhSetAction/memberid/%@/bonusZH/%@/cashZH/%@",AppSel_URL,MmberidStr,bonus,cash ];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            [ManagerEngine SVPAfter:@"操作成功" complete:^{
                [zw_self.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
            
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}



@end
