//
//  GoodsReleaseModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/15.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsReleaseModel.h"

@implementation GoodsReleaseModel
static GoodsReleaseModel* _instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)shareInstance {
    dispatch_once(&onceToken, ^{
        if(_instance == nil)
            _instance = [[super allocWithZone:NULL]init];
    });
    return _instance;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    return [GoodsReleaseModel shareInstance] ;
}

- (instancetype)copyWithZone:(struct _NSZone *)zone
{
    return [GoodsReleaseModel shareInstance] ;
}
+ (void)attempDealloc{
    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    _instance = nil;
}
@end
