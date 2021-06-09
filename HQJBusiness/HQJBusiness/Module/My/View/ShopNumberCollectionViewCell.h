//
//  ShopNumberCollectionViewCell.h
//  HQJBusiness
//
//  Created by Ethan on 2021/6/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//
///    店铺 第一个区的cell  当日积分  当日现金 RY余额
#import <UIKit/UIKit.h>
@class  ShopModel;
NS_ASSUME_NONNULL_BEGIN

@interface ShopNumberCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) ShopModel *spn_model;
@end

NS_ASSUME_NONNULL_END
