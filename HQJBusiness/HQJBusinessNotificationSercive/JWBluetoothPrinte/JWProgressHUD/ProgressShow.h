//
//  ProgressShow.h
//  JWBluetoothPrinte
//
//  Created by 张竟巍 on 2017/6/14.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef void (^ALertCompletion)(BOOL compliont);
typedef void (^AfterCompletion)(void);

@interface ProgressShow : NSObject


+(void)alertView:(UIView *)view Message:(NSString*)msg cb:(ALertCompletion) completion;

+ (NSString *)getBluetoothErrorInfo:(CBManagerState)status;
+(void)alertView:(UIView *)view Message:(NSString*)msg asy:(AfterCompletion)completion;

@end
