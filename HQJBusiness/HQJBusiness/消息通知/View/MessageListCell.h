//
//  MessageListCell.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageBasisCell.h"
#import "MessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListCell : MessageBasisCell
@property (nonatomic, strong) MessageListModel *messageListCellModel;
@end

NS_ASSUME_NONNULL_END
