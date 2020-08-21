//
//  SetProportionViewModel.h
//  HQJBusiness
//
//  Created by Ethan on 2020/8/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetProportionViewModel : NSObject
+ (void)setReward:(NSDictionary *)dic
       completion:(void(^)(void))completion ;
@end

NS_ASSUME_NONNULL_END
