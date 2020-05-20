//
//  XDSSMViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDSSMViewModel.h"
#import "XDSSMModel.h"
@implementation XDSSMViewModel
- (void)requstXDShopServiceManagementList:(NSInteger)page complete:(void(^)(NSArray *modelAry))complete {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetOrderListByShopIdInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url parameters:@{@"Shopid":@"",@"size":@(10),@"page":@(page)} complete:^(NSDictionary *dic) {
        
    } andError:^(NSError *error) {
    
    } ShowHUD:YES];
}
@end
