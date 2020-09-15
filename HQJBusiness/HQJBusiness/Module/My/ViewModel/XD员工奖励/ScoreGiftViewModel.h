//
//  ScoreGiftViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoreGiftViewModel : NSObject
+ (void)senderCodePhone:(NSString *)phone complete:(void(^)(id responsObject))complete;
+ (void)sunmitGifterInfo:(NSString *)mobile smsCode:(NSString *)smsCode complete:(void(^)(id responsObject))completeBlock;
@end

NS_ASSUME_NONNULL_END
