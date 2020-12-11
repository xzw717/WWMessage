//
//  PayEngine.h
//  WuWuMap
//
//  Created by mymac on 16/7/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,buyType) {
    buyRY ,
    buyXD ,
    registerXD
    
};
@interface PayEngine : NSObject
         /****************************** AliPay ************************************/

/**
*  这四个参数分别是 :订单ID（由商家自行制定）,商品标题 ,商品描述 ,带有'￥'商品价格
*
*  @param OutTrade 订单ID（由商家自行制定）
*  @param Subject  商品标题
*  @param nameStr  商品描述
*  @param pice     带有'￥'商品价格
*/

+(void)payActionOutTradeNOStr:(NSString *)OutTrade
                andSubjectStr:(NSString *)Subject
                   andNameStr:(NSString *)nameStr
                andTotalFeeSt:(NSString *)pice
                andNotifyUrl:(NSString *)notify_url
                      buytype:(buyType)type;


       /********************************  WXPay  **********************************/
/**
 *  这三个参数分别是 : 订单号, 用户id
 *
 *  @param orderid 订单号
 *  @param userid  用户id
 *
 *  @return 支付结果
 */
+ (NSString *)jumpToBizPayOrderidStr:(NSString *)orderid andUseridStr:(NSString *)userid ;   //微信支付

@end
