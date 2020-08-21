//
//  XDPaySureViewController.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
#import "ZW_ViewController.h"
#import "XDPayModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XDPaySureViewController : ZW_ViewController
/// 支付宝支付状态
@property (nonatomic, assign) BOOL isAlipaySuccess;
- (instancetype)initWithOrderid:(NSString *)orderid;

@end

NS_ASSUME_NONNULL_END
