//
//  StaffDetailsViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StaffDetailsViewModel.h"
#import "StaffDetailsModel.h"
@implementation StaffDetailsViewModel

- (NSArray <NSString *>*)setModeArrayWithType:(listStyle)mode {
    NSArray *initialArray = [NSArray array];
    if (mode  == stafflistStyle) {
        initialArray = @[@"员工编号",@"员工姓名",@"手机号码",@"员工岗位",@"入职时间"];
    } else {
        initialArray = @[@"会员姓名",@"手机号码",@"邀请人员",@"注册时间"];

    }
    
    
    return initialArray;
}
@end
