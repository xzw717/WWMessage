//
//  GoodsReleaseMainCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/12.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^textUpdate)(void);
@interface GoodsReleaseMainCell : ZW_TableViewCell
@property (nonatomic, copy) textUpdate cellUpdata;
- (void)cellWithPricetext:(NSString *)priceText proportion:(NSString *)pro;
- (void)mainDataWithTitle:(NSString *)tit countPlaceholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
