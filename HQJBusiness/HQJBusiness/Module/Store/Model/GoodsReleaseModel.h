//
//  GoodsReleaseModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/15.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsReleaseModel : NSObject
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *classification;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *discountPrice;
@property (nonatomic, strong) NSString *inventory;
@property (nonatomic, strong) NSString *introduce;
+ (instancetype)shareInstance;
+ (void)attempDealloc;
@end

NS_ASSUME_NONNULL_END
