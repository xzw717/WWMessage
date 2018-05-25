//
//  OrderVerificationModel.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/14.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderVerificationModel.h"

@implementation OrderVerificationModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goodslist":[GoodsVerificationModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nid":@"id"};
    
}
@end
