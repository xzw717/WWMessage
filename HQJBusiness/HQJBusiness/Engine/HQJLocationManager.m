//
//  HQJLocationManager.m
//  HQJBusiness
//
//  Created by Ethan on 2020/8/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface HQJLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationmanager;//定位服务
@property (nonatomic, strong) NSString *currentCity;//当前城市
@property (nonatomic, strong) NSString *strlatitude;//经度
@property (nonatomic, strong) NSString *strlongitude;//纬度
@end
@implementation HQJLocationManager
+ (instancetype)shareInstance {
    static HQJLocationManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

- (instancetype)getLocation
{ //判断定位功能是否打开
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationmanager = [[CLLocationManager alloc]init];
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
           if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
               //由于IOS8中定位的授权机制改变 需要进行手动授权
               //获取授权认证
               [self.locationmanager requestWhenInUseAuthorization];
           }
        self.locationmanager.delegate = self;
        [self.locationmanager requestAlwaysAuthorization];
        self.currentCity = [NSString new];
//        [self.locationmanager requestWhenInUseAuthorization]; //设置寻址精度
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationmanager.distanceFilter = 5.0;
        [self.locationmanager startUpdatingLocation];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{ //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [[ManagerEngine currentViewControll] presentViewController:alert animated:YES completion:nil];
}

- (void)stopLocation {
    [self.locationmanager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationmanager stopUpdatingHeading]; //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init]; //打印当前的经度与纬度
//    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude); //反地理编码
    @weakify(self);
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        @strongify(self);
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality; if (!self.currentCity) {
                self.currentCity = @"无法定位当前城市";
            }
            !self.location ? :self.location(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,self.currentCity);
//            if (currentLocation.coordinate.latitude && currentLocation.coordinate.longitude && ![self.currentCity isEqualToString:@"无法定位当前城市"]) {
//                [self.locationmanager stopUpdatingLocation];
//            }
            //            NSLog(@"%@",self.currentCity);//当前的城市 // NSLog(@"%@",placeMark.subLocality);//当前的位置 // NSLog(@"%@",placeMark.thoroughfare);//当前街道 // NSLog(@"%@",placeMark.name);//具体地址
        }
    }];
    
}
@end
