//
//  MessageModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/3/2.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"messageid":@"id"};
}
@end
