//
//  LoginSingleton.h
//  HQJBusiness
//
//  Created by mymac on 2017/5/15.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginSingleton : NSObject




+ (instancetype)loginsharedInstance;



/**
 登陆次数
 */
@property (nonatomic, assign ) NSInteger  FirstLogin;

@end
