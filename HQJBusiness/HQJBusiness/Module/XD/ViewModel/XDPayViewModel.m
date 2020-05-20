//
//  XDPayViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDPayViewModel.h"

@implementation XDPayViewModel
+ (void)submitXDOrder:(NSString *)shopid andProid:(NSString *)proid andPrice:(NSString *)price completion:(void(^)(id sneder))completion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBXdorderInterface];
    NSDictionary *dict = @{@"shopid":shopid,
                           @"Proid":proid,
                           @"Price":price};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        completion(dic[@"resultMsg"]);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
 
}
@end
