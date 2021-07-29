//
//  MessageListViewModel.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageListViewModel.h"
#import "MessageListModel.h"
@implementation MessageListViewModel
- (NSMutableArray<MessageListModel *> *)messageListModelArray {
    if (!_messageListModelArray) {
        _messageListModelArray = [NSMutableArray array];
        _messageListModelArray = [MessageListModel mj_objectArrayWithKeyValuesArray:[self dataArray]];
    }
    return _messageListModelArray;
}
- (NSArray *)dataArray {
    return @[@{@"messageCount":@"100",@"mainTitle":@"系统消息",@"subTitle":@"关于【物物地图】系统升级通知"},
             @{@"messageCount":@"3",@"mainTitle":@"交易消息",@"subTitle":@"关于【物物地图】系统升级通知"},
             @{@"messageCount":@"15",@"mainTitle":@"活动消息",@"subTitle":@"关于【物物地图】系统升级通知"},
             @{@"messageCount":@"68",@"mainTitle":@"退款/退换货消息",@"subTitle":@"关于【物物地图】系统升级通知"}];
}
@end
