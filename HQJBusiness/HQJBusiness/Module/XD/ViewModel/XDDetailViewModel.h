//
//  XDDetailViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDPayModel.h"
#import "XDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XDDetailViewModel : NSObject

+ (CGFloat)getStringHeight:(NSString *)text;
+ (CGFloat)getSecCellHeight:(NSArray *)dataArray;
///查询当前xd商家的流程
+ (void)getXDShopState:(NSString *)shopid andPeugeotid:(NSString *)peugeotid completion:(void(^)(id dict))completion;
///生成合同
+ (void)initiateESign:(NSString *)shopid andType:(NSString *)type andState:(NSString *)state andPeugeotid:(NSString *)peugeotid completion:(void(^)(id result))completion;
///生成订单
+ (void)submitXDOrder:(NSString *)shopid andProid:(NSString *)proid andPrice:(NSString *)price completion:(void(^)(XDPayModel *model))completion;
@end

NS_ASSUME_NONNULL_END
