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



+ (void)addStaff:(NSDictionary *)dic
      completion:(CompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@?myid=%@&hash=%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBAddEmployeeInterface,MmberidStr,HashCode];

    [RequestEngine HQJBusinessGETRequestUrl:url parameters:dic complete:^(NSDictionary *dict) {
        if ([dict[@"code"]integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            !completion? :completion();
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];

        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}
+ (void)editStaff:(NSDictionary *)dic
           editID:(NSString *)editid
       completion:(CompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@?myid=%@&hash=%@&id=%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBUpdateEmployeeInterface,MmberidStr,HashCode,editid];
    [RequestEngine HQJBusinessGETRequestUrl:url parameters:dic complete:^(NSDictionary *dict) {
        if ([dict[@"code"]integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            !completion? :completion();
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];

        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

+ (void)addRoleNameWithName:(NSString *)name
                 completion:(CompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBAddRoleNameInterface];
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"myid":MmberidStr,@"sid":MmberidStr,@"role":name,@"hash":HashCode} complete:^(NSDictionary *dic) {
         if ([dic[@"code"]integerValue] == 49000) {
             !completion?:completion();
         } else {
             [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
         }
     } andError:^(NSError *error) {
         
     } ShowHUD:YES];
    
}

+ (void)removeRoleNameWithRoleID:(NSString *)roleid
                      completion:(CompletionBlock)completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBRemoveRoleInterface];
      [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"myid":MmberidStr,@"id":roleid,@"hash":HashCode} complete:^(NSDictionary *dic) {
           if ([dic[@"code"]integerValue] == 49000) {
               !completion?:completion();
           } else {
               [SVProgressHUD showErrorWithStatus:dic[@"msg"]];

           }
       } andError:^(NSError *error) {
           
       } ShowHUD:YES];
}
@end
