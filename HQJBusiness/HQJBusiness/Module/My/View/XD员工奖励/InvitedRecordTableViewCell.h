//
//  InvitedRecordTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
@class InvitedRecordModel;
NS_ASSUME_NONNULL_BEGIN

@interface InvitedRecordTableViewCell : ZW_TableViewCell
@property (nonatomic, assign) listStyle recordstyle;
@property (nonatomic, strong) InvitedRecordModel *model;
@end

NS_ASSUME_NONNULL_END
