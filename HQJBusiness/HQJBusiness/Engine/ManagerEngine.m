//
//  ManagerEngine.m
//  BeiBeiDemo
//
//  Created by mac on 16/2/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ManagerEngine.h"
#import "MyViewController.h"
#import "DetailViewController.h"
#import "CommodityViewController.h"
#import "OrderViewController.h"
#import "UINavigationBar+Awesome.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
static UILabel *alertLabel ;
@class HomeViewController;
@class NearViewController;
@class BusinessDeterminedViewController;
@class MyViewController;
@interface ManagerEngine ()
{
    BOOL isHaveDian;
    
}
@end


static UIActivityIndicatorView *activ;

static const CGFloat  sAlertTimer = 3.0;
@implementation ManagerEngine
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
   
    return self;
}

+ (ManagerEngine *)sharedManager {
    
    static dispatch_once_t predicate;
    static ManagerEngine *sharedManager;
    dispatch_once(&predicate, ^{
        sharedManager = [[ManagerEngine alloc]init];
    });
    return sharedManager;
    
}

+ (void)GoMainView {
    
    
#pragma mark -----我的
    
    
    
    MyViewController *MyVc = [[MyViewController alloc]init];//--个人信息
    
    UIImage *MyImage = [UIImage imageNamed:@"icon_mine_normal"];
    
    UIImage *MyImageS = [[UIImage imageNamed:@"icon_mine_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    MyVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:MyImage selectedImage:MyImageS];
    
    
    
    ZWNavigationController *MyNav = [[ZWNavigationController alloc]initWithRootViewController:MyVc];
    
    [MyNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    [[UITabBar appearance]setTintColor:[self getColor:@"18abf5"]];

    
    
#pragma mark -----明细
    
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    
    UIImage *mainImage = [UIImage imageNamed:@"icon_details_normal"];
    
    UIImage *mainImageS = [[UIImage imageNamed:@"icon_details_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    

    detailVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"明细" image:mainImage selectedImage:mainImageS];
    

    ZWNavigationController *detailNvc =[[ZWNavigationController alloc]initWithRootViewController:detailVc];
    
    [detailNvc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];



    
#pragma mark -----订单
    
    OrderViewController *orderVc = [[OrderViewController alloc]init];
    
    UIImage *DetailImage = [UIImage imageNamed:@"icon_order_normal"];
    
    UIImage *DetailImageS = [[UIImage imageNamed:@"icon_order_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    orderVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"订单" image:DetailImage selectedImage:DetailImageS];
    
    
      ZWNavigationController *orderNav = [[ZWNavigationController alloc]initWithRootViewController:orderVc];
    
    [orderNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];

#pragma mark -----商品
    
    CommodityViewController *commditVc = [[CommodityViewController alloc]init];
    
    UIImage *commditImage = [UIImage imageNamed:@"icon_commodity_normal"];
    
    UIImage *commditImageS = [[UIImage imageNamed:@"icon_commodity_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    commditVc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"商品" image:commditImage selectedImage:commditImageS];
    
    
    ZWNavigationController *commditNav = [[ZWNavigationController alloc]initWithRootViewController:commditVc];
    [commditNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
#pragma mark ----选择
    
    UITabBarController *tabbars = [[UITabBarController alloc]init];
    

    
    tabbars.viewControllers = @[MyNav,detailNvc,orderNav,commditNav];

    
    [[UIApplication sharedApplication].delegate.window setRootViewController:tabbars];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 420, 49)];
    
    backView.backgroundColor = [UIColor whiteColor];
    


    
    tabbars.tabBar.opaque = YES;

 
}

#pragma mark --
#pragma mark --- 获取当前视图控制器对象
+ (UIViewController *)currentViewControll{
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

#pragma mark-----16进制颜色值转换
+ (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    
    [[NSScanner localizedScannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    
    [[NSScanner localizedScannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];

     range.location = 4;
    
    [[NSScanner localizedScannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];

    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

#pragma mark --
#pragma mark ---颜色转图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}



#pragma mark --
#pragma mark ---提醒动画
+(void)homeSvpStr:(NSString *)tit andcenterView:(UIView *)view andStyle:(promptViewStyle)type {
    
        [self dismissHomeSvP];
    
    
    
        alertLabel = [[UILabel alloc]init];
        alertLabel.text = tit;
        alertLabel.font = [UIFont systemFontOfSize:12];
        alertLabel.numberOfLines = 0;
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.alpha = 0;
        [view addSubview:alertLabel];
    
        CGFloat  timers =  tit.length *0.15f ; // 延迟消失时间
        
    
  
    if (type == promptViewDefault) {
        

        
        alertLabel.alpha = 1;

        alertLabel.frame = CGRectMake(0, - NavigationControllerHeight, WIDTH,  NavigationControllerHeight);
        
        alertLabel.backgroundColor = [UIColor whiteColor];
        
        
        [UIView animateWithDuration:1 animations:^{
            
            alertLabel.frame = CGRectMake(0, 0, WIDTH,  NavigationControllerHeight );
            
        } completion:^(BOOL finished) {
 
            [UIView animateWithDuration:1 delay:timers options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        alertLabel.frame = CGRectMake(0, -  NavigationControllerHeight, WIDTH,  NavigationControllerHeight);
                        
                    } completion:^(BOOL finished) {
                        
                        [self dismissHomeSvP];
                    }];
            
                

                
            
        }];
    } else if (type == promptViewFadeAway){
        alertLabel.center = CGPointMake(view.center.x,HEIGHT/4*2 );
        alertLabel.bounds = CGRectMake(0, 0, tit.length*12.5+5*2, 30);
        alertLabel.layer.masksToBounds = YES;
        
        alertLabel.layer.cornerRadius = 3;
        
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.backgroundColor = [UIColor blackColor];
        
        alertLabel.textColor = [UIColor whiteColor];
        
        [UIView animateWithDuration:sAlertTimer animations:^{
            alertLabel.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            
            [UIView animateWithDuration:sAlertTimer animations:^{
                alertLabel.alpha = 0;

            } completion:^(BOOL finished) {
                [self dismissHomeSvP];
            }];
            
        }];
        
    } else {
        
        alertLabel = nil;
        
    }

    
    
}
+(void)dismissHomeSvP {
    
    [alertLabel removeFromSuperview];
    
    
}

#pragma mark -----网络状态
+(NSString *)networkStatus
{
     static NSString *typ;
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
      
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                typ =kUnknownNetwork;
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                typ =kNoInternet;

                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                typ =kWWANInternet;
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                typ =kWIFIInternet;
                break ;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:kNetworkStatus object:nil userInfo:@{@"IAmaNetwork":typ}];

    }];
    [mgr startMonitoring];
    return typ;
}

#pragma mark ---从状态栏获取当前网络状态
+(NSInteger)statusBarNetWork {
    
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    NSInteger type = 0;
    /**
     *  ：0 - 无网络; 1 - 2G; 2 - 3G; 3 - 4G; 5 - WIFI
     */
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSLog(@"----%ld",(long)type);
    
    return type;
    
}

#pragma mark ----时间戳
+ (NSDate *)getInternetDate
{
    
    NSString *urlString = @"http://m.baidu.com/";
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    // 实例化NSMutableURLRequest，并进行参数配置
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString: urlString]];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    [request setTimeoutInterval: 5];
    
    [request setHTTPShouldHandleCookies:FALSE];
    
    [request setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:request
     
                          returningResponse:&response error:&error];
    if (error) {
        return [NSDate date];
    }
    
    //    NSLog(@"response is %@",response);
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    //    NSLog(@"date is \n%@",date);
    
    date = [date substringFromIndex:5];
    
    date = [date substringToIndex:[date length]-4];
    
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    
    [dMatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//直接指定时区，这里是东8区
    
    
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    
    return netDate;
    
}



+ (void)navUnColorStyle:(UIViewController *)viewController {

    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [viewController.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//设置不同字体颜色
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSString *)rag AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    NSRange range = [label.text rangeOfString:rag];
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
}

+(CGFloat)setTextWidthStr:(NSString *)str andFont:(UIFont *)fonts {
    
     CGRect frame = [str boundingRectWithSize:CGSizeMake(1000, 1000)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: fonts} context:nil];
    
    
    return frame.size.width;
}
#pragma mark --
#pragma mark ---判断名称是否合法
+ (BOOL)isNameValid:(NSString *)name
{
    BOOL isValid = NO;
    
    if (name.length <=4&&name.length>1)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = NO;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = NO;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = NO;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = NO;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            
            if (!isValid)
            {
                break;
            }
        }
    }
    
    return isValid;
}

#pragma mark --
#pragma mark ---身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma mark --
#pragma mark ---判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (mobile.length != 11)
        
    {
        
        return NO;
        
    }else{
        
        /**
         
         * 移动号段正则表达式
         
         */
        
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(198)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        /**
         
         * 联通号段正则表达式
         
         */
        
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(166)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        /**
         
         * 电信号段正则表达式
         
         */
        
        NSString *CT_NUM = @"^((133)|(153)|(177)|(173)|(199)|(191)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return YES;
            
        }else{
            
            return NO;
            
        }
        
    }
    
}

#pragma mark --
#pragma mark ---判断邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(void)customAlert:(NSString *)str andViewController:(UIViewController *)selfController isBack:(BOOL)back {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    if (back) {
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeBonus" object:nil];
            [selfController.navigationController popViewControllerAnimated:YES];
        }]];
    } else {
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    }
   
    [selfController presentViewController:alert animated:YES completion:nil];
    
    
    
    
}
// 进入时改白色
+(void)navViewWillAppearColor:(UIViewController *)viewConoller  andConmp:(void(^)(id sender))send {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(0, 0, 22, 22);
    
    [backButton bk_addEventHandler:^(id  _Nonnull sender) {
        send(sender);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [backButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateNormal];
    
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    viewConoller.navigationItem.leftBarButtonItem = leftBar;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

    viewConoller.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}


// 改白色导航的标题
+(void)navTitle:(UIViewController *)viewConoller andTitle:(NSString *)title {
    

    UILabel *customeTitLabel      = [[UILabel alloc]init];
    
    customeTitLabel.textColor     = [UIColor blackColor];
    
    customeTitLabel.frame        = CGRectMake(0, 0, 20, 100);
    
    customeTitLabel.text          = title;
    
    customeTitLabel.font          = [UIFont systemFontOfSize:18.f];
    
    viewConoller.navigationItem.titleView = customeTitLabel;
}


+ (void)navColorStyle:(UIViewController *)viewController andColor:(UIColor *)color {
    
    [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [viewController.navigationController.navigationBar lt_reset];
    viewController.navigationController.navigationBar.barTintColor = color;
    
}

//退出时改红色
+(void)navViewWillDisappearColor:(UIViewController *)viewContoller {
    
    viewContoller.navigationController.navigationBar.barTintColor = [self getColor:@"18abf5"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    
}



+(void)SVPAfter:(NSString *)str complete:(void(^)(void))jump {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)([SVProgressHUD displayDurationForString:str]/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        jump();
    });
}



// 按钮小菊花--开始 (UIButton)
+(void)loadDateView:(UIButton *)view andPoint:(CGPoint)center {
    
    
    activ = [[UIActivityIndicatorView alloc]init];
    activ.color = [UIColor redColor];
    [view setTitle:@"" forState:UIControlStateNormal];
    view.enabled = NO;
    activ.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activ.center = center;
    [activ startAnimating];
    [view addSubview:activ];
}
// 按钮小菊花 --结束(UIButton)
+(void)dimssLoadView:(UIButton *)view andtitle:(NSString *)str {
    [activ stopAnimating];
    activ.hidesWhenStopped = YES;
    [view setTitle:str forState:UIControlStateNormal];
    view.enabled = YES;
}


#pragma mark --
#pragma mark --- 时间戳转时间
+(NSString *)reverseSwitchTimer:(NSString *)str {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str integerValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate: confromTimesp];
    return confromTimespStr;
}
#pragma mark --- 时间戳转时间
+(NSString *_Nonnull)zzReverseSwitchTimer:(NSString *_Nonnull)str{
    double time = [str doubleValue];
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    //将时间转换为字符串
    NSString *timeS = [formatter stringFromDate:myDate];
    return timeS;
}
+ (CIImage *)outputImageStr:(NSString *)str {
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    return  [filter outputImage];
    
}


#pragma mark --- 根据CIImage生成指定大小的UIImage
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone); CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark --- 截取指定小数点几位的字符串
+(NSString *_Nonnull)retainScale:(NSString *_Nonnull)number afterPoint:(int)position{
    
    NSString *result = [NSString stringWithFormat:@"%@",number];
    if ([result containsString:@"."]) {
        NSRange range = [result rangeOfString:@"."];
        NSString *sub = [result substringFromIndex:range.location + 1];
        if (sub.length<position) {
            for (int i = 0; i < position - sub.length ; i ++) {
                result  = [result stringByAppendingString:@"0"];
            }
        }else if (sub.length>position){
            result  = [result substringToIndex:range.location + position + 1];
        }
    }else{
        result = [result stringByAppendingString:@"."];
        for (int i = 0; i < position ; i ++) {
            result  = [result stringByAppendingString:@"0"];
        }
    }
    return result;
    
}


#pragma mark --- 是否需要添加hash校验
+ (BOOL)isHash:(NSString *_Nonnull)urlString parameters:(id _Nonnull)parameters{
    
    if ([urlString containsString:HQJBLoginCheckInterface] ||
        [urlString containsString:HQJBGetByMobileCodeInterface] ||
        [urlString containsString:HQJBGetShopUpgradeStateInterface] ||
         [urlString containsString:HQJBMerchantSmsLoginInterface]) {
        return NO;
    }else if([urlString containsString:HQJBGetPwdSMSInterface]||[urlString containsString:HQJBInputNewpwdActionInterface]){
        NSDictionary *dict = parameters;
        if ([dict[@"pwdtype"] isEqual:@1]) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
   
    
}
#pragma mark --- 获取hash
+ (NSString *_Nonnull)hashCodeStr {
    if (HashCode) {
        return HashCode;
    } else {
        [self login];
        return @"";
    }
}

+ (void)login {
    if (![NSStringFromClass([[ManagerEngine currentViewControll] class]) isEqualToString:@"LoginViewController"]&&
        ![NSStringFromClass([[ManagerEngine currentViewControll] class]) isEqualToString:@"ForgetPswViewController"]&&
        ![NSStringFromClass([[ManagerEngine currentViewControll] class]) isEqualToString:@"RegisterViewController"]) {
        LoginViewController *loginVC =[[LoginViewController alloc]init];
           ZWNavigationController *Nav= [[ZWNavigationController alloc]initWithRootViewController:loginVC];
           AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
           delegate.window.rootViewController = Nav;
    }
   
}

#pragma mark --
#pragma mark ---UITextFiled Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"textField.text:%@",textField.text);
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([textField.text containsString:@"."]) {
        isHaveDian = YES;

    }
    if ([string length]>0) {
        if ([textField.text length]>7) {
            [self showMessage:@"亲，输入超出限制了哟"];

//            [ManagerEngine homeSvpStr:@"亲，输入超出限制了哟" andcenterView:[ManagerEngine currentViewControll].view andStyle:promptViewDefault];
            
            return NO;
        }
        
        
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            
            
            if (single=='.') {
                if(! isHaveDian  ) { //text中还没有小数点
                    isHaveDian=YES;
                    return YES;
                } else {
                    [self showMessage:@"亲，您已经输入过小数点了"];

                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
            } else {
                if (isHaveDian) { //存在小数点
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    
                    NSInteger tt = range.location-ran.location;
                    
                    if (tt <= 2){
                        return YES;
                    } else {
                        [self showMessage:@"亲，您最多输入两位小数"];
                        return NO;
                    }
                } else {
                    return YES;
                    
                }
                
                
            }
        } else { //输入的数据格式不正确
            [self showMessage:@"亲，您输入的格式不正确"];
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
            
        }
        
    }
    
    else
    {
        return YES;
        
    }
    
}

- (void)showMessage:(NSString *)message {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert] ;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [[ManagerEngine currentViewControll] presentViewController:alert animated:YES completion:nil];
}

+ (BOOL)isIPhoneXSeries {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}


+ (PswType)pswType:(BOOL)isLoginPsw {
    PswType type ;
    switch ([isComplete integerValue]) {
        case 1: {
            if (isLoginPsw) {
                type = SetLoginPassWordType;
            } else {
                type = ChangeDealPassWordType;
                
            }
        }
            break;
        case 2: {
            if (isLoginPsw) {
                type = ChangeLoginPassWordType;
            } else {
                type = SetDealPassWordType;
                
            }
            
        }
            break;
        case 3: {
            if (isLoginPsw) {
                type = SetLoginPassWordType;
            } else {
                type = SetDealPassWordType;
                
            }
            
        }
            break;
        default:{
            if (isLoginPsw) {
                type = ChangeLoginPassWordType;
            } else {
                type = ChangeDealPassWordType;
                
            }
            
        }
            break;
    }
    return type;
}

+ (NSString *)pswTitleWithType:(PswType)type {
    switch (type) {
        case SetLoginPassWordType:
            return @"设置登录密码";
            break;
        case FindLoginPassWordType:
            return @"找回登录密码";
            break;
        case SetDealPassWordType:
            return @"设置交易密码";
            break;
        case ChangeLoginPassWordType:
            return @"修改登录密码";
            break;
        default:
            return @"修改交易密码";
            
            break;
    }
    return nil;
    
}
@end
