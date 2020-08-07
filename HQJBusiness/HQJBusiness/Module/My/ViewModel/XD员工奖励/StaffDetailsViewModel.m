//
//  StaffDetailsViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StaffDetailsViewModel.h"
#import "StaffDetailsModel.h"
#import "InvitedRecordModel.h"

@implementation StaffDetailsViewModel

- (NSArray <NSString *>*)setModeArrayWithType:(listStyle)mode {
    NSArray *initialArray = [NSArray array];
    if (mode  == stafflistStyle) {
        initialArray = @[@"员工编号",@"员工姓名",@"手机号码",@"员工岗位",@"入职时间"];
    } else {
        initialArray = @[@"会员姓名",@"手机号码",@"邀请人员",@"注册时间"];

    }
    
    
    return initialArray;
}


+ (void)getQrCodeWithStaffID:(NSString *)staffid
                  completion:(void(^)(NSString *imageUrl))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBGetEmployeeQrcodeInterface];
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"myid":MmberidStr,@"id":staffid,@"hash":HashCode} complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            !completion ? :completion(dic[@"result"]);
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

+ (void)getInvitedRecordListWithStaffID:(NSString *)staffid
                             completion:(void(^)(NSArray <InvitedRecordModel *>*ary))completion
                                  error:(void(^)(NSError *err))listError {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBGetInvitedConsumerInterface];
    NSDictionary *parameterDict = @{@"myid":MmberidStr,
                                    @"id":staffid,
                                    @"mid":MmberidStr,
                                    @"pageSize":@(10000),/// 不翻页直接显示完
                                    @"hash":HashCode};
       [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:parameterDict complete:^(NSDictionary *dic) {
           if ([dic[@"code"] integerValue] == 49000) {
               NSArray *modelAry = [InvitedRecordModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
               !completion ? :completion(modelAry);
           } else {
               NSError *er = [NSError errorWithDomain:NSCocoaErrorDomain code:490 userInfo:dic];
               !listError?:listError(er);
           }
       } andError:^(NSError *error) {
           !listError?:listError(error);

       } ShowHUD:YES];
}

+ (void)removeStaffWithStaffID:(NSString *)staffid {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBRemoveEmployeeInterface];
      [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"myid":MmberidStr,@"id":staffid,@"hash":HashCode} complete:^(NSDictionary *dic) {
          if ([dic[@"code"] integerValue] == 49000) {
              [SVProgressHUD showSuccessWithStatus:@"删除成功"];
          } else {
              [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];

          }
      } andError:^(NSError *error) {
          [SVProgressHUD showSuccessWithStatus:@"删除失败"];

      } ShowHUD:YES];
}


@end
