//
//  MessageListViewModel.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageListViewModel.h"

@implementation MessageListViewModel
- (NSMutableArray<MessageListModel *> *)messageListModelArray {
    if (!_messageListModelArray) {
        _messageListModelArray = [NSMutableArray array];
        
    }
    return _messageListModelArray;
}
@end
