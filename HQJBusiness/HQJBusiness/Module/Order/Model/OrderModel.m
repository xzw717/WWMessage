//
//  OrderModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodslist":[GoodsModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nid":@"id"};
}

@end
