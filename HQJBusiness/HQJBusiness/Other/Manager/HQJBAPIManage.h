//
//  HQJB_APIManage.h
//  WuWuMap
//
//  Created by mymac on 2018/5/3.
//  Copyright © 2018年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * HQJB 前缀 意为 HQJBusiness
 */
/************************************域名（开始）**********************************************/

/// 物物地图商家版商家版新积分相关域名
extern NSString *const HQJBBonusDomainName;
/// 物物地图商家版相关域名
extern NSString *const HQJBDomainName;
/// 意见反馈
extern NSString *const HQJBFeedbackDomainName;
/// 版本信息
extern NSString *const HQJBVersionInformationDomainName;
/// 更新APP
extern NSString *const HQJBUpdataAPPDomainName;
/// 更新APP的地址
extern NSString *const HQJBItunesDomainName;
/// 物物地图商家版 图片域名
extern NSString *const HQJBImageDomainName;
/************************************域名（结束）**********************************************/


/************************************接口（开始）**********************************************/
///获取商家信息
extern NSString *const HQJBGetMerchantInfoInterface;
/// 修改登录密码
extern NSString *const HQJBPasswordSaveActionInterface;
/// 获取修改交易密码的短信验证码
extern NSString *const HQJBGetPwdSMSInterface;
///// 校验短信验证码
//extern NSString *const HQJBInputSMSActionInterface;
/// 修改交易密码
extern NSString *const HQJBInputNewpwdActionInterface;
/// 商家登录
extern NSString *const HQJBLoginCheckInterface;
/// 商家通过手机号登录
extern NSString *const HQJBLoginCheckByMobileInterface;
/// 查询商家收款码
extern NSString *const HQJBPayCodeInterface;
/// 添加商家收款码
extern NSString *const HQJBAddPayCodeInterface;
/// 删除商家收款码
extern NSString *const HQJBDelPayCodeInterface;
/// 待审核申请（全部）
extern NSString *const HQJBApplyListInterface;
/// 待审核申请（购买ZH值）
extern NSString *const HQJBZHPurchaseApplyListInterface;
/// 待审核申请（现金提取）
extern NSString *const HQJBCashDrawApplyListInterface;
///积分交易明细
extern NSString *const HQJBScoreTradeListInterface;
///现金交易明细
extern NSString *const HQJBCashTradeListInterface;
///积分兑现明细
extern NSString *const HQJBScoreExchangeListInterface;
/************************************接口（结束）**********************************************/

@interface HQJBAPIManage : NSObject


@end
