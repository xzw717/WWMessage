//
//  RoleListModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/6.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoleListModel : NSObject
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *roleName;
@property (nonatomic, strong) NSString *roleDesc;
@property (nonatomic, strong) NSString *roleAward;
@property (nonatomic, strong) NSString *roleAwardLimit;
@property (nonatomic, strong) NSString *roleRate;
@property (nonatomic, strong) NSString *roleLimitDesc;
@property (nonatomic, strong) NSString *roleLimit;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *curstate;
@property (nonatomic, strong) NSString *note;

@end

NS_ASSUME_NONNULL_END
