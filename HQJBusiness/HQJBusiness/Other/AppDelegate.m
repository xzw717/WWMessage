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
#import "JWBluetoothManage.h"
#import "VerificationOrderDetailsViewController.h"
#import "RemotePushOrderModel.h"
#import "ZGAudioManager.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "AddStaffViewController.h"

// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "RewardSetViewController.h"
#import "UMShareManager.h"


@interface AppDelegate ()<JPUSHRegisterDelegate>
@property (nonatomic, strong) RemotePushOrderModel *pushModel;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];

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
//
//    RewardSetViewController *loginVC =[[RewardSetViewController alloc]init];
//       ZWNavigationController *Nav= [[ZWNavigationController alloc]initWithRootViewController:loginVC];
//       AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//       delegate.window.rootViewController = Nav;
    if ( MmberidStr == nil) {
        //

        [self goLogin];

    } else {
        delegate.window.rootViewController = [ZWTabBarViewController  new];
//        delegate.window.rootViewController = [PushViewController  new];

    }
    [self initializeAutoValue];
    /* 极光 */
    [self jpushService:launchOptions];
    
    /* 友 盟 */
      [UMShareManager manager];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
        
      NSString *automaticallyPrintOrders = [userDefaults objectForKey:@"AutomaticallyPrintOrders"];
    if ([automaticallyPrintOrders isEqualToString:@"开"]) {
        [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  setObject:@"连接中" forKey:@"BluetoothState"];
          [[JWBluetoothManage sharedInstance] autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
              if (!error) {
                  //            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
                  //            weakSelf.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
                  [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"] setObject:@"绑定成功" forKey:@"BluetoothState"];
                  dispatch_async(dispatch_get_main_queue(), ^{
                      //                [self.tableView reloadData];
                  });
              }else{
                  [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"] setObject:@"绑定失败" forKey:@"BluetoothState"];
                  
              }
              
          } stateCompletion:^(CBManagerState status) {
              if (status == CBManagerStatePoweredOff) {
                  [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"] setObject:@"绑定失败" forKey:@"BluetoothState"];
                  
              }
          }];
    }
  

        return YES;
}




//- (void)confitUShareSettings
//{
//    [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];
//    [[UMSocialManager defaultManager] openLog:YES];//打开调试日志
//
//
//
//    [UMConfigure initWithAppkey:@"5f237473d30932215473a0ff" channel:@"App Store"];
//    /*
//     * 打开图片水印
//     */
//    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
//
//    /*
//     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
//     <key>NSAppTransportSecurity</key>
//     <dict>
//     <key>NSAllowsArbitraryLoads</key>
//     <true/>
//     </dict>
//     */
//    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
//        //配置微信平台的Universal Links
//    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
////    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/",
////                                                        @(UMSocialPlatformType_QQ):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/qq_conn/101830139"
////                                                        };
//
//
//}
//
//- (void)configUSharePlatforms
//{
//    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxbaea3263c2c6bbe6" appSecret:@"c11612aad04a5379cc2432448676c3cd" redirectURL:@""];
//
//
//
//
//
//
//}


//初始化播报开关常量
- (void)initializeAutoValue{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
    if (![userDefaults objectForKey:@"CollectMoney"]) {
        [userDefaults setObject:@"开" forKey:@"CollectMoney"];
        [userDefaults setObject:@"开" forKey:@"newOrder"];
    }
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
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
       if (!result) {
           // 其他如支付等SDK的回调
       
       }
    return YES;
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
 

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [[AppVersionManager sharedInstance] isUpdataApp];


}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
      
    NSString *automaticallyPrintOrders = [userDefaults objectForKey:@"AutomaticallyPrintOrders"];
    if ([automaticallyPrintOrders isEqualToString:@"开"]) {
        [[JWBluetoothManage sharedInstance] beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
            [[JWBluetoothManage sharedInstance]stopScanPeripheral];
        } failure:^(CBManagerState status) {
            if (status == CBManagerStatePoweredOff) {
                [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"] setObject:@"绑定失败" forKey:@"BluetoothState"];
                
            }
        }];
    }
    
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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    NSDictionary * userInfo = notification.request.content.userInfo;

    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 12.1) {
            [[ZGAudioManager sharedPlayer] playPushInfo:userInfo completed:nil];
        }
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];

    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    [[ZGAudioManager sharedPlayer] playPushInfo:userInfo completed:nil];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
