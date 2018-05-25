//
//  KSNavigationController.h
//  WuWuMap
//
//  Created by mymac on 16/6/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <LHNavigationController/LHNavigationController.h>

typedef NS_ENUM(NSInteger,Navigationtype){
    
    /**
     *  导航控制器的默认风格
     */
    
    NavigationTypeDefault = 0,
    
    /**
     *  白色
     */
    NavigationTypeWhite
    
    
};
@interface ZWNavigationController : UINavigationController
@end
