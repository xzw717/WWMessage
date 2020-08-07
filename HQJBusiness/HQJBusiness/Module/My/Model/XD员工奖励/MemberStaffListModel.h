//
//  MemberStaffListModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/4.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberStaffModel.h"
NS_ASSUME_NONNULL_BEGIN
/*
 字段名    类型    说明    备注
 total    int    商家员工总数

 
 
 */
@interface MemberStaffListModel : NSObject
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSArray <MemberStaffModel *>*data;
@end

NS_ASSUME_NONNULL_END
