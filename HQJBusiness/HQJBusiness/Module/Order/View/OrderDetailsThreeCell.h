//
//  OrderDetailsThreeCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsThreeCell : OrderDetailsBaseCell
- (void)goodsImage:(NSString *)image
         goodsName:(NSString *)name
        goodsCount:(NSInteger)count
        goodsPrice:(CGFloat)price;
@end

NS_ASSUME_NONNULL_END
