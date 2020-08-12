//
//  AddStaffViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/6.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
typedef void(^CompletionBlock)(void);

#import <Foundation/Foundation.h>
@class RoleListModel;
NS_ASSUME_NONNULL_BEGIN

@interface AddStaffViewModel : NSObject

//@property (nonatomic, strong) CompletionBlock ;
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
+ (void)addStaff:(NSDictionary *)dic
      completion:(CompletionBlock)completion;
/// 编辑员工信息
+ (void)editStaff:(NSDictionary *)dic
       completion:(CompletionBlock)completion;
/// 添加员工角色
+ (void)addRoleNameWithName:(NSString *)name
                 completion:(CompletionBlock)completion;
/// 删除员工角色
+ (void)removeRoleNameWithRoleID:(NSString *)roleid
                 completion:(CompletionBlock)completion;
@end

NS_ASSUME_NONNULL_END
