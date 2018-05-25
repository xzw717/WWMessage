//
//  BuyZHViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyZHViewModel : NSObject



/**
 购买ZH值界面

 @param buyBlock 数据模型（积分余额等）
 */
+(void)buyZH:(void(^)(id sender))buyBlock;





/**
 积分购买请求

 @param amount 数量
 @param psw 交易密码
 @param zw_self 控制器对象
 */
+(void)payRequstWithAmount:(NSString *)amount andPassword:(NSString *)psw andPopViewController:(ZW_ViewController *)zw_self ;





/**
 请求订单号

 @param amount 金额
 @param sender 订单号
 */
+ (void)generateTradeidRequstAmount:(NSString *)amount andBlock:(void(^)(id Tradeid))sender;
@end
