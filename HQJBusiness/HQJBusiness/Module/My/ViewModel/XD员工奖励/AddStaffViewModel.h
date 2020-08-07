//
//  AddStaffViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/6.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RoleListModel;
NS_ASSUME_NONNULL_BEGIN

@interface AddStaffViewModel : NSObject
+ (void)getTitlesWithCompletion:(void(^)(NSArray <RoleListModel *>*modelArray))completion;



/*
 "sid":1,
 "nickname":"牛叉叉",
 "mobile":"18161398196",
 "title":50,
 "gender":1,
 "age":23,
 "account":"1",
 "empNo":"1234cdsfdsfdsfsd",
 "role":"12"
 */
/// 添加角色或 添加员工
/// @param dic 对应的字典数据
+ (void)addStaff:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
