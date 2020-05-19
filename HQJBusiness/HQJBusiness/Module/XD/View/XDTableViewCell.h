//
//  XDTableViewCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
@class XDModel;
NS_ASSUME_NONNULL_BEGIN

@interface XDTableViewCell : ZW_TableViewCell
@property (nonatomic, strong) XDModel *model;
@end

NS_ASSUME_NONNULL_END
