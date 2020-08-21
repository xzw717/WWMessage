//
//  MyTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface MyTableViewCell : ZW_TableViewCell
@property (nonatomic,strong)MyModel *model;
@property (nonatomic, strong) NSString *cellReward;
@end
