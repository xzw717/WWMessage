//
//  AddUnionModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddUnionModel : NSObject
///联盟活动
@property (nonatomic, strong) NSString *activityName;//联盟活动名称
@property (nonatomic, strong) NSString *start;//开始时间
@property (nonatomic, strong) NSString *end;//结束时间
@property (nonatomic, strong) NSString *banner;//资质
@property (nonatomic, strong) NSString *area;//商家区域，选择不限时为0
@property (nonatomic, strong) NSString *areaId;//商家区域，选择不限时为0
@property (nonatomic, strong) NSString *maxCount;//商家数量上限，当前联盟活动最多可报名参加的的商家数量（大于0的整数）
@property (nonatomic, strong) NSString *merchantCount;//联盟成立商家数量，达到这个数量，联盟成立（活动按时启动）
@property (nonatomic, strong) NSString *merchantType;//商家类型，选择不限时为0，举例：1，2，3
@property (nonatomic, strong) NSString *merchantTypeId;//商家类型，选择不限时为0，举例：1，2，3
@property (nonatomic, strong) NSString *industry;//商家所属行业，选择不限时为0，举例：1，2，3
@property (nonatomic, strong) NSString *industryId;//商家所属行业，选择不限时为0，举例：1，2，3
@property (nonatomic, strong) NSString *pushSettings;//联盟券推送时间，0，举例：1，2
@property (nonatomic, strong) NSString *pushSettingsId;//联盟券推送时间，0，举例：1，2
@property (nonatomic, strong) NSString *mid;//指定商家id，举例：1，2，3
@property (nonatomic, strong) NSString *midId;//指定商家id，举例：1，2，3
@property (nonatomic, strong) NSString *couponType;//联盟活动的优惠券类型，商家可以发送的优惠券类型，当选择不限为0，举例：1，2，3
@property (nonatomic, strong) NSString *couponTypeId;//联盟活动的优惠券类型，商家可以发送的优惠券类型，当选择不限为0，举例：1，2，3
@property (nonatomic, strong) NSString *rule;//规则说明*：

@property (nonatomic, strong) NSString *curstate;//0可修改  1.不可修改

///联盟券
@property (nonatomic, strong) NSString *isHost;//0.发起人  1.参与方
@property (nonatomic, strong) NSString *isHostId;//0.发起人  1.参与方
@property (nonatomic, strong) NSString *couponId;//优惠券Id
@property (nonatomic, strong) NSString *couponName;//优惠券名称
@property (nonatomic, strong) NSString *typeId;//联盟券类型
@property (nonatomic, strong) NSString *userId;//商家id
@property (nonatomic, strong) NSString *startTime;//开始时间
@property (nonatomic, strong) NSString *endTime;//结束时间

@property (nonatomic, strong) NSString *reducePrice;//联盟券面额
@property (nonatomic, strong) NSString *minPrice;//使用条件：    最低订单金额

@property (nonatomic, strong) NSString *count;//发行量
@property (nonatomic, strong) NSString *couponCount;//发行量

@property (nonatomic, strong) NSString *receiveNumber;//每人限领：    1 （默认一张，可修改）
@property (nonatomic, strong) NSString *receiveNum;//每人限领：    1 （默认一张，可修改）


@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *receiveCount;//领取数量

@property (nonatomic, strong) NSString *usedCount;//使用数量
@property (nonatomic, strong) NSString *useCount;//使用数量

@property (nonatomic, strong) NSString *typeName;//联盟活动选择的的优惠券类型
@property (nonatomic, strong) NSString *text;//联盟活动的优惠券类型，商家可以发送的优惠券类型




@end

NS_ASSUME_NONNULL_END

