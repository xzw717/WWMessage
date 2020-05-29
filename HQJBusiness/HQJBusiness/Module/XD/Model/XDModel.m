//
//  XDModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDModel.h"

@implementation XDModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[XDSubModel class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nid":@"id"};
}
@end
