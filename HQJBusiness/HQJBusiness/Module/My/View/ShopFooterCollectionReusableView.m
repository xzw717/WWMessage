//
//  ShopFooterCollectionReusableView.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/4.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopFooterCollectionReusableView.h"
#import "UIView+RoundedCorners.h"



@implementation ShopFooterCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, self.mj_w, self.mj_h - 20)];
        bgView.backgroundColor = [UIColor whiteColor];
        [bgView hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,  WIDTH - 15 * 2, self.mj_h-20) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:10.f];
        [self addSubview:bgView];
        
    }
    return self;
}
@end
