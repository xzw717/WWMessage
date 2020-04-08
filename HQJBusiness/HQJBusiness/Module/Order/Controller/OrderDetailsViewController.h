//
//  OrderDetailsViewController.h
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"
@class OrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsViewController : ZW_ViewController
- (instancetype)initWithModel:(OrderModel *)model;
/// 备注
@property (nonatomic, strong) NSString *note;
@end

NS_ASSUME_NONNULL_END
