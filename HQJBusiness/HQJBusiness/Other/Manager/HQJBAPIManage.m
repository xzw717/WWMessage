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
NSString *const HQJBBonusDomainName = @"http://47.98.45.218:80/wuwuInterface/merchant/";
NSString *const HQJBBounsOrder  = @"http://shoptest.heqijia.net/";
/// 台卡域名
NSString *const HQJBBonusDomainDeccaName = @"http://47.98.45.218:80/";
/// 优惠券
NSString *const WWMCouponDomain = @"http://47.98.45.218/";
/// 直播域名
NSString *const WWMLiveDomain = @"106.13.213.51";

/// 商家注册 . 商家升级. 已经签合同 .入驻协议 域名
NSString *const HQJBH5UpDataDomain = @"http://28ko268520.qicp.vip/shopappH5/index.html#/";


/// XDH5域名
NSString *const HQJBXDH5Domain = @"http://shoptest.heqijia.net/assets/xdESign/index.html#/xdshopmsg?";


/// 测试：http://shoptest.heqijia.net/assets/xdESign/index.html#/xdshopmsg?shopid=xxx&mobile=xxx&peugeotid=xxx
/// 正式：http://statics.wuwuditu.com/shopappH5/index.html#/xdshopmsg?shopid=xxx&mobile=xxx&peugeotid=xxx
#else         //发布阶段

NSString *const HQJBDomainName = @"http://shop.wuwuditu.com/";
NSString *const HQJBFeedbackDomainName = @"http://sub.wuwuditu.com/";
NSString *const HQJBversionInformationDomainName = @"http://app.wuwuditu.com/";
NSString *const HQJBUpdataAPPDomainName = @"http://app.heqijia.net/app/";
NSString *const HQJBItunesDomainName= @"https://itunes.apple.com/cn/app/%E7%89%A9%E7%89%A9%E5%9C%B0%E5%9B%BE/id1132505092?mt=8";
NSString *const HQJBBonusDomainName = @"http://interface.ww1000.cn:8080/wuwuInterface/merchant/";
/// 优惠券
NSString *const WWMCouponDomain = @"http://statics.wuwuditu.com/";


NSString *const HQJBBounsOrder  = @"http://shop.wuwuditu.com/";


NSString *const HQJBBonusDomainDeccaName = @"http://interface.ww1000.cn:8080/";
/// 直播域名
NSString *const WWMLiveDomain = @"http://47.98.45.218/";
/// 商家注册 . 商家升级. 已经签合同 域名
NSString *const HQJBH5UpDataDomain = @"http://statics.wuwuditu.com/shopappH5/index.html#/";
/// XDH5域名
NSString *const HQJBXDH5Domain = @"http://statics.wuwuditu.com/shopappH5/index.html#/xdshopmsg?";
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
NSString *const HQJBApplyListInterface = @"applyList";
/// 待审核申请（购买ZH值）
NSString *const HQJBZHPurchaseApplyListInterface = @"zhPurchaseApplyList";
/// 待审核申请（现金提取）
NSString *const HQJBCashDrawApplyListInterface = @"cashDrawApplyList";
/// 待审核申请（积分兑现)
NSString *const HQJBScoreExchangeInterface = @"scoreExchange";
/// 待审核申请（ZH值设定）
NSString *const HQJBZHSetupInterface = @"zhSetup";



///积分交易明细
NSString *const HQJBScoreTradeListInterface = @"scoreTradeList";
///现金交易明细
NSString *const HQJBCashTradeListInterface = @"cashTradeList";
///积分兑现明细
NSString *const HQJBScoreExchangeListInterface = @"scoreExchangeList";
///获取商家台卡信息
NSString *const HQJBGetMerchantBasicInfoInterface = @"getMerchantBasicInfo?";
///获取商家个人信息
NSString *const HQJBGetMerchantMasterInfoInterface = @"getMerchantMasterInfo?";

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
NSString *const HQJBCashSalesInterface = @"cashSells";
/// 删除银行卡
NSString *const HQJBDeleteBankCardInterface = @"deleteBankCard";
/// 根据id查询优惠劵信息接口
NSString *const HQJBGetCouponByIdInterface =  @"coupon/app/getCouponById";

/*_____________________________直播接口________________________________________*/
/// 发送消息
NSString *const HQJBSendMessageInterface =  @"usercenter/discussion/SendMessage";
///获取消息
NSString *const HQJBGetMessageInterface = @"usercenter/discussion/GetMessage";
#pragma mark ------------------------ 商家重构增加接口 ------------------------
///通过短信验证码登录(发送短信)
NSString *const HQJBGetLoginCodeInterface = @"getLoginCode";
///通过短信验证码登录
NSString *const HQJBMerchantSmsLoginInterface = @"merchantSmsLogin";
///服务商注册时发送手机短信R
NSString *const HQJBRegisterCodeInterface = @"registerCode";
/// 店铺界面订单数据
NSString *const HQJBShopfindorderstatecodeInterface = @"order/shopfindorderstatecode.action";




#pragma mark ------------------------ H5 ------------------------
/// 创建店铺
NSString *const HQJBCreateStoreInterface = @"newstore";
/// 注册店铺审核失败
NSString *const HQJBRegisteredStoreReviewFailedInterface = @"storemessage";
/// 注册信息填写完成
NSString *const HQJBRegistrationInformationCompletedInterface = @"goaudit";
/// 升级/升级失败修改信息
NSString *const HQJBUpgradeUnsuccessfulInterface = @"upgrade";
/// 升级规则
NSString *const HQJBUpgradeRuleInterface = @"upgradeAgreement";
/// 发布规范
NSString *const HQJBReleaseSpecificationInterface = @"shopH5/register/#/publishAgreement";
/// 商家入驻协议
NSString *const HQJBMerchantSettlementSgreementInterface = @"shopH5/register/#/registerAgreement";
/// 头条
NSString *const HQJBHeadlinesInterface = @"appH5/#/shopH5";
/// 已经签合同
NSString *const HQJBDownloadUpdateInterface = @"downloadUpdate";

///自主入驻
/// 商家查看合同列表
NSString *const HQJBFindShopEsignListInterface = @"shopapi/findShopEsign.action";
/// 入驻协议
NSString *const HQJBRegisterAgreementListInterface = @"registerAgreement";
/// 入驻协议
NSString *const HQJBNewstoreListInterface = @"newstore";

/*_____________________________ XD商家 接口________________________________________*/
///根据商家获取订单
NSString *const HQJBGetOrderListByShopIdInterface = @"xdorder/getOrderListByShopId.action";
/// 获取商家shopid
NSString *const HQJBRetrunShopIdInterface = @"shopAdmin/retrunShopId.action";

NSString *const HQJBXdorderInterface = @"xdorder/save.action";
/// 企业基础信息状态
NSString *const HQJBXdShopAuditInterface = @"XdShopAudit/reClomn.action";
//////商家查看合同列表
NSString *const HQJBshopAllESignListInterface = @"xdesign/shopAllESignList.action";
///查询当前xd商家的流程
NSString *const HQJBXdFlowInterface = @"xdesign/XdFlow.action";
///生成合同
NSString *const HQJBInitiateESignInterface = @"xdesign/initiateESign.action";
///根据订单id获取订单详情
NSString *const HQJBGetOrderInfoByIdInterface = @"xdorder/getOrderInfoById.action";
///查询XD商家企业基础信息
NSString *const HQJBBuinessSignInterface =@"buinessSign/retrunBussiness.action";
@implementation HQJBAPIManage

@end

