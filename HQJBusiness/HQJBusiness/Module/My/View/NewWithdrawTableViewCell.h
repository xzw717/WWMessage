//
//  NewWithdrawTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/6/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewWithdrawTableViewCell : ZW_TableViewCell
@property (nonatomic, strong) UITextField *subTitTextField;
- (void)setTitle:(NSString *)tit subTitle:(NSString *)subtit ;
@end

NS_ASSUME_NONNULL_END
