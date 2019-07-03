//
//  ZGProgressHUD+NJ.m
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "ZGProgressHUD+NJ.h"

@implementation ZGProgressHUD (NJ)

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) {
        if ( [ManagerEngine currentViewControll].view) {
            view = [ManagerEngine currentViewControll].view;
        } else {
            view = [UIApplication sharedApplication].keyWindow;
        }
    }
  
    // 快速显示一个提示信息
    ZGProgressHUD *hud = [ZGProgressHUD showHUDAddedTo:view animated:YES];
    //设置成方形
    hud.square = YES;
    
    hud.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    // 快速显示一个提示信息
    hud.label.text = text;

    hud.bezelView.style = ZGProgressHUDBackgroundStyleSolidColor;
    
    //设置等待框背景色为黑色
    
    hud.bezelView.backgroundColor = [ManagerEngine getColor:@"464648"];
    
    hud.removeFromSuperViewOnHide = YES;
    
    //设置菊花框为白色
    
    [UIActivityIndicatorView appearanceWhenContainedIn:[ZGProgressHUD class], nil].color = [UIColor whiteColor];
   
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];

    // 再设置模式
    hud.mode = ZGProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    hud.animationType = ZGProgressHUDAnimationZoomIn;
     hud.label.textColor = [UIColor whiteColor];
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
    
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"pop_succeed" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"pop_failed" view:view];
}

/**
 *  显示信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个ZGProgressHUD，需要手动关闭
 */
+ (ZGProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个ZGProgressHUD，需要手动关闭
 */
+ (ZGProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil)  view = [ManagerEngine currentViewControll].view;
    // 快速显示一个提示信息
    ZGProgressHUD *hud = [ZGProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    return hud;
}



/**
 *  手动关闭ZGProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭ZGProgressHUD
 *
 *  @param view    显示ZGProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [ManagerEngine currentViewControll].view;
    [self hideHUDForView:view animated:YES];
}


@end
