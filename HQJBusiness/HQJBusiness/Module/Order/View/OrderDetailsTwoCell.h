//
//  OrderDetailsTwoCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsTwoCell : OrderDetailsBaseCell
@property (nonatomic, strong) NSString *number;
@property (nonatomic, copy ) void(^cilckPhone)(void);
@end

NS_ASSUME_NONNULL_END
