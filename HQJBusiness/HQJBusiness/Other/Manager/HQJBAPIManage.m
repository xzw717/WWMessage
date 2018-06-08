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
NSString *const HQJBBonusDomainName = @"http://47.98.45.218:8080/wuwuInterface";
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
NSString *const HQJBGetMerchantInfoInterface = @"/merchant/getMerchantInfo?";
/// 修改登录密码
NSString *const HQJBPasswordSaveActionInterface = @"/merchant/passwordSaveAction?";
/// 获取修改交易密码的短信验证码
NSString *const HQJBGetPwdSMSInterface = @"/merchant/getPwdSMS?";
///// 校验短信验证码
//NSString *const HQJBInputSMSActionInterface = @"/merchant/inputSMSAction?";
/// 修改交易密码
NSString *const HQJBInputNewpwdActionInterface = @"/merchant/inputNewpwdAction?";
/// 商家登录
NSString *const HQJBLoginCheckInterface = @"/merchant/loginCheck?";
/// 商家通过手机号登录
NSString *const HQJBLoginCheckByMobileInterface = @"/merchant/loginCheckByMobile?";
/// 查询商家收款码
NSString *const HQJBPayCodeInterface = @"/merchant/payCode?";
/// 添加商家收款码
NSString *const HQJBAddPayCodeInterface = @"/merchant/addPayCode?";
/// 删除商家收款码
NSString *const HQJBDelPayCodeInterface = @"/merchant/delPayCode?";
/// 待审核申请（全部）
NSString *const HQJBApplyListInterface = @"/merchant/applyList?";
/// 待审核申请（购买ZH值）
NSString *const HQJBZHPurchaseApplyListInterface = @"/merchant/zhPurchaseApplyList?";
/// 待审核申请（现金提取）
NSString *const HQJBCashDrawApplyListInterface = @"/merchant/cashDrawApplyList?";
///积分交易明细
NSString *const HQJBScoreTradeListInterface = @"/merchant/scoreTradeList?";;
///现金交易明细
NSString *const HQJBCashTradeListInterface = @"/merchant/cashTradeList?";;
///积分兑现明细
NSString *const HQJBScoreExchangeListInterface = @"/merchant/scoreExchangeList?";;

@implementation HQJBAPIManage

@end
