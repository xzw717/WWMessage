//
//  ChildNav.h
//  WuWuMap
//
//  Created by mymac on 2017/2/27.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonItem.h"
@interface ChildNav : UIView

/// 返回箭头的按钮
@property (nonatomic,strong) UIButton * backButton;

/// 标题
@property (nonatomic,strong) UILabel  * titleLabel;

/// 右边第一个按钮
@property (nonatomic,strong) UIButton * rightToolButton;

/// 右边第二个按钮
@property (nonatomic,strong) UIButton * rightToolsButton;

/// 底部线条
@property (nonatomic,strong) UIView   * childNavLineView;

/// 加载进度
@property (nonatomic, assign) CGFloat     webProgress;

/// 透明度
@property (nonatomic, assign) CGFloat  clarity;
@end
