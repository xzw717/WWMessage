//
//  ToolCell.h
//  HQJBusiness
//
//  Created by 姚 on 2019/7/1.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZW_TableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
@interface ToolItemView : UIView
@end

@interface ToolCell : ZW_TableViewCell
@property (nonatomic, strong) NSMutableArray *itemAry;
@property (nonatomic, strong) void(^clickItemblock)(NSString *title);

@end

NS_ASSUME_NONNULL_END
