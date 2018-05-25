//
//  UIButton+touch.h
//  HQJBusiness
//
//  Created by mymac on 2017/1/9.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKIt/UIKIt.h>
#define defaultInterval .5  //默认时间间隔

@interface UIButton (touch)
/**设置点击时间间隔*/

@property (nonatomic, assign) NSTimeInterval timeInterval;


/**
 *  用于设置单个按钮不需要被hook
 */
@property (nonatomic, assign) BOOL isIgnore;
@end
