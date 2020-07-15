//
//  StoreInfoViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/14.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StoreInfoModel;
NS_ASSUME_NONNULL_BEGIN

@interface StoreInfoViewModel : NSObject
+ (void)requstStoreInfoWithModel:(void(^)(StoreInfoModel *model))completion ;
@end

NS_ASSUME_NONNULL_END
