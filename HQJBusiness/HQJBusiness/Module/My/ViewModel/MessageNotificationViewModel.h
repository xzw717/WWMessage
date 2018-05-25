//
//  MessageNotificationViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2017/4/17.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 消息阅读状态

 - AllMessageType: 全部消息
 - ReadMessageType: 未读消息
 - UnreadMessageType: 已读消息
 */
typedef NS_ENUM(NSInteger,ReadingState) {
    AllMessageType = 0,
    
    UnreadMessageType,

    ReadMessageType
    
 
};



@interface MessageNotificationViewModel : NSObject


/**
 消息条数
 */
@property (nonatomic, strong) NSMutableArray      *messageArray;

/**
 页数
 */
@property (nonatomic, assign) NSInteger           messagePage;


/**
 消息状态
 */
@property (nonatomic, assign) ReadingState        messageState;


/**
 加载消息的信号
 */
@property (nonatomic, strong, readonly) RACSignal *loadMoreSignal;
@end
