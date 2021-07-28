//
//  XDViewController.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"
#import "XDPayModel.h"
#import "PayEngine.h"
NS_ASSUME_NONNULL_BEGIN

@interface XDPayViewController : ZW_ViewController
@property (nonatomic, assign) buyType payType;

@property (nonatomic,strong)NSString *xdPayshopidString;
/// 纬度
@property (nonatomic, assign) CGFloat xdPaylatitude ;
/// 经度
@property (nonatomic, assign) CGFloat xdPaylongitude ;

@property (nonatomic, assign) NSInteger xdPayroleValue;
/// 是否是我的店铺界面支付
@property (nonatomic, assign) BOOL isMyShopPay;
- (instancetype)initWithXDPayModel:(XDPayModel *)model;
@end

NS_ASSUME_NONNULL_END
