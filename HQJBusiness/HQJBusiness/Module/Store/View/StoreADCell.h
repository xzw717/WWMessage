//
//  StoreADCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/26.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreADCell : ZW_TableViewCell
@property (nonatomic, strong) void (^clickADButtonBlock)(NSString *btnTitle);
@end

NS_ASSUME_NONNULL_END
