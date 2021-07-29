//
//  MessageBasisVC.h
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageBasisVC : UIViewController

@property (nonatomic,strong) UIView *messageNavView;

@property (nonatomic,strong) UIButton *messageBackButton;

@property (nonatomic,strong) UILabel *messageTitLabel;


@property (nonatomic,copy)NSString *messageTitle;
/**
 导航及返回时的风格
 */
@property (nonatomic,assign) NavBackStyle backStyle;




/**
 所要 pop 控制器名称
 */
@property (nonatomic,copy)NSString *viewControllerName;





/**
 提示框的提示内容
 */
@property (nonatomic,strong) NSString *messageTitleStr;




/**
 右边第一个按钮
 */
@property (nonatomic,strong) UIButton *messageTightOneButton;


/**
 右边第二个按钮
 */
@property (nonatomic,strong) UIButton *zw_rightTwoButton;
/**
 底部线条
*/
@property (nonatomic, strong) UIView *bottomLineView;

/**
 直接 pop 到某个控制器
 */
-(void)popViews;



/// 设置导航栏背景色
- (void)setNavBackgroundColor:(UIColor *)color ;
- (void)setNavBackgroundColor:(UIColor *)color alpha:(CGFloat)apl;
@end

NS_ASSUME_NONNULL_END
