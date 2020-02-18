//
//  TabBarSingle.h
//  WuWuMap
//
//  Created by mymac on 2017/11/16.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const ZWTabBarItemiconArrayKey;
FOUNDATION_EXTERN NSString *const ZWTabBarItemSelectIconArrayIconKey;
FOUNDATION_EXTERN NSString *const ZWTabBarItemvoiceButtonUrlKey;
FOUNDATION_EXTERN NSString *const ZWTabBarItemshopCartUrlKey;
FOUNDATION_EXTERN NSString *const ZWTabBarItembarBgUrlKey;
FOUNDATION_EXTERN NSString *const ZWTabBarItemTitle;
FOUNDATION_EXTERN NSString *const ZWTabBarItemImage;
FOUNDATION_EXTERN NSString *const ZWTabBarItemSelectedImage;
@interface TabBarSingle : NSObject
@property (nonatomic, strong) NSMutableArray  *iconArray;
@property (nonatomic, strong) NSMutableArray  *selectedIconArray;
@property (nonatomic, strong) NSString        *voiceButtonUrl;
@property (nonatomic, strong) NSString        *shopCartUrl;
@property (nonatomic, strong) NSString        *barBgUrl;
@property (nonatomic, strong) NSMutableDictionary *dataDict;

+(instancetype)shareManager;
- (UIImage *)zw_setKeyValues:(NSString *)keyValue;
@end
