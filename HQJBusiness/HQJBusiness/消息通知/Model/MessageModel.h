//
//  MessageModel.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic, strong) NSString *messageTime;
@property (nonatomic, strong) NSString *messageTitle;
@property (nonatomic, strong) NSString *messageContent;
@property (nonatomic, strong) NSString *messageId;

@end

NS_ASSUME_NONNULL_END
