//
//  MyListModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyListModel : NSObject
@property (nonatomic,copy)NSString *tradeid ;
@property (nonatomic,copy)NSString *orderid ;
@property (nonatomic,copy)NSString *tradetime ;
@property (nonatomic,copy)NSString *fromid ;
@property (nonatomic,copy)NSString *frealname ;
@property (nonatomic,copy)NSString *fmembertype ;
@property (nonatomic,copy)NSString *fmobile ;
@property (nonatomic,copy)NSString *accountId ;
@property (nonatomic,copy)NSString *payBank ;
@property (nonatomic,copy)NSString *toid ;
@property (nonatomic,copy)NSString *trealname ;
@property (nonatomic,copy)NSString *tmembertype ;
@property (nonatomic,copy)NSString *tmobile ;
@property (nonatomic,copy)NSString *currency ;
@property (nonatomic,copy)NSString *amount ;

/// CASH(1),             // 兑换现金（商家、子公司）
/*COMEBACK(2),           // ZH退货(商家向子公司申请退还ZH值)
GIVEZH(3),             // 赠送zh值（商家、子公司）
GIVESCORE(4),           // 赠送积分（商家、子公司）
SCORECASH(5),           // 积分兑换现金（服务商、商家、子公司）
DIVERTSCORE(6),         // 转移积分（服务商）
DIVERTZH(7),           // 转移ZH值（子公司）
UPGRADE(8),           // 商家升级（商家）
UPDATERATE(9),           // 商家修改比例（商家）
CASHCONSUMER(10),        // 现金消费（消费者）
SCORECASHZH(11),         // 积分兑换zh值（商家、子公司）
SILVERPAY(12),           // 银联支付（商家、子公司）
PAY(13),             // 支付宝支付（商家、子公司）
WEIXIN(14),           // 微信支付（商家、子公司）
SCORECONSUMER(15),         // 积分消费（消费者）
SCORECOMEBACK(16),         // 强制回收积分（子公司中的管理者）
SPREGISTER(17),          // 服务商注册
TRANSCORETOSELF(18),      // 服务商将积分转移给自己的消费者帐号
TRANSCORETOCONSUMER(19),    // 服务商转移积分给消费者（有手续费）
TRANSCORETOOWNSPACCOUNT(20),  // 将自己消费者帐号上的积分转到服务商帐号下
SCORETOZHBYHAND(21),      // 将自己帐户上的积分转化为ZH值
AUTOTRANFERSCORETOZH(22),    // 自动将积分转ZH值
CONSUMERWEIGHTSCORE(23),    // 系统触发的权利奖励积分
PURCHASEZHVALUE(24),      // 子公司到总公司购买ZH值
SUBSELLZHVALUE(25),        // 子公司销售ZH值给商家
GIVEACTIVITYSCORE(26),      // 赠送活动积分
SPAWARDSCORE(27),        // 服务商系统奖励
REDBAG(28),            // 红包
AASHARE(29),          // AA
WEIGHTAWARD(30),        // 权重奖励
CASHTOZH(31),          // 现金购买ZH值
INITOFAASHARE(32),        // AA的发起人
GLOBALAWARD(33),        // 全球奖励
SUBAWARD(34),          // 子公司奖励
MEETINGSCORE(35),        // 会议赠送积分
INTEGRALPREDIALING(36),       // 积分预拨
GETREDBAG(37),          // 获取红包
TURNBACKREDBAG(38),        // 返还红包
MEMBERREGISTER(39),        // 会员注册奖励
COUPON(40),            // 优惠券积分买单
CASHCOUPON(41),          // 优惠券现金买单
TRACEALIPAY(42),        // 溯源费用,支付宝支付
TRACEWEIXIN(43),        // 溯源费用,微信支付
OWNERAWARD(44),          // XD商家下属会员消费奖励
EMPLOYEEAWARD(45),        // XD商家员工注册的会员消费奖励
SUBPURCHASESCORE(46);      // 子公司到总公司购买积分 */
@property (nonatomic,copy)NSString *tradetype ;
@property (nonatomic,copy)NSString *tradeDesc ;
@property (nonatomic,copy)NSString *comment ;
@property (nonatomic,copy)NSString *flag ;
@property (nonatomic,copy)NSString *is_aatrade ;
@property (nonatomic,copy)NSString *is_aamaster ;
@property (nonatomic,copy)NSString *camount ;
//修改zh比例所需字段，其他不用
@property (nonatomic,copy)NSString *scoreRate ;
@property (nonatomic,copy)NSString *cashRate ;


/// 实际到账
@property (nonatomic,copy)NSString *estimate;
@end
