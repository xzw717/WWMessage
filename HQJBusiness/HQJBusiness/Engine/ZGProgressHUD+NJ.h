//
//  MBProgressHUD+NJ.h
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "ZGProgressHUD.h"

@interface ZGProgressHUD (NJ)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (ZGProgressHUD *)showMessage:(NSString *)message;
+ (ZGProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

@end
