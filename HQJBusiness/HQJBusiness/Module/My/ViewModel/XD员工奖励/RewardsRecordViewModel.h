//
//  RewardsRecordViewModel.h
//  HQJBusiness
//
//  Created by Ethan on 2020/8/7.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RewardsRecordSuperModel;
NS_ASSUME_NONNULL_BEGIN

@interface RewardsRecordViewModel : NSObject

+ (void)getAwardWithType:(NSString *)type
                    page:(NSInteger)page
              completion:(void(^)(RewardsRecordSuperModel *model))completion;
@end

NS_ASSUME_NONNULL_END
