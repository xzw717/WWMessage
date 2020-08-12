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
                      completion:(void(^)(RewardsRecordSuperModel *model))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,[type isEqualToString:@"商家"] ?  HQJBGetMerchantAwardtInterface : HQJBGetAllEmployeeAwardListInterface];
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"myid":MmberidStr,
                                                                    [type isEqualToString:@"商家"] ?@"id" : @"sid":MmberidStr,
                                                                    @"hash":HashCode,
                                                                    @"page":@(page),
                                                                    @"pageSize":@(15)
    } complete:^(NSDictionary *dic) {
          if ([dic[@"code"]integerValue] == 49000) {
              RewardsRecordSuperModel *superModel = [RewardsRecordSuperModel mj_objectWithKeyValues:dic[@"result"]];
              !completion?:completion(superModel);
          }
      } andError:^(NSError *error) {
          
      } ShowHUD:YES];
}

@end
