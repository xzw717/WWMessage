//
//  OrderVerificationModel.h
//  HQJBusiness
//
//  Created by mymac on 2017/9/14.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsVerificationModel.h"


@interface OrderVerificationModel : NSObject
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray <GoodsVerificationModel *>*goodslist;

@end







