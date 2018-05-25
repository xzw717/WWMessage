//
//  ZW_Label.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_Label.h"

@implementation ZW_Label

-(instancetype)initWithStr:(NSString *)str addSubView:(UIView *)view {
    self = [super init];
    if (self) {
        
        self.text = str;
        self.font = [UIFont systemFontOfSize:17.0];
        self.textColor = [UIColor blackColor];
        [view addSubview:self];
        
        
    }
    return self;
    
}

@end
