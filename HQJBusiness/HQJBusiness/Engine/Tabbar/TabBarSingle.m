//
//  TabBarSingle.m
//  WuWuMap
//
//  Created by mymac on 2017/11/16.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "TabBarSingle.h"
NSString *const ZWTabBarItemiconArrayKey           = @"ZWTabBarItemiconArrayKey";
NSString *const ZWTabBarItemSelectIconArrayIconKey = @"ZWTabBarItemSelectIconArrayIconKey";
NSString *const ZWTabBarItemvoiceButtonUrlKey      = @"ZWTabBarItemvoiceButtonUrlKey";
NSString *const ZWTabBarItemshopCartUrlKey         = @"ZWTabBarItemshopCartUrlKey";
NSString *const ZWTabBarItembarBgUrlKey            = @"ZWTabBarItembarBgUrlKey";
NSString *const ZWTabBarItemTitle = @"ZWTabBarItemTitle";
NSString *const ZWTabBarItemImage = @"ZWTabBarItemImage";
NSString *const ZWTabBarItemSelectedImage = @"ZWTabBarItemSelectedImage";



@implementation TabBarSingle
+(instancetype)shareManager{
    static TabBarSingle * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[TabBarSingle alloc]init];
    });
    
    return _manager;
}


- (UIImage *)zw_setKeyValues:(NSString *)keyValue {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ImageTest_URL,keyValue];
    NSError *error;
    
      NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:nil error:&error];
    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data];
    return image ? image : [[UIImage alloc]init];
}

- (NSArray <NSDictionary *>*)aaa:(NSArray *)iconAry selectIconAry:(NSArray *)selectAry {
    NSMutableArray *dicAry = [NSMutableArray array];
    for (NSInteger i = 0; i < iconAry.count; i ++) {
        NSDictionary *TabBarItemsAttributes = @{
                                                ZWTabBarItemTitle : [self titleAry][i],
                                                ZWTabBarItemImage : [self tabbarImage:iconAry[i]],
                                                ZWTabBarItemSelectedImage : [self tabbarImage:selectAry[i]],
                                                };
        [dicAry addObject:TabBarItemsAttributes];
    }
    return dicAry;
    
}
- (NSArray *)titleAry {
    return @[@"店铺",@"消息",@"头条",@"工具",@"我的"];
}
- (UIImage *)tabbarImage:(NSString *)str {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ImageTest_URL,str];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
