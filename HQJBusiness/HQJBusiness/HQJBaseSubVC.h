//
//  HQJBaseSubVC.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 导航控制器颜色风格
 */
typedef NS_ENUM(NSInteger,HQJNavigationBarColor) {
  
    ///  - HQJNavigationBarWhite: 白色
    HQJNavigationBarWhite = 1,
    
    ///  - HQJNavigationBarBlue: 蓝色
    HQJNavigationBarBlue
};
@interface HQJBaseSubVC : UIViewController

@property (nonatomic, strong) NSString *viewControllerName;

/// 导航控制器颜色风格    在 viewWillAppear 中调用
@property (nonatomic, assign) HQJNavigationBarColor navType;
@end

NS_ASSUME_NONNULL_END
