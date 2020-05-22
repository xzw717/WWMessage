//
//  XDPayViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XDPayViewModel : NSObject
+ (void)getOrderInfoById:(NSString *)orderid completion:(void(^)(XDDetailModel *model))completion;
@end

NS_ASSUME_NONNULL_END
