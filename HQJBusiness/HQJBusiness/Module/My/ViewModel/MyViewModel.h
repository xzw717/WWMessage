//
//  MyViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyViewModel : NSObject

@property (nonatomic,copy)void(^myrequstBlock)(id sender);
@property (nonatomic,copy)void(^myrequstErrorBlock)(void);
@property (nonatomic,strong)NSArray *titleImageViewArray;
@property (nonatomic,strong)NSArray *titleLabelArray;
@property (nonatomic,strong)NSArray *xdTitleImageViewArray;
-(void)myRequst;

-(void)jumpVc:(UIViewController *)xzw_self andIndexPath:(NSIndexPath *)xzw_indexPath;

+(void)getHomeBannerBlock:(void(^)(id imageArray))sender;

/// 通过 memberid h获取对应商家的shopid
- (void)getshopidWithMemberid:(NSString *)memberid completion:(void(^)(NSString *shopid))completion;

/// XD 商家审核状态
+ (void)getXdShopAuditWithCompletion:(void(^)(NSDictionary *dict))completion;

/// 许峰的 神奇接口 只有一个返回参数  商家宗奖励积分
+ (void)getMerchantTotalAward:(void(^)(NSString *award))completion;
///  是否可以使用预约积分
+ (void)getUseBookingInfo;

/// 补签合同基础信息弹窗
- (void)jumpAlert ;

@end
