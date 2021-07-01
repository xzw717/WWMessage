//
//  OrderDetailGoodsCell.h
//  WuWuMap
//
//  Created by Ethan on 2021/6/23.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailGoodsCell : UITableViewCell
@property (nonatomic, strong) GoodsModel *orderGoodsModel;
@end

NS_ASSUME_NONNULL_END
