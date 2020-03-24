//
//  ShopModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/3/10.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject<NSCoding>
@property (nonatomic,copy)NSString *mid;//商家id
@property (nonatomic,copy)NSString *uid;//商家String类型id
@property (nonatomic,copy)NSString *parentId;//绑定的公司Id
@property (nonatomic,copy)NSString *serviceId;//暂未使用(归属区域子公司)
@property (nonatomic,copy)NSString *belongId;//注册人员id
@property (nonatomic,copy)NSString *relatedId;//关联的ID号
@property (nonatomic,copy)NSString *chiefMobile;//主要电话
@property (nonatomic,copy)NSString *registerTime;//注册时间
@property (nonatomic,copy)NSString *lastVisitedTime;//最后访问时间
@property (nonatomic,copy)NSString *mainBusiness;//用户头像
@property (nonatomic,copy)NSString *zipcode;//邮编
@property (nonatomic,copy)NSString *realname;//店铺名称
@property (nonatomic,copy)NSString *address;//地址
@property (nonatomic,copy)NSString *businessArea;//区域id
@property (nonatomic,copy)NSString *scoreRate;//积分消费返还ZH值比率
@property (nonatomic,copy)NSString *cashRate;//现金比例
@property (nonatomic,copy)NSString *discount;//打折
@property (nonatomic,copy)NSString *cardNo;//银行卡号
@property (nonatomic,copy)NSString *cardType;//证件类型
@property (nonatomic,copy)NSString *contactWay;//联系方式(以前的phone)
@property (nonatomic,copy)NSString *percapita;//人均
@property (nonatomic,copy)NSString *supervisor;//负责人
@property (nonatomic,copy)NSString *lat;//纬度
@property (nonatomic,copy)NSString *lng;//经度
@property (nonatomic,copy)NSString *merchantState;//店铺状态（上线、下线）
@property (nonatomic,copy)NSString *merchantSwitch;//店铺开关（开店、关店）
@property (nonatomic,copy)NSString *typeId;//商家类型
@property (nonatomic,copy)NSString *starClass;//星级



@property (nonatomic,copy)NSString *starScore;//星级
@property (nonatomic,copy)NSString *monthlysales;//月销量
@property (nonatomic,copy)NSString *isSource;//溯源
@property (nonatomic,copy)NSString *salenum;//备注

@property (nonatomic,copy)NSString *picture;//商家图片
@property (nonatomic,copy)NSString *cityid;//备注
@property (nonatomic,copy)NSString *registerState;//注册状态


@property (nonatomic,copy)NSString *classify;//分类
@property (nonatomic,copy)NSString *shophours;//店铺营业时间
@property (nonatomic,copy)NSString *credentials;//营业执照
@property (nonatomic,copy)NSString *bookings;//预定需知
@property (nonatomic,copy)NSString *feature;//本店特色
@property (nonatomic,copy)NSString *information;//商家信息
@property (nonatomic,copy)NSString *shoplogo;//店铺logo



//"mid": 1,
//        "parentId": 124,-------------------------------------------------------绑定的公司Id
//        "serviceId": 124,-------------------------------------------------------暂未使用(归属区域子公司)
//        "belongId": "1",--------------------------------------------------------注册人员id
//        "relatedId": null,--------------------------------------------------------关联的ID号
//        "realname": null,--------------------------------------------------------店铺名称
//        "cardType": null,----------------------------------------------------------证件类型
//        "cardNo": null,--------------------------------------------------------------银行卡号
//        "chiefMobile": null,--------------------------------------------------------主要电话
//        "contactWay": null,--------------------------------------------------------联系方式(以前的phone)
//        "address": "福州市闽侯县",---------------------------------------------地址
//        "businessArea": 500104,---------------------------------------------------区域id
//        "registerTime": 1461749998,----------------------------------------------注册时间
//        "lastVisitedTime": null,--------------------------------------------------------最后访问时间
//        "scoreRate": 0,-------------------------------------------------------------积分消费返还ZH值比率
//        "cashRate": 4,---------------------------------------------------------------现金比例
//        "percapita": 19,-------------------------------------------------------------人均
//        "mainBusiness": null,------------------------------------------------------用户头像
//        "discount": 0,------------------------------------------------------------------打折
//        "zipcode": null,-----------------------------------------------------------------邮编
//        "supervisor": "upload/423dfs342341.png",----------------------------负责人
//        "lat": 26.1255,------------------------------------------------------------------纬度
//        "lng": 119.2609,-----------------------------------------------------------------经度
//        "merchantState": 0,---------------------------------------------------------店铺状态（上线、下线）
//        "merchantSwitch": 0,-----------------------------------------------------店铺开关（开店、关店）
//        "typeId": 4,-------------------------------------------------------------商家类型
//        "starClass": null,-----------------------------------------------------星级
//        "starScore": null,------------------------------------------------------评分
//        "monthlysales": null,-----------------------------------------------------月销量
//        "isSource": null,----------------------------------------------------------溯源
//        "salenum": 0,-----------------------------------------------------------备注
//        "uid": null,-----------------------------------------------------------------商家String类型id
//        "information": null,-----------------------------------------------------商家信息
//        "shophours": null,-------------------------------------------------------店铺营业师姐
//        "credentials": null,--------------------------------------------------------营业执照
//        "picture": null,--------------------------------------------------------商家图片
//        "cityid": null,-------------------------------------------------------城市id
//        "register": null,----------------------------------------------------注册状态
//        "permit": null,-----------------------------------------------------许可证
//        "alipay": null,----------------------------------------------------阿里支付
//        "alipaytype": null,-----------------------------------------------阿里支付类型
//        "shoplogo": null,------------------------------------------------店铺logo
//        "feature": null,------------------------------------------------------本店特色
//        "iswifi": null,--------------------------------------------------------是否有wifi
//        "ispark": null,----------------------------------------------------------是否有停车场
//        "bookings": null,--------------------------------------------------------预定需知
//        "zhrule": null,----------------------------------------------------------------ZH赠送规则
//        "activity": null,---------------------------------------------------------------活动与服务
//        "category": null,----------------------------------------------------------------经营品类（商家填写）
//        "shopstar1": null,-------------------------------------------------------------星级评分1,计算得出
//        "shopstar2": null,-------------------------------------------------------------星级评分2,计算得出
//        "shopstar3": null,-------------------------------------------------------------星级评分3,计算得出
//        "shopstar4": null,-------------------------------------------------------------星级评分4,计算得出
//        "rolecheckstate": 0,----------------------------------------注册审核状态,0未审核，1审核成功
//        "regcheckstate": null,-----------------------------------------审核备注
//        "upgraderole": null,------------------------------------------升级角色
//        "rolecheckremark": null,------------------------------------审核备注
//        "upgradesaleoff": null,---------------------------------------升级折扣
//        "upgradecashzh": null,---------------------------------------升级现金zh值比例
//        "upgradebonuszh": null,--------------------------------------升级积分zh值比例
//        "upgraderoletime": null,--------------------------------------发起升级时间
//        "userid": null,-------------------------------------------用户ID
//        "licensename": null,------------------------------------------营业执照商家名称
//        "merchantsname": null,--------------------------------------商家真实姓名
//        "creditcode": null,----------------------------------------------统一社会信用代码
//        "otheragreement": null,----------------------------------------其它约定
//        "marketnote": null,------------------------------------------市场人员提交的备注
//        "picturecompact": null,-------------------------------合同图片
//        "name": null,-------------------------------------商家名称
//        "classify": null,-------------------------------分类
//        "checkstate": null,----------------------------------审核状态
//        "detailnote": "已标记为删除",-------------------备注
//"QrCode":"null",--------------------------------------二维码
// "rolecheckstate":"null",--------------------------升级审核状态
// "role":"null",-------------------------------角色
//"salenum":"null"------------------------销量

@end

NS_ASSUME_NONNULL_END
