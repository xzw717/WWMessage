//
//  ZW_TextField.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 输入框类型

 - isMobileType: 手机号
 - isPasswordType: 密码
 - isMoneyType: 金额
 */
typedef NS_ENUM(NSInteger,TextType) {
    
    
    isMobileType = 0,
    
    isPasswordType,
    
    isMoneyType
    
    
    
};

@interface ZW_TextField : UITextField
-(instancetype)initWithPlaceholder:(NSString *)str isType:(TextType)type addSubView:(UIView *)view ;


/**
 设置右边图片

 @param imageName 图片名
 */
-(void)setRightViewWithimageName:(NSString *)imageName;


-(void)setLeftViewWithimageName:(NSString *)imageName ;

-(void)isMaskBtn:(void(^)(void))senders ;

@end
