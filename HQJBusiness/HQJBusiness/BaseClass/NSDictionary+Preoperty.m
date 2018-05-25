//
//  NSDictionary+Preoperty.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NSDictionary+Preoperty.h"

@implementation NSDictionary (Preoperty)

- (void)createPreopertyCode {
    
    NSMutableString *codes = [NSMutableString string];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {

        NSString *code ;
        
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,strong)NSString *%@;",key];

        }  else if ([value isKindOfClass:NSClassFromString(@" __NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,assign)BOOL %@;",key];
            
        }  else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,strong)NSArray *%@;",key];

        } else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,assign)NSInteger %@;",key];

        } else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic,strong)NSDictionary *%@;",key];

        }
        
        [codes appendFormat:@"\n\n%@\n",code];

        HQJLog(@"%@",codes);
    }];
    
    
    
    
}

@end
