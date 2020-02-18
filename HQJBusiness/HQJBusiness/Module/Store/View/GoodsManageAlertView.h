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

#define AlertViewTitleColor @"AlertViewTitleColor"
#define AlertViewTitleFont  @"AlertViewTitleFont"
#define AlertViewTitle  @"AlertViewTitle"

@interface GoodsManageAlertView : UIView


/** 初始化配置方法  自定义提示标题，无内容 默认第一个按钮 “否”，不做任何操作 ，第二个 “是” ，回调是点击“是”后的 */
+ (void)alertViewInitWithTitle:(NSString *)title Complete:(GoodsManageAlertViewBlock)complete ;

/** 初始化配置方法 自定义内容，无标题 默认第一个按钮 “否”，不做任何操作 ，第二个 “是” ，回调是点击“是”后的 */
+ (void)alertViewInitWithContent:(NSString *)content Complete:(GoodsManageAlertViewBlock)complete;




/** 初始化配置方法 自定义提示标题居中显示，无内容   可自定义按钮title  第一个默认按钮只可自已定义文字，第二个可以自行定制，可传字典类型 eg：@{AlertViewTitleColor：红色} 回调是两个按钮点击后的回调   */
+ (void)alertViewInitWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable id)otherButtonTitles
                      Complete:(nullable GoodsManageAlertViewBlock)complete
                      negative:(nullable GoodsManageAlertViewBlock)negative;

/** 初始化配置方法 自定义内容居左显示，无标题  可自定义按钮title  第一个默认按钮只可自已定义文字，第二个可以自行定制，可传字典类型 eg：@{AlertViewTitleColor：红色} 回调是两个按钮点击后的回调   */
+ (void)alertViewInitWithContent:(nullable NSString *)content
               cancelButtonTitle:(nullable NSString *)cancelButtonTitle
               otherButtonTitles:(nullable id)otherButtonTitles
                        Complete:(nullable GoodsManageAlertViewBlock)complete
                        negative:(nullable GoodsManageAlertViewBlock)negative;

/** 初始化配置方法 标题居中显示，内容居左显示 都可自定义  可自定义按钮title  第一个默认按钮只可自已定义文字，第二个可以自行定制，可传字典类型 eg：@{AlertViewTitleColor：红色} 回调是两个按钮点击后的回调   */
+ (void)alertViewInitWithTitle:(nullable NSString *)title
                       content:(nullable NSString *)content
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable id)otherButtonTitles
                      Complete:(nullable GoodsManageAlertViewBlock)complete
                      negative:(nullable GoodsManageAlertViewBlock)negative;
@end

NS_ASSUME_NONNULL_END
