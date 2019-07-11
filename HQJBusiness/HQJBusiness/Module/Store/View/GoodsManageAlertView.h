//
//  GoodsManageAlertView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/11.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GoodsManageAlertViewBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface GoodsManageAlertView : UIView


/**
 初始化配置方法

 @param title 标题内容
 @param complete 点击 是 按钮 回调
 */
+ (void)alertViewInitWithTitle:(NSString *)title Complete:(GoodsManageAlertViewBlock)complete ;

/**
 初始化配置方法 可自定义按钮title

 @param title 标题内容
 @param fristBtn 第一个按钮的title
 @param twoBtn 第一个按钮的title
 @param complete  点击 是 按钮 回调
 */
+ (void)alertViewInitWithTitle:(NSString *)title
                 fristBtnTitle:(NSString *)fristBtn
                   twoBtnTitle:(NSString *)twoBtn
                      Complete:(GoodsManageAlertViewBlock)complete;
@end

NS_ASSUME_NONNULL_END
