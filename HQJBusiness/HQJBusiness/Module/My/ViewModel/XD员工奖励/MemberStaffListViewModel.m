//
//  MemberStaffListViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/5.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MemberStaffListViewModel.h"
#import "MemberStaffListModel.h"
@interface MemberStaffListViewModel ()
@property (nonatomic, assign) listStyle viewModelType;
@end
@implementation MemberStaffListViewModel
- (instancetype)initWithListType:(listStyle)type {
    self = [super init];
    if (self) {
        self.viewModelType = type;
    }
    return self;
}
- (void)requstListWithPage:(NSInteger)page completion:(requstListCompletionBlock)completion error:(void(^)(void))listRrror {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,self.viewModelType == stafflistStyle ? HQJBGetMerchantEmployeeListInterface : HQJBGetMemberListInterface];
    NSDictionary *parametersDict = @{@"myid":MmberidStr,self.viewModelType == stafflistStyle ?  @"id" : @"sid" :MmberidStr,@"page":@(page),@"pageSize":@(15),@"hash":HashCode};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:parametersDict complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            MemberStaffListModel *model = [MemberStaffListModel mj_objectWithKeyValues:dic[@"result"]];
            !completion?:completion(model);
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            !listRrror ? :listRrror();
        }
    } andError:^(NSError *error) {
        !listRrror ? :listRrror();

    } ShowHUD:YES];
}



- (void)requstSearchListWithKey:(NSString *)keyWord completion:(requstListCompletionBlock)completion error:(void(^)(void))listRrror{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,self.viewModelType == stafflistStyle ? HQJBSearchEmployeeInterface : HQJBSearchMemberListInterface];
    NSDictionary *parametersDict = @{@"myid":MmberidStr,@"sid":MmberidStr,@"pageSize":@(1000),@"hash":HashCode,@"keyword":keyWord};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:parametersDict complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            MemberStaffListModel *model = [MemberStaffListModel mj_objectWithKeyValues:dic[@"result"]];
            !completion?:completion(model);
        } else {
            !listRrror ? :listRrror();
        }
    } andError:^(NSError *error) {
        !listRrror ? :listRrror();
        
    } ShowHUD:YES];
}
@end
