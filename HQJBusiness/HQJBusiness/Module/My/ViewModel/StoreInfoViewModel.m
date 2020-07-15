//
//  StoreInfoViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/14.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreInfoViewModel.h"
#import "StoreInfoModel.h"
@implementation StoreInfoViewModel
+ (void)requstStoreInfoWithModel:(void(^)(StoreInfoModel *model))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBIsPerfectInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url parameters:@{@"shopid":Shopid} complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"]integerValue] == 1800) {
            StoreInfoModel *m = [StoreInfoModel mj_objectWithKeyValues:dic[@"resultMsg"]];
            !completion ? : completion(m);
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}
@end
