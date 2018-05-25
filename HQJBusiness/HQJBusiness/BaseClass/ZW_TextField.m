//
//  ZW_TextField.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TextField.h"
@interface ZW_TextField ()
@end
@implementation ZW_TextField

-(instancetype)initWithPlaceholder:(NSString *)str isType:(TextType)type addSubView:(UIView *)view {
    self = [super init];
    if (self) {
        if (type == isMobileType) {
            self.keyboardType = UIKeyboardTypeNumberPad;

        } else if (type == isMoneyType) {
            self.keyboardType = UIKeyboardTypeDecimalPad;

        } else {
            self.secureTextEntry = YES;

            self.keyboardType = UIKeyboardTypeNumberPad;

        }
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.placeholder = str;
        self.font = [UIFont systemFontOfSize:15.0];
        self.clearButtonMode = UITextFieldViewModeAlways;
        [view addSubview:self];
    }
    return self;
}


-(void)setRightViewWithimageName:(NSString *)imageName {
    
    UIImageView *rightView = [[UIImageView alloc]init];
    rightView.image = [UIImage imageNamed:imageName];
    rightView.size_sd = CGSizeMake(40, 40);
    rightView.contentMode = UIViewContentModeCenter;
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
}

-(void)setLeftViewWithimageName:(NSString *)imageName {
    
    UIView *leftview = [[UIView alloc]init];
    leftview.size_sd = CGSizeMake(40, 40);

    
    UIImageView *leftimageView = [[UIImageView alloc]init];
    
    [leftimageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    
    leftimageView.center = leftview.center;
    
    leftimageView.bounds = CGRectMake(0, 0, 18, 18);
    
    leftimageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [leftview addSubview:leftimageView];
    
    self.leftView = leftview;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)isMaskBtn:(void(^)())senders {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn bk_addEventHandler:^(id  _Nonnull sender) {
        senders();

        
    } forControlEvents:UIControlEventTouchUpInside];
    btn.frame =self.bounds;
    [self addSubview:btn];
}



@end
