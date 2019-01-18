//
//  CashOnlineCell.h
//  HQJBusiness
//
//  Created by mymac on 2017/9/11.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
@interface CashOnlineCell : UITableViewCell
@property (nonatomic, strong) DetailModel *cashModel;
@property (nonatomic, assign) BOOL isManualGift;

@end
