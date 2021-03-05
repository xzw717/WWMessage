//
//  AddUnionTextViewCell.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/3/4.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
#import "AddUnionModel.h"
#import "ContentTextView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^ TextFieldResult) (NSString *value);
@interface AddUnionTextViewCell : ZW_TableViewCell
@property (nonatomic, strong) ContentTextView *textView;
@property (nonatomic, copy) TextFieldResult textFieldResult;
@property (nonatomic, strong) AddUnionModel *model;
@property (nonatomic, strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
