//
//  OrderDetailsFourCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsFourCell : OrderDetailsBaseCell
@property (nonatomic, assign) CGFloat priceStr;
@property (nonatomic, strong) NSString *couponString;
@property (nonatomic, strong) NSString *titleStr;

@end

NS_ASSUME_NONNULL_END
