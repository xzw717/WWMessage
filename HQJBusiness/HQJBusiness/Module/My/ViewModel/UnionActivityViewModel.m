//
//  UnionActivityViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UnionActivityViewModel.h"

@implementation UnionActivityViewModel

+ (void)getUnionActivityList:(NSString *)merchantId activityCurstate:(NSInteger)activityCurstate andPage:(NSInteger)page completion:(void(^)(NSArray <UnionActivityListModel *>*list))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetActivityByMidListInterface];
    
    NSDictionary *dict = @{@"merchantId":merchantId,@"page":[NSString stringWithFormat:@"%ld",page],@"hash":HashCode,
                           @"activityCurstate":[NSString stringWithFormat:@"%ld",activityCurstate]};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            NSArray * listArray = [UnionActivityListModel mj_objectArrayWithKeyValuesArray:dic[@"result"][@"activity"]];
            !completion ? : completion(listArray);
        }else{
            !completion ? : completion(@[]);
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}
+ (void)modifyCurstate:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBModifyCurstateInterface];
    
    NSDictionary *dict = @{@"activityId":activityId};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}

@end
