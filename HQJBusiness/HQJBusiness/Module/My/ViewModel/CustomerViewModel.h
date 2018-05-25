//
//  CustomerViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerViewModel : NSObject


/**
 现金销售--进入请求ZH值与现金的比例

 @param intoBlock  比例
 */
+(void)intoRequstZHRatio:(void(^)(id sender))intoBlock;





/**
 输入完手机号请求消费者信息

 @param numer 手机号
 @param customerBlock 消费者信息
 */
+ (void)customerrequstNumer:(NSString *)numer andSender:(void(^)(id sender))customerBlock;



/**
 提交请求

 @param cusId 消费者id
 @param zh 所赠送的ZH  值
 @param psw 交易密码
 @param amount 付款金额
 @param submitBlcok 交易结果
 */
+(void)submitRequstCustomerid:(NSString *)cusId andZH:(NSString *)zh andPsw:(NSString *)psw andAmount:(NSString *)amount andReturn:(void(^)(id sender))submitBlcok;
@end
