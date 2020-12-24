//
//  BooKScoreModel.h
//  WuWuMap
//
//  Created by 姚志中 on 2020/11/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BooKScoreModel : NSObject
//activityScore = 1000;
//cash = 0;
//createTime = 1608712314;
//curstate = 0;
//exchangeFromId = 33789;
//exchangeToId = 8775;
//exchangeType = 56;
//id = 942449515;
//isChangeable = 0;
//isLocked = 0;
//itype = 112;
//lockLast = 0;
//mobile = "<null>";
//note = "0,960.0,0";
//orderNo = "<null>";
//score = 1200;
//uid = 33789;
//uname = "<null>";
//zhValue = "-48";
@property (nonatomic,copy)NSString *orderNo;//订单号
@property (nonatomic,copy)NSString *uname;//用户名
@property (nonatomic,assign)NSInteger exchangeType;//
@property (nonatomic,copy)NSString *score;//
@property (nonatomic,copy)NSString *activityScore;//
@property (nonatomic,copy)NSString *createTime;//



@end

NS_ASSUME_NONNULL_END
