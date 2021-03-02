//
//  AddUnionActivityCell.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/2.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUnionModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^ TextFieldResult) (NSString *value);
@interface AddUnionActivityCell : ZW_TableViewCell
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) TextFieldResult textFieldResult;
@property (nonatomic, strong) AddUnionModel *model;
@property (nonatomic, strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
