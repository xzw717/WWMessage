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

@interface AddUnionActivityViewModel : NSObject
+ (void)getTempData:(NSString *)url completion:(void(^)(NSDictionary *dic))completion;
+ (void)uploadImage:(UIImage *)image andUrl:(NSString *)url alertText:(NSString *)text completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error,UIImage *image))completionBlock;
+ (void)getMerchantByMobile:(NSString *)mobile completion:(void(^)(NSDictionary *dic))completion;
+ (void)addUnionActivity:(AddUnionModel *)model andActivityId:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion;
+ (void)getActivityInfoById:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion;
+ (void)getActivityById:(NSString *)activityId completion:(void(^)(NSDictionary *dic))completion;

+ (NSArray *)getDataArray;
+ (NSArray *)getEditDataArray;
@end

NS_ASSUME_NONNULL_END
