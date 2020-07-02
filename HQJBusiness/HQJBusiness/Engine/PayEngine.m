//
//  PayEngine.m
//  WuWuMap
//
//  Created by mymac on 16/7/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PayEngine.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UPPaymentControl.h"
#import <AliPaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
@implementation PayEngine

#pragma mark   ==============配置支付宝支付==============

+(void)payActionOutTradeNOStr:(NSString *)OutTrade
andSubjectStr:(NSString *)Subject
   andNameStr:(NSString *)nameStr
andTotalFeeSt:(NSString *)pice
andNotifyUrl:(NSString *)notify_url
{
    
    //    fjdysj@sina.com
//    NSString *partner = @"2088521368042140";
//    NSString *seller = @"deluke@heqijia.net";
//    NSString *privateKey = @"MIICXgIBAAKBgQDFEfDEWREAIrI1B823qE344cC8FDdDxkdczF5vwipJ9oQe0BKDM09x88Q1rz1c5DPiZtCMVduoST1f51Ly0nnmAybWnTlqr7mhdauOjmPFSeU+vrH82/JmStCCqcEQ0izx2qDnNVJhQgq44xFw/orOUygJBepn6MUGq+EQ+wszIQIDAQABAoGAMvvYOUP9pPZU+mlBbIFLYtcs4LuuLIeQkM6CpBEslaQEPGCCWZUduZJiMa1bh7u2PJ1y2Muhn2ELUtNq301aoZX40D/HDD7gZvENmNXyzXDniJ1maF22fV+SBXc2ADk+4XVj+fbW/d2ogxEiYd9u39u4FLpUb8zGB8FWTUUYMhECQQDhcZUAvtTAGtuSIZog5AppFfYinFWbifT8cQUg0wlrxTBX8nLA/MGI6Ao39la2StmZTTrEatbq7JIzUaloh2PdAkEA38fay259v7eRZgeUEvjYu58ryYBcKdpBiFyLqfGdqNLD96zo0talxJrXtlUkbnBAqfjBQ8K5TVu7ILMPCsjqFQJBAN6HsR6lP3fIiwf5pxvkPOpxxR1w14fKa0prfTZjWZ9Ja2jEZsVcOOUctkl7HSifRZ7u/p03IKGPltiVOPV2/vkCQQDVR+eySAa1uMFtWv+37VCz0YqsLBirEweubXX3bP70rpxz7GqiuE2ZynKZpyBn2bjnxtx8NpThs/HvwnktsDvZAkEAr6bAb8QYhUqRlf2JSaB5iMaWu642I3pohTdVMaqCJfWYR/pTRisma8CCStN9oNxHGT3/leOP2iV7jVUHIKaJ+Q==";
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.sellerID = seller;
//    order.outTradeNO = OutTrade; //订单ID（由商家自行制定）
//    order.subject = Subject; //商品标题
//    order.body = nameStr; //商品描述
//    order.totalFee = pice; //商品价格
//    order.notifyURL = [NSString stringWithFormat:@"%@alipayCallback",HQJBBonusDomainName]; //回调URL
//
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showURL = @"m.alipay.com";
//
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"aliPayURL";
//
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    HQJLog(@"orderSpec = %@",orderSpec);
//
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            if ([resultDic[@"resultStatus"] integerValue] == 9000)  {
//
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"AliSuccess" object:nil userInfo:@{@"strMsg":@"支付成功"}];
//            } else {
//
//                 [[NSNotificationCenter defaultCenter]postNotificationName:@"AliSuccess" object:nil userInfo:@{@"strMsg":@"支付失败"}];
//            }
//            HQJLog(@"reslut = %@",resultDic);
//        }];
//    }

    NSString *appID = @"2016123004734379";
     
     // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
     // 如果商户两个都设置了，优先使用 rsa2PrivateKey
     // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
     // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
     // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
     NSString *rsa2PrivateKey = @"";
     NSString *rsaPrivateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMUR8MRZEQAisjUHzbeoTfjhwLwUN0PGR1zMXm/CKkn2hB7QEoMzT3HzxDWvPVzkM+Jm0IxV26hJPV/nUvLSeeYDJtadOWqvuaF1q46OY8VJ5T6+sfzb8mZK0IKpwRDSLPHaoOc1UmFCCrjjEXD+is5TKAkF6mfoxQar4RD7CzMhAgMBAAECgYAy+9g5Q/2k9lT6aUFsgUti1yzgu64sh5CQzoKkESyVpAQ8YIJZlR25kmIxrVuHu7Y8nXLYy6GfYQtS02rfTVqhlfjQP8cMPuBm8Q2Y1fLNcOeInWZoXbZ9X5IFdzYAOT7hdWP59tb93aiDESJh327f27gUulRvzMYHwVZNRRgyEQJBAOFxlQC+1MAa25IhmiDkCmkV9iKcVZuJ9PxxBSDTCWvFMFfycsD8wYjoCjf2VrZK2ZlNOsRq1urskjNRqWiHY90CQQDfx9rLbn2/t5FmB5QS+Ni7nyvJgFwp2kGIXIup8Z2o0sP3rOjS1qXEmte2VSRucECp+MFDwrlNW7sgsw8KyOoVAkEA3oexHqU/d8iLB/mnG+Q86nHFHXDXh8prSmt9NmNZn0lraMRmxVw45Ry2SXsdKJ9Fnu7+nTcgoY+W2JU49Xb++QJBANVH57JIBrW4wW1a/7ftULPRiqwsGKsTB65tdfds/vSunHPsaqK4TZnKcpmnIGfZuOfG3Hw2lOGz8e/CeS2wO9kCQQCvpsBvxBiFSpGV/YlJoHmIxpa7rjYjemiFN1UxqoIl9ZhH+lNGKyZrwIJK032g3EcZPf+V44/aJXuNVQcgpon5";
     /*============================================================================
      
      */
     /*============================================================================*/
     /*============================================================================*/
     
     //partner和seller获取失败,提示
     if ([appID length] == 0 ||
         ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
     {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                        message:@"缺少appId或者私钥,请检查参数设置"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action){
                                                            
                                                        }];
         [alert addAction:action];
         [[ManagerEngine currentViewControll] presentViewController:alert animated:YES completion:^{ }];
         return;
     }
     
     /*
      *生成订单信息及签名
      */
     //将商品信息赋予AlixPayOrder的成员变量
     APOrderInfo* order = [APOrderInfo new];
         
    order.notify_url = notify_url; //回调URL
    
     // NOTE: app_id设置
     order.app_id = appID;
    
     // NOTE: 支付接口名称
     order.method = @"alipay.trade.app.pay";
     
     // NOTE: 参数编码格式
     order.charset = @"utf-8";
     
     // NOTE: 当前时间点
     NSDateFormatter* formatter = [NSDateFormatter new];
     [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     order.timestamp = [formatter stringFromDate:[NSDate date]];
     
     // NOTE: 支付版本
     order.version = @"1.0";
     
     // NOTE: sign_type 根据商户设置的私钥来决定
     order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
     
     // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = nameStr;
    order.biz_content.subject = Subject;
    order.biz_content.out_trade_no = OutTrade; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = pice; //商品价格
    order.biz_content.seller_id = @"2088521368042140";
     //将商品信息拼接成字符串
     NSString *orderInfo = [order orderInfoEncoded:NO];
     NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
     NSLog(@"orderSpec = %@",orderInfo);
     
     // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
     //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
     NSString *signedString = nil;
     APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
     if ((rsa2PrivateKey.length > 1)) {
         signedString = [signer signString:orderInfo withRSA2:YES];
     } else {
         signedString = [signer signString:orderInfo withRSA2:NO];
     }
     
     // NOTE: 如果加签成功，则继续执行支付
     if (signedString != nil) {
         //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
         NSString *appScheme = @"aliPayURL";
         
         // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
         NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                  orderInfoEncoded, signedString];
         
         // NOTE: 调用支付结果开始支付
         [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
             if ([resultDic[@"resultStatus"] integerValue] == 9000)  {
             
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"AliSuccess" object:nil userInfo:@{@"strMsg":@"支付成功"}];
             } else {
             
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"AliSuccess" object:nil userInfo:@{@"strMsg":@"支付失败"}];
             }
         }];
     }
}
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
//- (void)bizPay {
//    NSString *res = [PayEngine jumpToBizPay];
//    if( ![@"" isEqual:res] ){
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alter show];

//      }
//    
//}
#pragma mark   ==============配置微信支付==============



+ (NSString *)jumpToBizPayOrderidStr:(NSString *)orderid andUseridStr:(NSString *)userid {
   
    HQJLog(@"安装了微信,且支持微信支付");
    
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = [NSString stringWithFormat:@"%@order/getWXPreId.action?orderid=%@&userid=%@",@"1",orderid,userid];
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        HQJLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
            
                [WXApi sendReq:req];
                //日志输出
                HQJLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
  
  
  
}


#pragma mark   ==============配置银联支付==============
//+(void)yinLianPayWithTn:(NSString *)tn andShopName:(NSString *)name andController:(UIViewController *)controller {
//    
//    
//   [[UPPaymentControl defaultControl] startPay:tn fromScheme:name mode:@"01" viewController:controller];
//    
//}

@end
