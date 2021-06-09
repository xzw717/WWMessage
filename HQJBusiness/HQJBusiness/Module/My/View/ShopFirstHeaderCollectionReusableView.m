//
//  ShopFirstHeaderCollectionReusableView.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/4.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopFirstHeaderCollectionReusableView.h"
#import "UIView+RoundedCorners.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
@interface ShopFirstHeaderCollectionReusableView ()<SDCycleScrollViewDelegate>
@end
@implementation ShopFirstHeaderCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bannerBgView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, WIDTH - 30, (WIDTH - 30) / 2 )];
        bannerBgView.backgroundColor = [UIColor greenColor];
        bannerBgView.layer.masksToBounds = YES;
        bannerBgView.layer.cornerRadius = 10.f;
        [self addSubview:bannerBgView];
        self.shopBannerView = [SDCycleScrollView cycleScrollViewWithFrame:bannerBgView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        self.shopBannerView.backgroundColor = DefaultBackgroundColor;
        self.shopBannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        self.shopBannerView.currentPageDotColor = [UIColor whiteColor];
        self.shopBannerView.pageDotColor = [UIColor grayColor];
        [bannerBgView addSubview:self.shopBannerView];
  
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, self.mj_h - 20, self.mj_w, 20)];
        bgView.backgroundColor = [UIColor whiteColor];
        [bgView hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,  WIDTH - 15 * 2, 20) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:10.f];
        [self addSubview:bgView];
        
    }
    return self;
}
@end
