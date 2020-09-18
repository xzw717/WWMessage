//
//  RewardsRecordViewModel.m
//  HQJBusiness
//
//  Created by Ethan on 2020/8/7.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RewardsRecordViewModel.h"
#import "RewardsRecordSuperModel.h"
@implementation RewardsRecordViewModel
+ (void)getAwardWithType:(NSString *)type
                    page:(NSInteger)page
                      completion:(void(^)(RewardsRecordSuperModel *model,NSError *requstError))completion {
    NSString *url ;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"myid":MmberidStr,
                                                                   
                                                                    @"hash":HashCode,
                                                                    @"page":@(page),
                                                                    @"pageSize":@(15)
    }];
    if ([type isEqualToString:@"商家"] || [type isEqualToString:@"员工"]) {
        url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,[type isEqualToString:@"商家"] ?  HQJBGetMerchantAwardtInterface : HQJBGetAllEmployeeAwardListInterface];
        [dict setValue:MmberidStr forKey:[type isEqualToString:@"商家"] ?@"id" : @"sid"];
    } else {
        url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,[type isEqualToString:@"奖励记录"] ?  HQJBSubAwardListInterface : HQJBMerchnatAwardListInterface];
        [dict setValue:MmberidStr forKey:@"merchantId"];

    }
    
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:dict complete:^(NSDictionary *dic) {
        RewardsRecordSuperModel *superModel;
        NSError *er;
          if ([dic[@"code"]integerValue] == 49000) {
             superModel = [RewardsRecordSuperModel mj_objectWithKeyValues:dic[@"result"]];
          } else {
            er = [NSError errorWithDomain:NSCocoaErrorDomain code:40001 userInfo:@{@"content":@"没有更多数据"}];
          }
        !completion?:completion(superModel,er);

      } andError:^(NSError *error) {
          !completion?:completion(nil,error);

      } ShowHUD:YES];
}

@end
