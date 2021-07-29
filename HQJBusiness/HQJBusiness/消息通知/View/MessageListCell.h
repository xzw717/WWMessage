//
//  MessageListCell.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
#import "MessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListCell : ZW_TableViewCell
@property (nonatomic, strong) MessageListModel *messageListCellModel;
@end

NS_ASSUME_NONNULL_END
