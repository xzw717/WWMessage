//
//  OrderTableViewFooterView.h
//  HQJBusiness
//
//  Created by mymac on 2017/9/26.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
typedef void (^ContactBuyerBlock)(void);
@interface OrderTableViewFooterView : UITableViewHeaderFooterView
@property (nonatomic, copy) ContactBuyerBlock contactBuyerBlock;


- (void)setfootOrderModel:(OrderModel *)model
                    count:(NSInteger)count
                isUseDate:(BOOL)isUseDate;
@end
