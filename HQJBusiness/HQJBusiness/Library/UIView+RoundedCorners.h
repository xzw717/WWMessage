//
//  UIView+RoundedCorners.h
//  WuWuMap
//
//  Created by mymac on 2019/8/1.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RoundedCorners)

- (void)hqj_roundedCornersWithAllRoundedCornerRadii:(CGFloat)cornerRadii;

- (void)hqj_roundedCornersWithAllRoundedRect:(CGRect)rect cornerRadii:(CGFloat)cornerRadii;

- (void)hqj_roundedCornersWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii;

/**
 圆角方法
 */
- (void)hqj_roundedCornersWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor ;

@end

NS_ASSUME_NONNULL_END
