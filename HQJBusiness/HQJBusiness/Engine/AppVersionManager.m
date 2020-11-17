//
//  AppVersionManager.m
//  WuWuMap
//
//  Created by mymac on 2017/5/11.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AppVersionManager.h"
@interface AppVersionManager ()

//https://itunes.apple.com/cn/app/%E7%89%A9%E7%89%A9%E5%9C%B0%E5%9B%BE/id1132505092?mt=8            物物地图商家版    kAPPType  1
//https://itunes.apple.com/cn/app/%E6%9C%8D%E5%8A%A1%E5%95%86/id1170386541?mt=8                     服务商     kAPPType  2
//https://itunes.apple.com/cn/app/%E5%90%88%E5%85%B6%E5%AE%B6%E5%95%86%E5%AE%B6/id1193866813?mt=8   商家       kAPPType  3

@property (nonatomic, strong) NSString *appId;

@end


static NSString *const kAppUrl = @"https://itunes.apple.com/cn/app/%E5%90%88%E5%85%B6%E5%AE%B6%E5%95%86%E5%AE%B6/id1193866813?mt=8";

static  NSInteger const kAPPType = 3;

@implementation AppVersionManager
+ (AppVersionManager *)sharedInstance {
    static AppVersionManager *appversion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appversion = [[AppVersionManager alloc]init];
    });
    return appversion;
}


- (NSString *)currentVersion {
    return [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
}

-(void)isUpdataApp {
    
    NSString *appURLStr = [NSString stringWithFormat:@"%@app/iosNewestVersion.action?type=%ld",HQJBUpdataAPPDomainName,(long)kAPPType];
    
    // 请求APP版本信息
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:appURLStr complete:^(NSDictionary *dic) {
        //最新版本号
        NSString *newVersion  =[dic[@"newestMsg"] stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        // 用户本地的版本
        NSString *oldVersion = [[self currentVersion] stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        if ([dic[@"resultCode"]integerValue] == 1002) {
            if ([newVersion integerValue] > [oldVersion integerValue]) {  // 非强制
                [self optionalUpgradeKey:dic[@"newestMsg"]];
                
            } else {
                HQJLog(@"恭喜你，你是最新版1");
                
            }
            
        } else {
            
            // 最新强制的版本
            NSString *newForcedToUpgradeVersion = [dic[@"forceMsg"] stringByReplacingOccurrencesOfString:@"." withString:@""];
            if ([newForcedToUpgradeVersion integerValue] > [oldVersion integerValue]) {
                
                //强制升级
                [self alertTitle:@"温馨提醒" content:@"为了不影响您的使用，请更新到最新版" theFirstButtonTitle:@"更新" theFirstButton:^{
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:kAppUrl]];
                    
                } theSecondButtonTitle:nil theSecondButton:nil];
                
            } else if ([newVersion integerValue] > [oldVersion integerValue]) {  // 非强制
                
                [self optionalUpgradeKey:dic[@"newestMsg"]];
                
            } else {
                HQJLog(@"恭喜你，你是最新版2");
                
            }
            
        }

    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
   
    
}
#pragma mark --
#pragma mark --- 获取当前视图控制器对象
- (UIViewController *)currentViewControll{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

#pragma mark --
#pragma mark ---
- (void)alertTitle:(NSString  *__nullable)title content:(NSString * __nonnull)content theFirstButtonTitle:(NSString * __nonnull)buttonTitle  theFirstButton:(void(^__nullable)(void))confirm  theSecondButtonTitle:(NSString * __nullable)buttonTitles theSecondButton:(void(^__nullable)())cancel {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !confirm ?:confirm();
        
    }]];
    if (buttonTitles != nil) {
        
        [alert addAction:[UIAlertAction actionWithTitle:buttonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !cancel ?:cancel();
            
        }]];
        
    }
    
    [[self currentViewControll] presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark --- 非强制升级
- (void)optionalUpgradeKey:(NSString *)str {
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:str]) {
        [self alertTitle:@"温馨提醒" content:@"有新版可以升级" theFirstButtonTitle:@"取消" theFirstButton:^{
            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:str];
        } theSecondButtonTitle:@"更新" theSecondButton:^{
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:kAppUrl]];
        }];
    }
}



@end
