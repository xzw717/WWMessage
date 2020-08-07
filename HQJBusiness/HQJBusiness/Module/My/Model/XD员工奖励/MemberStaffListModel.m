//
//  MemberStaffListModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/4.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MemberStaffListModel.h"

@implementation MemberStaffListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[MemberStaffModel class]};
}
@end
