//
//  OrderDetailsViewController.h
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJBaseSubVC.h"
@class OrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsViewController : HQJBaseSubVC
- (instancetype)initWithModel:(OrderModel *)model;
@end

NS_ASSUME_NONNULL_END
