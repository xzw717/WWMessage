//
//  OrderViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderViewModel : NSObject


- (void) orderRequstWithPage:(NSInteger)page andType:(NSInteger)type
              andReturnBlock:(void(^)(id sender))output;

+ (void)requestCustomerInformationWith:(NSString *)customerID
                              complete:(void(^)(NSString *mobile,NSString *realname))complete;
/// 请求优惠券信息
+ (void)requestCouponTypeWithid:(NSString *)customerID
                       complete:(void(^)(NSString *couponType))complete ;
@property (nonatomic, strong) void (^ErrorBlock)(NSString *error);
@end
