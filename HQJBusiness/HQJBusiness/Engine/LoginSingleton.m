//
//  LoginSingleton.m
//  HQJBusiness
//
//  Created by mymac on 2017/5/15.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "LoginSingleton.h"

@implementation LoginSingleton
static LoginSingleton *_login = nil;

+ (instancetype)loginsharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _login.FirstLogin = 0;
        _login = [[LoginSingleton alloc]init];
        
    });
    
    return _login;
    
}




@end
