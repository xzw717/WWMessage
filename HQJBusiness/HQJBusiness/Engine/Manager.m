//
//  Manager.m
//  HQJFacilitator
//
//  Created by mymac on 2016/10/18.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "Manager.h"

@implementation Manager
+(Manager *)sharedManager {
    
    static dispatch_once_t predicate;
    static Manager *sharedManager;
    dispatch_once(&predicate, ^{
        sharedManager = [[Manager alloc]init];
    });
    return sharedManager;
    
}
@end
