//
//  XDDetailModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/22.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDDetailModel : NSObject
//    "orderstate": 10,
//        "proname": "生态企业",
//        "paywayname": "支付宝",
//        "shopname": "",
//        "payway": 1,
//        "paytime": "2020-05-20 16:41:43",
//        "paymoney": 2886.45,
//        "orderremark": null,
//        "addtime": "2020-05-20 16:41:43",
//        "shopid": "1",
//        "orderstatename": "取消订单",
//        "proid": 5,
//        "orderid": "2222222222222222222",
//        "ordermoney": 2980.0
@property (nonatomic, strong) NSString *orderstate;
@property (nonatomic, strong) NSString *proname;
@property (nonatomic, strong) NSString *paywayname;
@property (nonatomic, strong) NSString *shopname;
@property (nonatomic, strong) NSString *payway;
@property (nonatomic, strong) NSString *paytime;
@property (nonatomic, strong) NSString *paymoney;
@property (nonatomic, strong) NSString *orderremark;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *shopid;
@property (nonatomic, strong) NSString *orderstatename;
@property (nonatomic, strong) NSString *proid;
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *ordermoney;
@end

NS_ASSUME_NONNULL_END
