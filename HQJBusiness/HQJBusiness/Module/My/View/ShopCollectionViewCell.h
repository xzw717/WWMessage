//
//  ShopCollectionViewCell.h
//  HQJBusiness
//
//  Created by Ethan on 2021/6/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopModel;
NS_ASSUME_NONNULL_BEGIN

@interface ShopCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) ShopModel *sp_model;
@end

NS_ASSUME_NONNULL_END
