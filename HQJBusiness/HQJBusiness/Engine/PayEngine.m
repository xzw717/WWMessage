//
//  PayEngine.m
//  WuWuMap
//
//  Created by mymac on 16/7/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PayEngine.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "UPPaymentControl.h"
#import <AliPaySDK/AlipaySDK.h>
@implementation PayEngine

#pragma mark   ==============配置支付宝支付==============

+(void)payActionOutTradeNOStr:(NSString *)OutTrade
                andSubjectStr:(NSString *)Subject
                   andNameStr:(NSString *)nameStr
                andTotalFeeSt:(NSString *)pice
{
    
    //    fjdysj@sina.com
    NSString *partner = @"2088521368042140";
    NSString *seller = @"deluke@heqijia.net";
    NSString *privateKey = @"MIICXgIBAAKBgQDFEfDEWREAIrI1B823qE344cC8FDdDxkdczF5vwipJ9oQe0BKDM09x88Q1rz1c5DPiZtCMVduoST1f51Ly0nnmAybWnTlqr7mhdauOjmPFSeU+vrH82/JmStCCqcEQ0izx2qDnNVJhQgq44xFw/orOUygJBepn6MUGq+EQ+wszIQIDAQABAoGAMvvYOUP9pPZU+mlBbIFLYtcs4LuuLIeQkM6CpBEslaQEPGCCWZUduZJiMa1bh7u2PJ1y2Muhn2ELUtNq301aoZX40D/HDD7gZvENmNXyzXDniJ1maF22fV+SBXc2ADk+4XVj+fbW/d2ogxEiYd9u39u4FLpUb8zGB8FWTUUYMhECQQDhcZUAvtTAGtuSIZog5AppFfYinFWbifT8cQUg0wlrxTBX8nLA/MGI6Ao39la2StmZTTrEatbq7JIzUaloh2PdAkEA38fay259v7eRZgeUEvjYu58ryYBcKdpBiFyLqfGdqNLD96zo0talxJrXtlUkbnBAqfjBQ8K5TVu7ILMPCsjqFQJBAN6HsR6lP3fIiwf5pxvkPOpxxR1w14fKa0prfTZjWZ9Ja2jEZsVcOOUctkl7HSifRZ7u/p03IKGPltiVOPV2/vkCQQDVR+eySAa1uMFtWv+37VCz0YqsLBirEweubXX3bP70rpxz7GqiuE2ZynKZpyBn2bjnxtx8NpThs/HvwnktsDvZAkEAr6bAb8QYhUqRlf2JSaB5iMaWu642I3pohTdVMaqCJfWYR/pTRisma8CCStN9oNxHGT3/leOP2iV7jVUHIKaJ+Q==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = OutTrade; //订单ID（由商家自行制定）
    order.subject = Subject; //商品标题
    order.body = nameStr; //商品描述
    order.totalFee = pice; //商品价格
    order.notifyURL = [NSString stringWithFormat:@"%@AppSel2/notifyurl",AppSel_URL]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aliPayURL";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    HQJLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] integerValue] == 9000)  {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"AliSuccess" object:nil userInfo:@{@"strMsg":@"支付成功"}];
            } else {
                
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"AliSuccess" object:nil userInfo:@{@"strMsg":@"支付失败"}];
            }
            HQJLog(@"reslut = %@",resultDic);
        }];
    }
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


 /*
+ (NSString *)jumpToBizPayOrderidStr:(NSString *)orderid andUseridStr:(NSString *)userid
{
    

    
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
*/

#pragma mark   ==============配置银联支付==============
//+(void)yinLianPayWithTn:(NSString *)tn andShopName:(NSString *)name andController:(UIViewController *)controller {
//    
//    
//   [[UPPaymentControl defaultControl] startPay:tn fromScheme:name mode:@"01" viewController:controller];
//    
//}

@end
