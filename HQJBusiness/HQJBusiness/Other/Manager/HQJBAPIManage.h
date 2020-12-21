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
/// 物物地图商家版 图片域名
extern NSString *const HQJBImageDomainName;
///商品订单相关
extern NSString *const HQJBBounsOrder;
/// 优惠券域名
extern NSString *const WWMCouponDomain;
/// 直播域名
extern NSString *const WWMLiveDomain;
/// H5 域名
extern NSString *const HQJBH5UpDataDomain ;
/// XDH5域名
extern NSString *const HQJBXDH5Domain;
/// XD合同下载
extern NSString *const HQJBXDDownloadPactDomain;
/// 商家奖励
extern NSString *const HQJBRewardDomainName;
/************************************域名（结束）**********************************************/


/************************************接口（开始）**********************************************/

/// 积分相关的项目
extern NSString *const HQJBMerchantInterface ;

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

#pragma mark ------------------------ 商家重构增加接口 ------------------------
///通过短信验证码登录(发送短信)
extern NSString *const HQJBGetLoginCodeInterface;
///通过短信验证码登录
extern NSString *const HQJBMerchantSmsLoginInterface;
///服务商注册时发送手机短信R
extern NSString *const HQJBRegisterCodeInterface;
/// 店铺界面订单数据
extern NSString *const HQJBShopfindorderstatecodeInterface;

#pragma mark ------------------------ H5 ------------------------
/// 创建店铺
extern NSString *const HQJBCreateStoreInterface;
/// 注册店铺审核失败
extern NSString *const HQJBRegisteredStoreReviewFailedInterface;
/// 注册信息填写完成
extern NSString *const HQJBRegistrationInformationCompletedInterface;
/// 升级/升级失败修改信息
extern NSString *const HQJBUpgradeUnsuccessfulInterface;
/// 升级规则
extern NSString *const HQJBUpgradeRuleInterface;
/// 发布规范
extern NSString *const HQJBReleaseSpecificationInterface;
/// 商家入驻协议
extern NSString *const HQJBMerchantSettlementSgreementInterface;
/// 头条
extern NSString *const HQJBHeadlinesInterface;
/// 已经签合同
extern NSString *const HQJBDownloadUpdateInterface;
/// 入驻协议
extern NSString *const HQJBRegisterAgreementListInterface;
/// 商家查看合同列表
extern NSString *const HQJBFindShopEsignListInterface;
/// 商家注册
extern NSString *const HQJBNewstoreListInterface;
/// 根据城市名获取地区列表
extern NSString *const HQJBQueryCityAreaInterface;
/// 商家手机号注册
extern NSString *const HQJBRegisterInterface;
/// 发送验证码（商家入驻 新）
extern NSString *const HQJBGetByMobileCodeInterface;
/// 店铺升级状态接口
extern NSString *const HQJBGetShopUpgradeStateInterface;
/// 银行卡提现免费额度查询
extern NSString *const HQJBFreeAmountInterface;
/// 商家查看信息是否完善
extern NSString *const HQJBIsPerfectInterface;
/// 支付宝支付回调
extern NSString *const HQJBAlipayCallbackInterface;
/// XD支付支付宝回调
extern NSString *const HQJBAlipayServiceInterface;
/*_____________________________XD接口________________________________________*/
///创建订单
extern NSString *const HQJBXdorderInterface;
///商家查看合同列表
extern NSString *const HQJBshopAllESignListInterface;
/// 获取商家shopid
extern NSString *const HQJBRetrunShopIdInterface;
///  根据商家获取订单
extern NSString *const HQJBGetOrderListByShopIdInterface;
///查询当前xd商家的流程
extern NSString *const HQJBXdFlowInterface;
/// 企业基础信息状态
extern NSString *const HQJBXdShopAuditInterface;
///生成合同
extern NSString *const HQJBInitiateESignInterface;
///根据订单id获取订单详情
extern NSString *const HQJBGetOrderInfoByIdInterface;
///查询XD商家企业基础信息
extern NSString *const HQJBBuinessSignInterface;
/// H5 企业基础信息
extern NSString *const HQJBXdshopmsgInterface;

/// XD合同下载
extern NSString *const HQJBDownloadPactInterface;
/*_____________________________ XD商家奖励 接口________________________________________*/
/// 商家奖励项目
extern NSString *const HQJBXdMerchantProject ;

/// 员工列表
extern NSString *const HQJBGetMerchantEmployeeListInterface ;
/// 员工详情
extern NSString *const HQJBGetEmployeeDetailInterface ;
/// 员工邀请会员列表
extern NSString *const HQJBGetInvitedConsumerInterface ;
/// 员工邀请奖励明细（员工个人的奖励明细）
extern NSString *const HQJBGetEmployeeAwardInterface ;
/// 添加奖励
extern NSString *const HQJBAddXdAwardInterface ;
/// 员工详细资料（包括会员帐号信息）
extern NSString *const HQJBEmployeeDetailInterface ;
/// 删除员工
extern NSString *const HQJBRemoveEmployeeInterface ;
/// 员工二维码
extern NSString *const HQJBGetEmployeeQrcodeInterface ;
/// 新增员工
extern NSString *const HQJBAddEmployeeInterface  ;
/// 修改员工信息
extern NSString *const HQJBUpdateEmployeeInterface  ;
/// 生成二维码
extern NSString *const HQJBSaveQrcodeInterface  ;
/// 商家奖励
extern NSString *const HQJBGetMerchantAwardtInterface  ;
/// 员工角色显示
extern NSString *const HQJBGetRoleListInterface  ;
/// 新增角色（JSON对象，完整参数）
extern NSString *const HQJBAddRoleInterface  ;
/// 新增角色名称
extern NSString *const HQJBAddRoleNameInterface  ;
/// 修改角色
extern NSString *const HQJBUpdateRoleInterface  ;
/// 删除角色
extern NSString *const HQJBRemoveRoleInterface  ;
/// 奖励设置
extern NSString *const HQJBSetupAwardRateInterface  ;
/// 根据用户名关键字查询员工信息
extern NSString *const HQJSearchEmployeeByNameInterface  ;
/// 根据手机号关键数字查询员工信息
extern NSString *const HQJBSearchEmployeeByMobileInterface  ;
/// 根据用户名或手机号关键字查询员工信息
extern NSString *const HQJBSearchEmployeeInterface  ;
/// 返回职务列表
extern NSString *const HQJBGetTitleInterface ;
/// 获取商家注册的用户
extern NSString *const HQJBGetMemberListInterface ;
/// 根据用户名或手机号关键字查询商家用户
extern NSString *const HQJBSearchMemberListInterface ;
/// 根据用户名关键字查询商家注册用户信息
extern NSString *const HQJBSearchMemberListByNameInterface ;
/// 根据手机号关键字查询商家注册用户信息
extern NSString *const HQJBSearchMemberListByMobileInterface ;
/// 商家获取所有员工的奖励记录
extern NSString *const HQJBGetAllEmployeeAwardListInterface;
/// XD商家设置比率（多项提交）
extern NSString *const HQJBSetupMultiAwardRateInterface;
/// 获取商家总奖励的积分
extern NSString *const HQJBGetMerchantTotalAwardInterface;
/// 子公司奖励商家的积分列表
extern NSString *const HQJBSubAwardListInterface;
// 商家奖励会员的积分列表
extern NSString *const HQJBMerchnatAwardListInterface ;
/*   支付项目  */
extern NSString *const HQJBPurchasePayProject;
/// 购买XD商家
extern NSString *const HQJBXDaliPayInterface;
/// 商家直接注册支付宝回调接口
extern NSString *const HQJBXDRegisterAlipayInterface;
/// 购买RY值
extern NSString *const HQJBAliPayInterface;
///积分赠送发送验证码
extern NSString *const HQJBXdAwardSmsInterface;
///商家奖励会员的积分M
extern NSString *const HQJBMerchantAwardToConsumerInterface;



/************************************接口（结束）**********************************************/

@interface HQJBAPIManage : NSObject


@end
