//
//  XDViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDViewModel.h"
#import "XDModel.h"

@implementation XDViewModel
+ (void)requstXDWithCompletion:(void(^)(NSArray <XDModel *>*modelArray))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBFeedbackDomainName,HQJBBuinessSignInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"] integerValue] == 2100) {
            NSArray *modelAry = [XDModel mj_objectArrayWithKeyValuesArray:dic[@"resultMsg"]];
            !completion ?:completion(modelAry);
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}
@end
