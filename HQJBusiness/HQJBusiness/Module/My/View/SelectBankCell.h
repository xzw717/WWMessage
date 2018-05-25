//
//  SelectBankCell.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
#import "SelectBankModel.h"

@interface SelectBankCell : ZW_TableViewCell
@property (nonatomic,strong)SelectBankModel *model;
@property (nonatomic, strong) UIView *lineView;
@end
