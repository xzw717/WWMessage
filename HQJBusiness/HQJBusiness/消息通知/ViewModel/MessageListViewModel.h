//
//  MessageListViewModel.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageListModel;
NS_ASSUME_NONNULL_BEGIN

@interface MessageListViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <MessageListModel *>*messageListModelArray;
@end

NS_ASSUME_NONNULL_END
