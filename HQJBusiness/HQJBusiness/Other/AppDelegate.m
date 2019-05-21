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

#import "ZGAudioManager.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>
@end

@implementation AppDelegate
//5.13
//【商家APP】新增银行卡，银行卡号位数限制由16-19位变更为12-30位
//5.14
//1.修改服务商设置-系统通知页面
//2.修改服务商设置-帮助和反馈页面

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SVProgressHUD setMinimumDismissTimeInterval:2.f];
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
    
    
    /* 极光 */
    [self jpushService:launchOptions];
    
    
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
//    [JPUSHService setupWithOption:launchOptions appKey:appKey
//                          channel:channel
//                 apsForProduction:isProduction
//            advertisingIdentifier:advertisingId];
//    [[TabbarManager shareInstance]setTabbar];
//    VerificationOrderDetailsViewController *vc = [[VerificationOrderDetailsViewController alloc]init];
//    [[UIApplication sharedApplication].delegate.window setRootViewController:vc];

        return YES;
}
#pragma mark --- 极光推送
- (void)jpushService:(NSDictionary *)launchOptions {
    /// 初始化APNs
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc]init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge |JPAuthorizationOptionSound;
    //可以添加自定义categories
    [JPUSHService registerForRemoteNotificationTypes:( UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert) categories:nil];
    
    
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"13c8038285777340293529d0"
                          channel:nil
                 apsForProduction:0
            advertisingIdentifier:nil];
    NSLog(@"MmberidStr = %@",MmberidStr);
    
    [JPUSHService setAlias:MmberidStr completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

    } seq:1];
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
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        [[ZGAudioManager sharedPlayer] playPushInfo:userInfo completed:nil] ;
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
