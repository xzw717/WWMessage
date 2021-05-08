//
//  StoreInfoModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/14.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreInfoModel : NSObject
/// ----0：未完善 1：已完善
@property (nonatomic, assign) NSInteger state;
/// ---已签合同数量
@property (nonatomic, assign) NSInteger pactCount;
/// ---待签合同数量
@property (nonatomic, assign) NSInteger stayPactCount;
@end

NS_ASSUME_NONNULL_END
