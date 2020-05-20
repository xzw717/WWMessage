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
/// 台卡域名
extern NSString *const HQJBBonusDomainDeccaName;
///商品订单相关
extern NSString *const HQJBBounsOrder;
/// 优惠券域名
extern NSString *const WWMCouponDomain;
/// 直播域名
extern NSString *const WWMLiveDomain;
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
/// 待审核申请（积分兑现）
extern NSString *const HQJBScoreExchangeInterface;
/// 待审核申请（ZH值设定）
extern NSString *const HQJBZHSetupInterface;

///积分交易明细
extern NSString *const HQJBScoreTradeListInterface;
///现金交易明细
extern NSString *const HQJBCashTradeListInterface;
///积分兑现明细
extern NSString *const HQJBScoreExchangeListInterface;
///获取商家台卡信息
extern NSString *const HQJBGetMerchantBasicInfoInterface;
///获取商家个人信息
extern NSString *const HQJBGetMerchantMasterInfoInterface;


/// 获取添加银行卡的手机短信验证码
extern NSString *const HQJBGetSMSInterface;
/// 添加银行卡
extern NSString *const HQJBAddBankCardInterface;
/// 银行列表
extern NSString *const HQJBBankAccountInterface;
/// 删除银行卡
extern NSString *const HQJBDeleteBankCardInterface;
/// 获取商家银行卡列表
extern NSString *const HQJBAccountListInterface;
/// 获取买家信息（通过memberid)
extern NSString *const HQJBGetConsumerInfoByIdInterface ;
/// 获取买家信息（通过mobile)
extern NSString *const HQJBGetConsumerInfoByMobileInterface;
/// 获取商家赠送ZH值比例
extern NSString *const HQJBGetMerchantZHRateInterface;
/// 银行卡提现
extern NSString *const HQJBDrawCashInterface;
/// 积分兑现
extern NSString *const HQJBCashExchangeInterface;
/// 积分查询
extern NSString *const HQJBScoreQueryInterface;
/// ZH查询
extern NSString *const HQJBZhQueryInterface;
/// 购买ZH值（使用积分购买）
extern NSString *const HQJBPurchseZhUsingScoreInterface;
/// 购买ZH值（使用支付宝购买）
extern NSString *const HQJBPurchseZhUsingAlipayInterface;
/// 获取ZH值设定
extern NSString *const HQJBGetZhRateInterface;
/// 设定ZH值比例
extern NSString *const HQJBSetZhRateInterface;
/// 现金销售
extern NSString *const HQJBCashSalesInterface;
/// 根据id查询优惠劵信息接口
extern NSString *const HQJBGetCouponByIdInterface;
/// 发送消息
extern NSString *const HQJBSendMessageInterface;
///获取消息
extern NSString *const HQJBGetMessageInterface;
/*_____________________________XD接口________________________________________*/
///创建订单
extern NSString *const HQJBXdorderInterface;

/************************************接口（结束）**********************************************/

@interface HQJBAPIManage : NSObject


@end
