//
//  UIView+CornerRadiusView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/5.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UIView+CornerRadiusView.h"

@implementation UIView (CornerRadiusView)
- (void)cornerRadiusWithType:(UIRectCorner)type radiusCount:(CGFloat)count {
    //设置切哪个直角
    //    UIRectCornerTopLeft     = 1 << 0,  左上角
    //    UIRectCornerTopRight    = 1 << 1,  右上角
    //    UIRectCornerBottomLeft  = 1 << 2,  左下角
    //    UIRectCornerBottomRight = 1 << 3,  右下角
    //    UIRectCornerAllCorners  = ~0UL     全部角
    //得到view的遮罩路径
//    UIRectCorner corners;
//    if ([view isKindOfClass:[OrderDetailsHeaderView class]]) {
//        corners = UIRectCornerTopLeft | UIRectCornerTopRight;
//    } else {
//        corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
//
//    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners: type cornerRadii:CGSizeMake(count,count)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
