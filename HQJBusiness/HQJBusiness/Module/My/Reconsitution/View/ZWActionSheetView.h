//
//  ZWActionSheetView.h
//  WuWuMap
//
//  Created by mymac on 2018/2/26.
//  Copyright © 2018年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickOptionsBlock)(NSString *optionsTitle,NSInteger index);
@interface ZWActionSheetView : UIView
/// 点击选项回调
@property (nonatomic, copy) ClickOptionsBlock optionBlock;
/**
 初始化方法

 @param title    选项卡的标题
 @param titleArray 选项内容数组
 @return 实例对象
 */
- (instancetype)initWithActionTitle:(NSString *)title action:(NSArray <NSString *>*)titleArray;

/**
 具有破坏性的选项

 @param destructiveTitle 具有破环性的选项内容 可以是取消按钮
 */
- (void)ActionStyleDestructive:(NSString *)destructiveTitle;

/**
 显示
 */
- (void)showActionSheet;

/**
 隐藏
 */
- (void)hiddenActionSheet;
@end
