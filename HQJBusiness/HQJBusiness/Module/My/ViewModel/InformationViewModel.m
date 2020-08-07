//
//  InformationViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InformationViewModel.h"
#import "informationModel.h"

@implementation InformationViewModel

+ (void)informationRequstBlock:(void(^)(id infoBlock))sender {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr}.mutableCopy;
    NSString *urlStr =[NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,HQJBGetMerchantMasterInfoInterface];
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            informationModel *model = [informationModel mj_objectWithKeyValues:dic[@"result"]];
            if (sender) {
                sender(model);
            }
        }
       
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}




@end
