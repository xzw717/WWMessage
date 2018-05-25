//
//  OrderTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2017/8/18.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderTableViewCell : UITableViewCell
@property (nonatomic, strong) OrderModel *orderModel;
@property (nonatomic, strong) GoodsModel *orderGoodsModel;
@property (nonatomic, strong) NSString *orderDate;
@end
