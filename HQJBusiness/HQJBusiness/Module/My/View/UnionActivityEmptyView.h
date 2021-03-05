//
//  ShowMobileView.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/23.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ SureButtonBlock) (void);
@interface UnionActivityEmptyView : UIView
@property (nonatomic, copy) SureButtonBlock sureButtonBlock;
@end

NS_ASSUME_NONNULL_END
