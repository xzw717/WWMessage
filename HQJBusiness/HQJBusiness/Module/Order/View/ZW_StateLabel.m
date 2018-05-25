//
//  ZW_StateLabel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_StateLabel.h"

@implementation ZW_StateLabel
-(instancetype)initWithStr:(NSString *)str addSubView:(UIView *)view {
    self = [super initWithStr:str addSubView:view];
    if (self) {
        
        self.layer.borderWidth = 0.5;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        self.font = [UIFont systemFontOfSize:10];
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    
    
    
    return self;
}
-(void)setText:(NSString *)text {
    [super setText:text];
//    self.text = text;

    if ([text isEqualToString:@"待使用"]) {
        self.layer.borderColor = [ManagerEngine getColor:@"f58700"].CGColor;
        self.textColor = [ManagerEngine getColor:@"f58700"];
    } else if([text isEqualToString:@"待评价"]) {
        
        self.layer.borderColor = [ManagerEngine getColor:@"1ab2ff"].CGColor;
        
        self.textColor = [ManagerEngine getColor:@"1ab2ff"];
        
    } else if([text isEqualToString:@"退款中"]) {
        
        self.layer.borderColor = [ManagerEngine getColor:@"ff5500"].CGColor;
        
        self.textColor = [ManagerEngine getColor:@"ff5500"];
        
    } else if([text isEqualToString:@"订单取消"]) {
        self.layer.borderColor = [ManagerEngine getColor:@"ff0000"].CGColor;
        
        self.textColor = [ManagerEngine getColor:@"ff0000"];
        
    } else {
        self.layer.borderColor = [ManagerEngine getColor:@"29cc29"].CGColor;
        
        self.textColor = [ManagerEngine getColor:@"29cc29"];
        
    }

}
@end
