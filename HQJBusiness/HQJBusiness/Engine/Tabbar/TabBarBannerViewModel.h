//
//  TabBarBannerViewModel.h
//  WuWuMap
//
//  Created by mymac on 2017/1/18.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Preoperty.h"
@interface TabBarBannerViewModel : NSObject




/**
 banner 图

 @param pictureBlock <#pictureBlock description#>
 */
+(void)pictureRequst:(void(^)(id sender))pictureBlock ;



/**
 tabbar 图标

 @param tabbarBlock <#tabbarBlock description#>
 */
+(void)tabbarPictureRequst:(void(^)(id sender))tabbarBlock;
@end
