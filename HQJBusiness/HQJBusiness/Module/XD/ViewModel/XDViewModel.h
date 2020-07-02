//
//  XDViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XDModel;
NS_ASSUME_NONNULL_BEGIN

@interface XDViewModel : NSObject
+ (void)requstXDWithCompletion:(void(^)(NSArray <XDModel *>*modelArray))completion ;
@end

NS_ASSUME_NONNULL_END
