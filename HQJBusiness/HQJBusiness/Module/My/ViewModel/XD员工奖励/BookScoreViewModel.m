//
//  BookScoreViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/12/16.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BookScoreViewModel.h"

@implementation BookScoreViewModel
+ (void)requsetBookScoreList:(NSInteger)page andSize:(NSInteger)size completion:(void (^)(NSString *totalScore, NSArray <BooKScoreModel *> *array))completion{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBMerchantBookingListInterface];
    NSDictionary *parametersDict = @{@"merchantid":MmberidStr,@"page":@(page),@"pageSize":@(size),@"hash":HashCode};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:parametersDict complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
           ! completion ? : completion(dic[@"result"][@"leftActivityScore"],[BooKScoreModel mj_objectArrayWithKeyValuesArray:dic[@"result"][@"data"]]);
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
    } andError:^(NSError *error) {

    } ShowHUD:YES];
    
    
}
@end
