//
//  AppVersionManager.h
//  WuWuMap
//
//  Created by mymac on 2017/5/11.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppVersionManager : NSObject


+ (AppVersionManager *)sharedInstance;


/**
 获取当前版本

 @return 当前版本
 */
- (NSString *)currentVersion;



/**
 更新版本

 */
-(void)isUpdataApp;

@end
