//
//  MessageCell.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageBasisCell.h"
@class MessageModel;
NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : MessageBasisCell
@property (nonatomic, strong) MessageModel *model;
@end

NS_ASSUME_NONNULL_END
