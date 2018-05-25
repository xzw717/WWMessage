//
//  PaymentCodeTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2017/9/27.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <SWTableViewCell/SWTableViewCell.h>
#import "ZW_TableViewCell.h"
#import "PaymentCodeModel.h"
typedef void (^addCodeBlcok)(NSString *str);
@interface PaymentCodeTableViewCell : SWTableViewCell
@property (nonatomic, copy) addCodeBlcok typeBlcok;

- (void)setTitleModel:(PaymentCodeModel *)model;

- (void)setPaymentCodeType:(NSString *)type;


@end
