//
//  ConsumerCodeViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderVerificationModel.h"

@interface ConsumerCodeViewModel : NSObject


/**
 消费码的情况

 @param code 码
 @param sender 结果
 */
+(void)QrCodeRequst:(NSString *)code  andBlock:(void(^)(void))sender ;


/**
 使用消费码

 @param code 消费码
 @param success 使用成功
 */
- (void)useConsumerCode:(NSString *)code success:(void(^)(void))success ;


/**
 根据订单号查询商品详情

 @param orederid 订单号
 @param complete 查询结果
 */
- (void)inquireGoods:(NSString *)orederid complete:(void (^)(OrderVerificationModel *model))complete ;

@end
