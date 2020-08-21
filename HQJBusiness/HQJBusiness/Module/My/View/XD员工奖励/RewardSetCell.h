//
//  RewardSetCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/3.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@class ZGRelayoutButton;
@class RoleListModel;
typedef void(^CellActionBlock)(void);
typedef void(^CellSelectActionBlock)(ZGRelayoutButton *btn);

#import "ZW_TableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface RewardSetCell : ZW_TableViewCell
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, assign) BOOL isEnabled;
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, copy  ) CellSelectActionBlock selectRoleAction;
@property (nonatomic, copy  ) CellActionBlock addAction;
@property (nonatomic, copy  ) CellActionBlock removeAction;
@property (nonatomic, strong) NSString *btnTitle;
@property (nonatomic, strong) ZGRelayoutButton *roleButton;
@property (nonatomic, strong) RoleListModel *cellModel;



/// 是否已经加满
@property (nonatomic, assign) BOOL isFull;
@end

NS_ASSUME_NONNULL_END
