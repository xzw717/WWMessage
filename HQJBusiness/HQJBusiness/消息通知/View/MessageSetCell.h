//
//  MessageSetCell.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/28.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageBasisCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MessageSetDelegate <NSObject>

- (void)returnTitle:(NSString *)title
        switchState:(BOOL)state;

@end
@interface MessageSetCell : MessageBasisCell
@property (nonatomic, strong) id <MessageSetDelegate>delegate;

- (void)titleContent:(NSString *)str
         switchState:(BOOL)state;
@end

NS_ASSUME_NONNULL_END
