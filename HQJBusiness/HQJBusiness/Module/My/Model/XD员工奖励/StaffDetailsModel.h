//
//  StaffDetailsModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffDetailsModel : NSObject
/// 名字
@property (nonatomic, strong) NSString *name;
/// 手机号
@property (nonatomic, strong) NSString *phone;
/// 邀请人
@property (nonatomic, strong) NSString *inviter;
/// 时间
@property (nonatomic, strong) NSString *timer;
/// 岗位
@property (nonatomic, strong) NSString *position;
/// 编号
@property (nonatomic, strong) NSString *number;

@end

NS_ASSUME_NONNULL_END
