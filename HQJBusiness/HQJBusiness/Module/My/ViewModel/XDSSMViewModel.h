//
//  XDSSMViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class XDSSMModel;
@interface XDSSMViewModel : NSObject
+ (void)requstXDShopServiceManagementList:(NSInteger)page orderstate:(NSInteger)state completion:(void(^)(NSArray <XDSSMModel *>*modelAry))completion error:(void (^)(NSError *error))xdssmError;
@end

NS_ASSUME_NONNULL_END
