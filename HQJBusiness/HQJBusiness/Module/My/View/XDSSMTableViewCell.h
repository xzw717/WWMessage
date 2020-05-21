//
//  XDSSMTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
typedef void (^ClickBlock)(void);
NS_ASSUME_NONNULL_BEGIN
@class XDSSMModel;
@interface XDSSMTableViewCell : ZW_TableViewCell
@property (nonatomic, strong) XDSSMModel *model;
@property (nonatomic, copy  ) ClickBlock payBlock;
@end

NS_ASSUME_NONNULL_END
