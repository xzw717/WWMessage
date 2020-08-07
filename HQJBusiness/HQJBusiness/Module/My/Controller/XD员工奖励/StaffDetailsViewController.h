//
//  StaffDetailsViewController.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NewXDChildViewController.h"
//@calss MemberStaffListViewController;
@class MemberStaffModel;
NS_ASSUME_NONNULL_BEGIN

@interface StaffDetailsViewController : NewXDChildViewController
- (instancetype)initWithDetailsStyle:(listStyle)style objectModel:(MemberStaffModel *)model;

@end

NS_ASSUME_NONNULL_END
