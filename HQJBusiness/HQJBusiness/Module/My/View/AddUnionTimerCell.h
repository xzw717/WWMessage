//
//  AddUnionTimerCell.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
#import "AddUnionModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^ TimerResult) (NSString *value);
@interface AddUnionTimerCell : ZW_TableViewCell
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) TimerResult timerResult;
@property (nonatomic, strong) AddUnionModel *model;
@property (nonatomic, strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
