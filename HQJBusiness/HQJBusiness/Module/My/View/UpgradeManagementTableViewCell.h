//
//  UpgradeManagementTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/6/16.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"

typedef NS_ENUM(NSUInteger,UpgradeManagementCellType) {
   /// 姓名
    nameTitleCellType = 0,
    /// 当前角色
    roleTitleCellType,
    ///  可升级为
    upgradeTitleCellType,
    /// 规则
    rulesCellType
};
NS_ASSUME_NONNULL_BEGIN

@interface UpgradeManagementTableViewCell : ZW_TableViewCell
- (void)setCellType:(UpgradeManagementCellType)type contentText:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
