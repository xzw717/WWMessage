//
//  SetCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/5/20.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetCell : UITableViewCell
@property (nonatomic, strong) UISwitch * setSwitch;
@property (nonatomic, strong) void(^clickSwitchBlock)(BOOL switchBlock);
@end

NS_ASSUME_NONNULL_END
