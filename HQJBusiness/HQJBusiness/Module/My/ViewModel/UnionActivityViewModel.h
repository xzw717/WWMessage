//
//  UnionActivityViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnionActivityListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UnionActivityViewModel : NSObject
+ (void)getUnionActivityList:(NSString *)merchantId activityCurstate:(NSInteger)activityCurstate andPage:(NSInteger)page completion:(void(^)(NSArray <UnionActivityListModel *>*list))completion;
+ (void)modifyCurstate:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion;
@end

NS_ASSUME_NONNULL_END
