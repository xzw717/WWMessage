//
//  StoreADCollectionViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/8/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^StoreADClickButtonBlock)(void);
@interface StoreADCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy  ) StoreADClickButtonBlock clickLeftButton;
@property (nonatomic, copy  ) StoreADClickButtonBlock clickRightButton;

@end

NS_ASSUME_NONNULL_END
