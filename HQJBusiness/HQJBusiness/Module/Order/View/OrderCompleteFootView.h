//
//  OrderCompleteFootView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/8.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CompleteFootHeight (460 / 3.f)

NS_ASSUME_NONNULL_BEGIN
@class OrderModel;
typedef void (^ContactBlock)(void);
@interface OrderCompleteFootView : UITableViewHeaderFooterView
@property (nonatomic, copy) ContactBlock contactBuyerBlock;


- (void)setfootOrderModel:(OrderModel *)model
                    count:(NSInteger)count
                isUseDate:(BOOL)isUseDate;
@end

NS_ASSUME_NONNULL_END
