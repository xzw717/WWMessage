//
//  StoreModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreSubItemModel.h"
NS_ASSUME_NONNULL_BEGIN
/*
 "todayCounts": 57,                        --- 今日订单数
 
 "goodsCounts": 1,                           --- 商品订单数
 
 "receivablesCounts": 1,                           --- 收款订单数
 
 "verifiedCounts": 1,                           --- 已核销订单
 
 "paymentCounts": 1,                           --- 代付款
 
 "evaluateCounts": 1,                           --- 待评价
 
 "unwrittenCounts": 1                           --- 待核销订单
 */
@interface StoreModel : NSObject
@property (nonatomic, strong) NSString *imageViewName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray <StoreSubItemModel *>*itemModel;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSString *todayCounts;
@property (nonatomic, strong) NSString *goodsCounts;
@property (nonatomic, strong) NSString *receivablesCounts;
@property (nonatomic, strong) NSString *verifiedCounts;
@property (nonatomic, strong) NSString *paymentCounts;
@property (nonatomic, strong) NSString *evaluateCounts;
@property (nonatomic, strong) NSString *unwrittenCounts;

@end

NS_ASSUME_NONNULL_END
