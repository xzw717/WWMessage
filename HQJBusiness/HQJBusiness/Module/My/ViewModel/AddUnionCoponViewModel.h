//
//  AddUnionActivityViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/2.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddUnionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddUnionCoponViewModel : NSObject
+ (void)getUnionCouponById:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion;
+ (void)addUnionCopon:(AddUnionModel *)model andIsNew:(BOOL)isNew completion:(void(^)(NSDictionary *dic))completion;

@end

NS_ASSUME_NONNULL_END
