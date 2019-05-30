//
//  OrderDetailsHeaderView.h
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsPrintHeaderView : UIView
/// 订单状态
@property (nonatomic, strong) NSString *states;
@property (nonatomic, copy) void(^clickPrint)(void);
@end

NS_ASSUME_NONNULL_END
