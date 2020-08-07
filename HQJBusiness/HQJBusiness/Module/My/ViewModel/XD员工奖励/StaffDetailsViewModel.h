//
//  StaffDetailsViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StaffDetailsModel;
@class InvitedRecordModel;
NS_ASSUME_NONNULL_BEGIN

@interface StaffDetailsViewModel : NSObject
- (NSArray <NSString *>*)setModeArrayWithType:(listStyle)mode ;

/// 员工二维码
+ (void)getQrCodeWithStaffID:(NSString *)staffid
                  completion:(void(^)(NSString *imageUrl))completion;

///  邀请记录
+ (void)getInvitedRecordListWithStaffID:(NSString *)staffid
                             completion:(void(^)(NSArray <InvitedRecordModel *>*ary))completion
                                  error:(void(^)(NSError *err))listError;
/// 删除员工
+ (void)removeStaffWithStaffID:(NSString *)staffid;
@end

NS_ASSUME_NONNULL_END
