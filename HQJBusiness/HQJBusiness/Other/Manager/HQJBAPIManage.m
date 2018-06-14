//
//  HQJB_APIManage.m
//  WuWuMap
//
//  Created by mymac on 2018/5/3.
//  Copyright © 2018年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJBAPIManage.h"

#ifdef DEBUG  //测试阶段
NSString *const HQJBDomainName = @"http://shoptest.heqijia.net/";
NSString *const HQJBFeedbackDomainName = @"http://subtest.heqijia.net/";
NSString *const HQJBversionInformationDomainName = @"http://apptest.heqijia.net/";
NSString *const HQJBUpdataAPPDomainName = @"http://apptest.heqijia.net/app/";
NSString *const HQJBItunesDomainName= @"https://www.pgyer.com/WuWuMap_test";
NSString *const HQJBBonusDomainName = @"http://47.98.45.218:8080/wuwuInterface/merchant/";
//47.98.45.218 http://192.168.16.200:8080/wuwuInterface/
//NSString *const HQJBBonusDomainAAName = @"http://192.168.16.110:8080/aa";

#else         //发布阶段

NSString *const HQJBDomainName = @"http://shop.wuwuditu.com/";
NSString *const HQJBFeedbackDomainName = @"http://sub.wuwuditu.com/";
NSString *const HQJBversionInformationDomainName = @"http://app.wuwuditu.com/";
NSString *const HQJBUpdataAPPDomainName = @"http://app.heqijia.net/app/";
NSString *const HQJBItunesDomainName= @"https://itunes.apple.com/cn/app/%E7%89%A9%E7%89%A9%E5%9C%B0%E5%9B%BE/id1132505092?mt=8";
NSString *const HQJBBonusDomainName = @"http://114.55.74.24/";
#endif

NSString *const HQJBImageDomainName = @"http://wuwuditu.img-cn-hangzhou.aliyuncs.com/";


/*_____________________________我是分割线________________________________________*/
///获取商家信息
NSString *const HQJBGetMerchantInfoInterface = @"getMerchantInfo?";
/// 修改登录密码
NSString *const HQJBPasswordSaveActionInterface = @"passwordSaveAction?";
///// 校验短信验证码
//NSString *const HQJBInputSMSActionInterface = @"/merchant/inputSMSAction?";
/// 获取修改交易密码的短信验证码
NSString *const HQJBGetPwdSMSInterface = @"getPwdSMS?";
/// 校验短信验证码
NSString *const HQJBInputSMSActionInterface = @"inputSMSAction?";
/// 修改交易密码
NSString *const HQJBInputNewpwdActionInterface = @"inputNewpwdAction?";
/// 商家登录
NSString *const HQJBLoginCheckInterface = @"loginCheck?";
/// 商家通过手机号登录
NSString *const HQJBLoginCheckByMobileInterface = @"loginCheckByMobile?";
/// 查询商家收款码
NSString *const HQJBPayCodeInterface = @"payCode?";
/// 添加商家收款码
NSString *const HQJBAddPayCodeInterface = @"addPayCode?";
/// 删除商家收款码
NSString *const HQJBDelPayCodeInterface = @"delPayCode?";
/// 待审核申请（全部）
NSString *const HQJBApplyListInterface = @"/merchant/applyList";
/// 待审核申请（购买ZH值）
NSString *const HQJBZHPurchaseApplyListInterface = @"zhPurchaseApplyList";
/// 待审核申请（现金提取）
NSString *const HQJBCashDrawApplyListInterface = @"cashDrawApplyList";
///积分交易明细
NSString *const HQJBScoreTradeListInterface = @"scoreTradeList";
///现金交易明细
NSString *const HQJBCashTradeListInterface = @"cashTradeList";
///积分兑现明细
NSString *const HQJBScoreExchangeListInterface = @"scoreExchangeList";
///获取商家台卡信息
NSString *const HQJBGetMerchantBasicInfoInterface = @"getMerchantBasicInfo?";


/// 获取添加银行卡的手机短信验证码
NSString *const HQJBGetSMSInterface = @"getSMS?";
/// 添加银行卡
NSString *const HQJBAddBankCardInterface = @"addBankCard?";
/// 银行列表
NSString *const HQJBBankAccountInterface = @"bankAccount?";
/// 获取商家银行卡列表
NSString *const HQJBAccountListInterface = @"bankList?";
/// 获取买家信息（通过memberid)
NSString *const HQJBGetConsumerInfoByIdInterface = @"getConsumerInfoById";
/// 获取买家信息（通过mobile)
NSString *const HQJBGetConsumerInfoByMobileInterface = @"getConsumerInfoByMobile";
/// 获取商家赠送ZH值比例
NSString *const HQJBGetMerchantZHRateInterface = @"getMerchantZHRate";
/// 银行卡提现
NSString *const HQJBDrawCashInterface = @"drawCash";
/// 积分兑现
NSString *const HQJBCashExchangeInterface = @"cashExchange";
/// 积分查询
NSString *const HQJBScoreQueryInterface = @"scoreQuery";
/// ZH查询
NSString *const HQJBZhQueryInterface = @"zhQuery";
/// 购买ZH值（使用积分购买）
NSString *const HQJBPurchseZhUsingScoreInterface = @"purchseZhUsingScore";
/// 购买ZH值（使用支付宝购买）
NSString *const HQJBPurchseZhUsingAlipayInterface = @"purchseZhUsingAlipay";
/// 获取ZH值设定
NSString *const HQJBGetZhRateInterface = @"getZhRate";
/// 设定ZH值比例
NSString *const HQJBSetZhRateInterface = @"setZhRate";
/// 现金销售
NSString *const HQJBCashSalesInterface = @"cashSales";
/// 删除银行卡
NSString *const HQJBDeleteBankCardInterface = @"deleteBankCard";

@implementation HQJBAPIManage

@end
