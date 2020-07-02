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
+ (void)requstXDShopServiceManagementList:(NSInteger)page orderstate:(NSInteger)state completion:(void(^)(NSArray <XDSSMModel *>*modelAry))completion error:(void (^)(NSError *error))xdssmError {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetOrderListByShopIdInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url parameters:@{@"shopid":Shopid ? Shopid : @"",@"orderstate":@(state),@"size":@(15),@"page":@(page)} complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"] integerValue] == 2100) {
            NSMutableArray *array = [XDSSMModel mj_objectArrayWithKeyValuesArray:dic[@"resultMsg"][@"list"]];
            !completion ? :completion(array);
        } else {
            NSError *er ;
            !xdssmError ? :xdssmError (er);
        }
    } andError:^(NSError *error) {
    !xdssmError ? :xdssmError (error);

    } ShowHUD:YES];
}
@end
