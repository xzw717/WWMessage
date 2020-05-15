//
//  ZW_ViewController.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZW_BaseViewController.h"

/**
 返回按钮类型

 - BackOnAnInterfaceStyle: 返回上一个界面（默认）
 - AlertViewBackStyle: 带有提示框的返回
 - SpecifyTheInterfaceStyle: 返回到指定界面
 */
typedef NS_ENUM(NSInteger,NavBackStyle) {
    
    BackOnAnInterfaceStyle = 0,
    
    AlertViewBackStyle,
    
    SpecifyTheInterfaceStyle
  
    
};
typedef NS_ENUM(NSInteger, PswType) {
    /// 设置登录密码
    SetLoginPassWordType = 0,
    
    /// 找回 登录密码
    FindLoginPassWordType,
    
    /// 设置（找回）交易密码
    SetDealPassWordType,
    
    /// 修改 登录密码
    ChangeLoginPassWordType,
     
    /// 修改（重置）交易密码
    ChangeDealPassWordType
};

@interface ZW_ViewController : ZW_BaseViewController

@property (nonatomic,strong) UIView *zwNavView;

@property (nonatomic,strong) UIButton *zwBackButton;

@property (nonatomic,strong) UILabel *zwTitLabel;


@property (nonatomic,copy)NSString *zw_title;
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
@property (nonatomic,strong) NSString *ZWtitleStr;




/**
 右边第一个按钮
 */
@property (nonatomic,strong) UIButton *ZWrightOneButton;


/**
 右边第二个按钮
 */
@property (nonatomic,strong) UIButton *ZWrightTwoButton;



/**
 直接 pop 到某个控制器
 */
-(void)popViews;



@end
