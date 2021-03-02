//
//  AddUnionSectionView.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/5.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ AddButtonBlock) (void);
@interface AddUnionSectionView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) AddButtonBlock addButtonBlock;
@end

NS_ASSUME_NONNULL_END
