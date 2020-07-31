//
//  AddStaffTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
@class RoleSelectVIew;
NS_ASSUME_NONNULL_BEGIN

@interface AddStaffTableViewCell : ZW_TableViewCell
@property (nonatomic, strong) NSString *title;
/// 角色数组
@property (nonatomic, strong) NSArray *roleArray;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) RoleSelectVIew   *selectButton;

@end

NS_ASSUME_NONNULL_END
