//
//  HQJB_APIManage.m
//  WuWuMap
//
//  Created by mymac on 2018/5/3.
//  Copyright © 2018年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJBAPIManage.h"

#ifdef DEBUG  //测试阶段


#pragma mark --- 测试使用的域名
NSString *const HQJBDomainName = @"http://shoptest.heqijia.net/";
NSString *const HQJBFeedbackDomainName = @"http://subtest.heqijia.net/";
NSString *const HQJBversionInformationDomainName = @"http://apptest.heqijia.net/";
NSString *const HQJBUpdataAPPDomainName = @"http://apptest.heqijia.net/";
NSString *const HQJBBonusDomainName = @"http://47.98.45.218/";
NSString *const HQJBBounsOrder  = @"http://shoptest.heqijia.net/";
/// 台卡域名   XD 商家奖励通用
NSString *const HQJBBonusDomainDeccaName = @"http://47.98.45.218:80/";
/// 优惠券
NSString *const WWMCouponDomain = @"http://47.98.45.218/";
/// 直播域名
NSString *const WWMLiveDomain = @"106.13.213.51";

/// 商家注册 . 商家升级. 已经签合同 .入驻协议 域名
NSString *const HQJBH5UpDataDomain = @"http://47.98.45.218:8080/";
/// 商家奖励
NSString *const HQJBRewardDomainName = @"http://47.98.45.218/";

/// XDH5域名
NSString *const HQJBXDH5Domain = @"http://shoptest.heqijia.net/assets/xdESign/index.html#/xdshopmsg?";
/// H5域名
NSString *const HQJBXDDownloadPactDomain = @"http://47.98.45.218:8080/";


#pragma mark ---培训使用的域名

//NSString *const HQJBDomainName = @"http://shop.wuwuditu.cn/";
//NSString *const HQJBFeedbackDomainName = @"http://sub.wuwuditu.cn/";
//NSString *const HQJBversionInformationDomainName = @"http://app.wuwuditu.cn/";
//NSString *const HQJBUpdataAPPDomainName = @"http://apptest.heqijia.net/";
//NSString *const HQJBBonusDomainName = @"http://www.wuwuditu.cn/";
//NSString *const HQJBBounsOrder  = @"http://shop.wuwuditu.cn/";
///// 台卡域名   XD 商家奖励通用
////NSString *const HQJBBonusDomainDeccaName = @"http://47.98.45.218:80/";
///// 优惠券
//NSString *const WWMCouponDomain = @"http://h5.wuwuditu.cn/";
//
///// 商家注册 . 商家升级. 已经签合同 .入驻协议 域名
//NSString *const HQJBH5UpDataDomain = @"http://h5.wuwuditu.cn/";
///// 商家奖励
////NSString *const HQJBRewardDomainName = @"http://47.98.45.218/";
//
///// XDH5域名
////NSString *const HQJBXDH5Domain = @"http://shoptest.heqijia.net/assets/xdESign/index.html#/xdshopmsg?";
///// H5域名
//NSString *const HQJBXDDownloadPactDomain = @"http://h5.wuwuditu.cn/";




#else         //发布阶段

NSString *const HQJBDomainName = @"http://shop.wuwuditu.com/";
NSString *const HQJBFeedbackDomainName = @"http://sub.wuwuditu.com/";
NSString *const HQJBversionInformationDomainName = @"http://app.wuwuditu.com/";
NSString *const HQJBUpdataAPPDomainName = @"http://app.wuwuditu.cn/";
NSString *const HQJBBonusDomainName = @"http://interface.ww1000.cn:8080/";
/// 优惠券
NSString *const WWMCouponDomain = @"http://statics.wuwuditu.com/";


NSString *const HQJBBounsOrder  = @"http://shop.wuwuditu.com/";


//NSString *const HQJBBonusDomainDeccaName = @"http://interface.ww1000.cn:8080/";

/// 商家注册 . 商家升级. 已经签合同 域名
NSString *const HQJBH5UpDataDomain = @"http://statics.wuwuditu.com/";
/// XDH5域名
//NSString *const HQJBXDH5Domain = @"http://statics.wuwuditu.com/shopappH5/index.html#/xdshopmsg?";
/// H5域名
NSString *const HQJBXDDownloadPactDomain = @"http://statics.wuwuditu.com/";

/// 商家奖励
//NSString *const HQJBRewardDomainName = @"http://47.98.45.218/";
#endif


NSString *const HQJBImageDomainName = @"http://wuwuditu.img-cn-hangzhou.aliyuncs.com/";





/*_____________________________我是分割线________________________________________*/

/// 积分相关的项目
NSString *const HQJBMerchantInterface = @"wuwuInterface/merchant/";

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

/// 支付宝支付回调
NSString *const HQJBAlipayCallbackInterface = @"alipayCallback";
/// XD支付支付宝回调
NSString *const HQJBAlipayServiceInterface = @"alipayService";





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
NSString *const HQJBUpgradeRuleInterface = @"shopappH5/index.html#/upgradeAgreement";
/// 发布规范
NSString *const HQJBReleaseSpecificationInterface = @"shopH5/register/#/publishAgreement";
/// 商家入驻协议
NSString *const HQJBMerchantSettlementSgreementInterface = @"shopH5/register/#/registerAgreement";
/// 头条
NSString *const HQJBHeadlinesInterface = @"appH5/#/shopH5";
/// 已经签合同
NSString *const HQJBDownloadUpdateInterface = @"shopappH5/index.html#/downloadUpdate";

///自主入驻
/// 商家查看合同列表
NSString *const HQJBFindShopEsignListInterface = @"shopapi/findShopEsign.action";
/// 入驻协议
NSString *const HQJBRegisterAgreementListInterface = @"shopappH5/index.html#/registerAgreement";
///商家注册完成后跳转的H5
NSString *const HQJBNewstoreListInterface = @"shopappH5/#/newstore";

/// 根据城市名获取地区列表
NSString *const HQJBQueryCityAreaInterface = @"shop/queryCityArea.action";
/// 商家手机号注册
NSString *const HQJBRegisterInterface = @"shopapi/register.action";
/// 发送验证码（商家入驻 新）
NSString *const HQJBGetByMobileCodeInterface = @"shopapi/getByMobileCode.action";
/// 店铺升级状态接口
NSString *const HQJBGetShopUpgradeStateInterface = @"shopapi/getShopUpgradeState.action";

/// 银行卡提现免费额度查询
NSString *const HQJBFreeAmountInterface = @"freeAmount";
/// 商家查看信息是否完善
NSString *const HQJBIsPerfectInterface = @"shop/isPerfect.action";



;
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
/// H5 企业基础信息
NSString *const HQJBXdshopmsgInterface = @"shopappH5/index.html#/xdshopmsg";



/// XD合同下载
NSString *const HQJBDownloadPactInterface = @"shopappH5/index.html#/downloadPact";

/*_____________________________ XD商家奖励 接口________________________________________*/

/// 商家奖励项目
NSString *const HQJBXdMerchantProject = @"wuwuInterface/xdMerchant/";

/// 员工列表
NSString *const HQJBGetMerchantEmployeeListInterface = @"getMerchantEmployeeList";
/// 员工详情
NSString *const HQJBGetEmployeeDetailInterface = @"getEmployeeDetail";
/// 员工邀请会员列表
NSString *const HQJBGetInvitedConsumerInterface = @"getInvitedConsumer";
/// 员工邀请奖励明细（员工个人的奖励明细）
NSString *const HQJBGetEmployeeAwardInterface = @"getEmployeeAward";
/// 添加奖励
NSString *const HQJBAddXdAwardInterface = @"addXdAward";
/// 员工详细资料（包括会员帐号信息）
NSString *const HQJBEmployeeDetailInterface = @"employeeDetail";
/// 删除员工
NSString *const HQJBRemoveEmployeeInterface = @"removeEmployee";
/// 员工二维码
NSString *const HQJBGetEmployeeQrcodeInterface = @"getEmployeeQrcode";
/// 新增员工
NSString *const HQJBAddEmployeeInterface = @"addEmployee";
/// 修改员工信息
NSString *const HQJBUpdateEmployeeInterface = @"updateEmployee";
/// 生成二维码
NSString *const HQJBSaveQrcodeInterface = @"saveQrcode";
/// 商家奖励
NSString *const HQJBGetMerchantAwardtInterface = @"getMerchantAward";
/// 员工角色显示
NSString *const HQJBGetRoleListInterface = @"getRoleList";
/// 新增角色（JSON对象，完整参数）
NSString *const HQJBAddRoleInterface = @"addRole";
/// 新增角色名称
NSString *const HQJBAddRoleNameInterface =@"addRoleName";
/// 修改角色
NSString *const HQJBUpdateRoleInterface =@"updateRole";
/// 删除角色
NSString *const HQJBRemoveRoleInterface =@"removeRole";
/// 奖励设置
NSString *const HQJBSetupAwardRateInterface =@"setupAwardRate";
/// 根据用户名关键字查询员工信息
NSString *const HQJSearchEmployeeByNameInterface =@"searchEmployeeByName";
/// 根据手机号关键数字查询员工信息
NSString *const HQJBSearchEmployeeByMobileInterface =@"searchEmployeeByMobile";
/// 根据用户名或手机号关键字查询员工信息
NSString *const HQJBSearchEmployeeInterface =@"searchEmployee";
/// 返回职务列表
NSString *const HQJBGetTitleInterface =@"getTitle";
/// 获取商家注册的用户
NSString *const HQJBGetMemberListInterface =@"getMemberList";
/// 根据用户名或手机号关键字查询商家用户
NSString *const HQJBSearchMemberListInterface =@"searchMemberList";
/// 根据用户名关键字查询商家注册用户信息
NSString *const HQJBSearchMemberListByNameInterface =@"searchMemberListByName";
/// 根据手机号关键字查询商家注册用户信息
NSString *const HQJBSearchMemberListByMobileInterface =@"searchMemberListByMobile";
/// 商家获取所有员工的奖励记录
NSString *const HQJBGetAllEmployeeAwardListInterface =@"getAllEmployeeAwardList";
/// XD商家设置比率（多项提交）
NSString *const HQJBSetupMultiAwardRateInterface =@"setupMultiAwardRate";
/// 获取商家总奖励的积分
NSString *const HQJBGetMerchantTotalAwardInterface =@"getMerchantTotalAward";
/// 商家奖励会员的积分列表
NSString *const HQJBSubAwardListInterface = @"subAwardList";
/// 商家奖励会员的积分列表
NSString *const HQJBMerchnatAwardListInterface =@"merchnatAwardList";

/*   支付项目  */
NSString *const HQJBPurchasePayProject =@"purchasePay/pay/";
/// 购买RY值
NSString *const HQJBAliPayInterface = @"aliPay";
/// 购买XD商家
NSString *const HQJBXDaliPayInterface = @"XDaliPay";
/// 商家直接注册支付宝回调接口
NSString *const HQJBXDRegisterAlipayInterface = @"XDRegisterAlipay";
///积分赠送发送验证码
NSString *const HQJBXdAwardSmsInterface = @"xdAwardSms";
///商家奖励会员的积分
NSString *const HQJBMerchantAwardToConsumerInterface = @"merchantAwardToConsumer";

@implementation HQJBAPIManage

@end

