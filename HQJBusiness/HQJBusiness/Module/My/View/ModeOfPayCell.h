//
//  ModeOfPayCell.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DealTableViewCell.h"

@interface ModeOfPayCell : DealTableViewCell
@property (nonatomic,assign) BOOL isArrearage;
@property (nonatomic,copy) NSString *payModeStr;
@end
