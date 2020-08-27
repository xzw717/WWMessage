//
//  AddStaffTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
@class RoleSelectView;
typedef void(^AddStaffTimerBlock)(NSString *timer);
NS_ASSUME_NONNULL_BEGIN

@interface AddStaffTableViewCell : ZW_TableViewCell
@property (nonatomic, strong) NSString *title;

/// 输入框内容
@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) RoleSelectView   *selectButton;
/// 清空输入框的值
@property (nonatomic, assign) BOOL isClear;
@property (nonatomic, copy  ) AddStaffTimerBlock timeBlock;
@end

NS_ASSUME_NONNULL_END
