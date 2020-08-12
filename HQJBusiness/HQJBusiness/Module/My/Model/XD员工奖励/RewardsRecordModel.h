//
//  RewardsRecordModel.h
//  HQJBusiness
//
//  Created by Ethan on 2020/8/7.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardsRecordModel : NSObject
/*
 total    double    总数
 id    long    数据库自动编号
 uid    long    交易发起人的ID
 itype    int    交易三方关系
 createTime    long    创建时间
 exchangeType    int    交易类型
 exchangeFromId    long    支付人
 exchangeToId    long    接受人
 zhValue    double    荣誉值
 score    double    积分
 cash    double    现金
 activityScore    double    活动积分
 isChangeable    int    是否可兑换
 isLocked    int    是否锁定
 lockLast    int    锁定时长
 curstate    int    目前状态
 orderNo    String    订单号
 note    String    备注
 */


/*
 
 total    Double    总数
 id    long    数据库自动编号
 uid    long    交易发起人的ID
 itype    int    交易三方关系
 createTime    long    创建时间
 exchangeType    int    交易类型
 exchangeFromId    long    支付人
 exchangeToId    long    接受人
 zhValue    double    荣誉值
 score    double    积分
 cash    double    现金
 activityScore    double    活动积分
 isChangeable    int    是否可兑换
 isLocked    int    是否锁定
 lockLast    int    锁定时长
 curstate    int    目前状态
 orderNo    String    订单号
 note    String    备注
 */

@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *itype;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *exchangeType;
@property (nonatomic, strong) NSString *exchangeFromId;
@property (nonatomic, strong) NSString *exchangeToId;
@property (nonatomic, assign) double zhValue;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) double cash;
@property (nonatomic, assign) double activityScore;
@property (nonatomic, assign) NSInteger isChangeable;
@property (nonatomic, assign) NSInteger isLocked;
@property (nonatomic, assign) NSInteger lockLast;
@property (nonatomic, assign) NSInteger curstate;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *note;

@end

NS_ASSUME_NONNULL_END
