//
//  TabbarManager.m
//  WuWuMap
//
//  Created by mymac on 2017/1/16.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "TabbarManager.h"

#import <SDWebImage/UIImage+MultiFormat.h>
@implementation TabbarManager


//static NSString *const homeTabbarName = @"Home_tabbar";
//static NSString *const suyuanTabbarName = @"roots_tabbar";
//static NSString *const shangjiaTabbarName = @"Business_tabbar";
//static NSString *const myTabbarName = @"My_tabbar";
//static NSString *const homeTabbarNames = @"Home_tabbar_s";
//static NSString *const suyuanTabbarNames = @"roots_tabbar_s";
//static NSString *const shangjiaTabbarNames = @"Business_tabbar_s";
//static NSString *const myTabbarNames = @"My_tabbar_s";



static NSString *homeKeyStr;
static NSString *rootsKeyStr;
static NSString *BusinessKeyStr;
static NSString *myKeyStr;

static TabbarManager* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

- (void)setTabbar {
   
    
}


@end
