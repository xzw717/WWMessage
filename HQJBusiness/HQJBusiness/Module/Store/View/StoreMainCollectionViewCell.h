//
//  StoreMainCollectionViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/8/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreModel;
@class MyModel;
NS_ASSUME_NONNULL_BEGIN

@interface StoreMainCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *storeTitleStr;
@property (nonatomic, strong)  StoreModel *model;
@property (nonatomic, strong)  MyModel *mmodel;

@end

NS_ASSUME_NONNULL_END
