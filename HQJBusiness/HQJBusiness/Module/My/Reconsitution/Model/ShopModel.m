//
//  ShopModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/3/10.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"registerState":@"register"};
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
//        _name = [coder decodeObjectForKey:@"name"];
//        _age = [coder decodeObjectForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{

//    [coder encodeObject:self.name forKey:@"name"];
//    [coder encodeObject:self.age forKey:@"age"];

}
@end
