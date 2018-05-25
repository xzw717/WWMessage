//
//  NameSingle.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NameSingle.h"

@implementation NameSingle

static NameSingle *_instance = nil;
+(instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
    });
    return _instance;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    return [NameSingle shareInstance];
}

-(id)copyWithZone:(struct _NSZone *)zone {
    return [NameSingle shareInstance];
}

@end
