//
//  StaffDetailsVC.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemberStaffModel;
NS_ASSUME_NONNULL_BEGIN

@interface StaffDetailsVC : UIViewController

- (instancetype)initWithDetalisStyle:(listStyle)style
                         detaliModel:(MemberStaffModel *)model ;
- (void)updateModel:(MemberStaffModel *)model;
@end

NS_ASSUME_NONNULL_END
