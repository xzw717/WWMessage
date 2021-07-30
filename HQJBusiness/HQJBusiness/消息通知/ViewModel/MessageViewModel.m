//
//  MessageViewModel.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageViewModel.h"
#import "MessageModel.h"

@implementation MessageViewModel

- (NSMutableArray<MessageModel *> *)messageModelArray {
    if (!_messageModelArray) {
        _messageModelArray = [NSMutableArray array];
        _messageModelArray = [MessageModel mj_objectArrayWithKeyValuesArray:[self modelArray]];
    }
    return _messageModelArray;
}

- (NSArray *)modelArray {
    return @[@{@"messageTime":@"2021-06-12",
               @"messageTitle":@"关于【物物地图】系统升级的通知",
               @"messageContent":@"【物物地图】APP将于2021-06-06凌晨1:00-5:00进行系统维护，解释将暂停服务，给您带来不便敬请谅解。"},
    @{@"messageTime":@"2021-06-12",
      @"messageTitle":@"关于【物物地图】系统升级的通知",
      @"messageContent":@"【物物地图】APP将于2021-06-06凌晨1:00-5:00进行系统维护，解释将暂停服务，给您带来不便敬请谅解。"},
    @{@"messageTime":@"2021-06-12",
      @"messageTitle":@"关于【物物地图】系统升级的通知",
      @"messageContent":@"【物物地图】APP将于2021-06-06凌晨1:00-5:00进行系统维护，解释将暂停服务，给您带来不便敬请谅解。"}];
}
@end
