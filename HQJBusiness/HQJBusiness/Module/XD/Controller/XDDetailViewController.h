//
//  XDViewController.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"
#import "XDModel.h"
typedef enum : NSUInteger {
    XDIdentification = 0,
    XDDifferent,
    XDBenchmarking,
    XDBrother,
    XDEcology
} XDType;
NS_ASSUME_NONNULL_BEGIN

@interface XDDetailViewController : ZW_ViewController
//- (instancetype)initWithXDType:(XDType)xdType;
- (instancetype)initWithXDModel:(XDModel *)model;
@end

NS_ASSUME_NONNULL_END
