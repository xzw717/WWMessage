//
//  GoodsReleaseVC.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/11.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJBaseSubVC.h"
#import "GoodsReleaseViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsReleaseVC : HQJBaseSubVC
- (instancetype)initWithNavType:(HQJNavigationBarColor)type buttonStyle:(ReleaseButtonStyle)style controllerTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
