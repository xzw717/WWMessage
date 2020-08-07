//
//  AddStaffViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/6.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddStaffViewModel.h"
#import "RoleListModel.h"
@implementation AddStaffViewModel


+ (void)getTitlesWithCompletion:(void(^)(NSArray <RoleListModel *>*modelArray))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBGetRoleListInterface];
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"myid":MmberidStr,@"mid":MmberidStr,@"hash":HashCode} complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            NSArray *array = [RoleListModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
            !completion?:completion(array);
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}


+ (void)addStaff:(NSDictionary *)dic {
    NSString *url = [NSString stringWithFormat:@"http://47.98.45.218/%@%@?myid=%@&hash=%@",HQJBXdMerchantProject,HQJBAddEmployeeInterface,MmberidStr,HashCode];

    [RequestEngine HQJBusinessGETRequestUrl:url parameters:dic complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];

        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}


@end
