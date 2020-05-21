//
//  XDPayViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDPayViewModel.h"

@implementation XDPayViewModel
+ (void)submitXDOrder:(NSString *)shopid andProid:(NSString *)proid andPrice:(NSString *)price completion:(void(^)(XDPayModel *model))completion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBXdorderInterface];
    NSDictionary *dict = @{@"shopid":shopid,
                           @"proid":proid,
                           @"price":price};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"] integerValue] == 2000) {
            XDPayModel *model = [XDPayModel mj_objectWithKeyValues:dic[@"resultMsg"]];
            if (completion) {
                completion(model);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
}
@end
