//
//  UnionActivityListModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnionActivityListModel : NSObject
//"id": 3,
//"activityName": "购！购！购！",
//"duration": "2019-09-27 08:56:00-2019-09-30 20:16:00",
//"endTime": "2019-09-27 08:56:00",
//"hash": "",
//"banner": "%dedsdf",
//"curstate": "报名结束",
//"note": null,
//"rule": null
@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *activityName;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *curstate;
@property (nonatomic, strong) NSString *isHost;
@property (nonatomic, strong) NSString *isSelfHost;//0.是自己发起  1.不是自己发起
@property (nonatomic, strong) NSString *isSignUp;//0.未报名  1.已报名
@end

NS_ASSUME_NONNULL_END
