//
//  StoreCollectionReusableView.h
//  HQJBusiness
//
//  Created by mymac on 2019/8/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickRightBtn)(void);
@interface StoreCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) NSArray <NSString *>*itemAry;
@property (nonatomic, copy  ) clickRightBtn clickBtn;
@end

NS_ASSUME_NONNULL_END
