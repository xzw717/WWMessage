//
//  RewardsRecordSuperModel.h
//  HQJBusiness
//
//  Created by Ethan on 2020/8/7.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RewardsRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RewardsRecordSuperModel : NSObject
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *totalScore;
@property (nonatomic, strong) NSArray <RewardsRecordModel *>*data;
@end

NS_ASSUME_NONNULL_END
