//
//  MessageTopTAB.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/28.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageTopTAB : UIView
@property (nonatomic, copy) void (^topViewSelectBlock)(NSInteger tag);
- (void)addMessageNotice:(NSInteger)tag
            messageCount:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
