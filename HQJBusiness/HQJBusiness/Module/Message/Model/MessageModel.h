//
//  MessageModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/3/2.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
/*
 
             "id": 57,           --- 通知主键id
 
             "shopid": "3b0bd904d3ff4d8ba319b9070573d6b0",   ---商家id
 
   "notice": "yyyuuuuu",      ---  通知内容
 "type": 1,            --- 通知类型
 "state": 1            --- 读取的状态（0.未读，1已读）
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic, strong) NSString *messageid;
@property (nonatomic, strong) NSString *shopid;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *state;

@end

NS_ASSUME_NONNULL_END
