//
//  GoodsManageModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/10.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsManageModel : NSObject
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSString *inventory;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, assign) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
