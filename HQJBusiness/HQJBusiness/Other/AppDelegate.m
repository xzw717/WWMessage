//
//  AppDelegate.m
//  HQJBusiness
//
//  Created by mymac on 2016/11/28.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "TabbarManager.h"
#import "ZWTabBarViewController.h"

#import "VerificationOrderDetailsViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window .backgroundColor = DefaultBackgroundColor;
    [self.window makeKeyAndVisible];
    IQKeyboardManager *manageriq = [IQKeyboardManager sharedManager];
    
    manageriq.enable = YES;
    manageriq.enableAutoToolbar = YES;
    manageriq.shouldResignOnTouchOutside = YES;
    
    manageriq.shouldToolbarUsesTextFieldTintColor = YES;
    
    [[AppVersionManager sharedInstance] isUpdataApp];
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ( MmberidStr == nil) {
        //
        
        [self goLogin];
        
    } else {
        delegate.window.rootViewController = [ZWTabBarViewController  new];

    }
    
//    [[TabbarManager shareInstance]setTabbar];
//    VerificationOrderDetailsViewController *vc = [[VerificationOrderDetailsViewController alloc]init];
//    [[UIApplication sharedApplication].delegate.window setRootViewController:vc];

        return YES;
}

- (void)goLogin {
    
    LoginViewController *loginVC =[[LoginViewController alloc]init];
    ZWNavigationController *Nav= [[ZWNavigationController alloc]initWithRootViewController:loginVC];
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = Nav;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusAuthorized)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShutDownCamera" object:nil];
    }
//
    
    
    
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSArray *UrlArray = [[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@":"];
    HQJLog(@"===url：%@",url);
    if (UrlArray && [UrlArray[0] isEqualToString:@"aliPayURL"]){
#pragma mark ------------支付宝---------------
        
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                if([resultDic[@"resultStatus"]integerValue] == 9000) {
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNoticationPayResults object:nil userInfo:@{@"strMsg":@"支付成功"}];
                } else {
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNoticationPayResults object:nil userInfo:@{@"strMsg":@"支付失败"}];

                }
                
                
            }];
        }

    
    
    }
    
    return YES;
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[AppVersionManager sharedInstance] isUpdataApp];


}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
