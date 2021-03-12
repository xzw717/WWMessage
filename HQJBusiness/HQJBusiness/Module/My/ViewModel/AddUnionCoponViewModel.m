//
//  AddUnionActivityViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/2.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionCoponViewModel.h"

@implementation AddUnionCoponViewModel

+ (void)getUnionCouponById:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetUnionCouponByIdInterface];
    NSDictionary * parameter = @{@"activityId":activityId,@"merchantId":MmberidStr,@"hash":HashCode};
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:parameter complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);

    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}
+ (void)addUnionCopon:(AddUnionModel *)model andActivityId:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion{
    if (!model.couponName) {
        [SVProgressHUD showErrorWithStatus:@"优惠券名称不能为空"];
        return;
    }
    if (!model.typeName) {
        [SVProgressHUD showErrorWithStatus:@"联盟券类型不能为空"];
        return;
    }
    if (!model.reducePrice||![ManagerEngine isNumber:model.reducePrice]) {
        [SVProgressHUD showErrorWithStatus:@"联盟券面额不能为空且应为纯数字"];
        return;
    }
    if (!model.minPrice||![ManagerEngine isNumber:model.minPrice]) {
        [SVProgressHUD showErrorWithStatus:@"使用条件不能为空且应为纯数字"];
        return;
    }
    if (!model.count||![ManagerEngine isNumber:model.count]) {
        [SVProgressHUD showErrorWithStatus:@"发行量不能为空且应为纯数字"];
        return;
    }
    if (!model.receiveNumber||![ManagerEngine isNumber:model.receiveNumber]) {
        [SVProgressHUD showErrorWithStatus:@"每人限领不能为空且应为纯数字"];
        return;
    }
    if (model.startTime&&model.endTime) {
        NSString *startTime = [model.startTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *endTime = [model.endTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        if (startTime.integerValue > endTime.integerValue) {
            [SVProgressHUD showErrorWithStatus:@"优惠券开始时间不能大于结束时间"];
            return;
        }
    }

    NSDictionary *dict = @{@"id":model.couponId,@"userId":MmberidStr,@"couponName":model.couponName,@"reducePrice":model.reducePrice,@"minPrice":model.minPrice,@"typeId":model.typeName,@"count":model.count,@"receiveNumber":model.receiveNumber,@"endTime":model.endTime,@"startTime":model.startTime,@"voucherTypeId":activityId};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBAddCouponInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}
+ (void)signUp:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion{
    NSDictionary *dict = @{@"activityId":activityId,@"merchantId":MmberidStr,@"hash":HashCode};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBSignUpInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        !completion ? : completion(dic);
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}

@end
