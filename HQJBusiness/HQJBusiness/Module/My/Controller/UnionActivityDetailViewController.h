//
//  UnionActivityViewController.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/26.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDBaseViewController.h"
#import "UnionActivityListModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface UnionActivityDetailViewController : ZW_ViewController
- (instancetype)initWithModel:(UnionActivityListModel *)model;
@end

NS_ASSUME_NONNULL_END
