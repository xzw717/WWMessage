//
//  UIView+RoundedCorners.m
//  WuWuMap
//
//  Created by mymac on 2019/8/1.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UIView+RoundedCorners.h"

@implementation UIView (RoundedCorners)

- (void)hqj_roundedCornersWithAllRoundedCornerRadii:(CGFloat)cornerRadii {
    [self hqj_roundedCornersWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii];

}

- (void)hqj_roundedCornersWithAllRoundedRect:(CGRect)rect cornerRadii:(CGFloat)cornerRadii {
    [self hqj_roundedCornersWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii];
}

- (void)hqj_roundedCornersWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii {
    [self hqj_roundedCornersWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii lineWidth:0.5 lineColor:[UIColor clearColor]];
}

- (void)hqj_roundedCornersWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
//    maskLayer.strokeColor =  lineColor.CGColor;
//    maskLayer.fillColor = [UIColor clearColor].CGColor;
//    maskLayer.strokeColor = [UIColor blackColor].CGColor;
//    maskLayer.lineWidth = lineWidth;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = lineWidth;
    pathLayer.strokeColor = lineColor.CGColor;
    pathLayer.path = maskPath.CGPath;
    pathLayer.fillColor = nil; // 默认为blackColor
    [self.layer addSublayer:pathLayer];
//    self.layer.borderWidth = lineWidth;
//    self.layer.borderColor = [UIColor blackColor].CGColor;

}


    
@end
