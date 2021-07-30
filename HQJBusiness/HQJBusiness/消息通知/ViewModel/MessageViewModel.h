//
//  MessageViewModel.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageModel;
NS_ASSUME_NONNULL_BEGIN

@interface MessageViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <MessageModel *>*messageModelArray;
@end

NS_ASSUME_NONNULL_END
