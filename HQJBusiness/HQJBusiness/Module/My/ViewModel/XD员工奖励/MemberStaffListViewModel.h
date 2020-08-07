//
//  MemberStaffListViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/5.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@class MemberStaffListModel;
typedef void(^requstListCompletionBlock)(MemberStaffListModel * _Nonnull model);
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberStaffListViewModel : NSObject
- (instancetype)initWithListType:(listStyle)type;
/// 员工列表
- (void)requstListWithPage:(NSInteger)page completion:(requstListCompletionBlock)completion error:(void(^)(void))listRrror;
/// 根据关键字搜索 员工
- (void)requstSearchListWithKey:(NSString *)keyWord completion:(requstListCompletionBlock)completion error:(void(^)(void))listRrror;
@end

NS_ASSUME_NONNULL_END
