//
//  OrderDetailDefaultCell.h
//  WuWuMap
//
//  Created by Ethan on 2021/6/21.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * _Nonnull const isCallShop = @"isCallShop";
static NSString * _Nonnull const isPrice = @"isPrice";
static NSString * _Nonnull const isOrderid = @"isOrderid";
static NSString * _Nonnull const isDefault = @"isDefault";
static NSString * _Nonnull const isRemake = @"isRemake";

typedef void(^OrderCopBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailDefaultCell : UITableViewCell
@property (nonatomic, copy) OrderCopBlock orderCopy;
//@property (nonatomic, assign) BOOL isPrice;
//@property (nonatomic, assign) BOOL isOrderid;
- (void)cellWithtype:(NSString *)type;
- (void)dataWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
