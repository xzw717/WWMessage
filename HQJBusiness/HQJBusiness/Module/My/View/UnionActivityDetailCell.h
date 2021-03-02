//
//  UnionActivityDetailCell.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/3/1.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUnionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UnionActivityDetailCell : ZW_TableViewCell
@property (nonatomic, strong) AddUnionModel *model;
@property (nonatomic, strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
