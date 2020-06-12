//
//  XDPayModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDPayModel : NSObject
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *payway;
@property (nonatomic, strong) NSString *ordermoney;
@property (nonatomic, strong) NSString *paytime;
@property (nonatomic, strong) NSString *orderstate;
@property (nonatomic, strong) NSString *paymoney;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *proid;
@property (nonatomic, strong) NSString *shopid;
@property (nonatomic, strong) NSString *proname;
//[3]    (null)    @"proname" : @"物联网XD商家"
//"orderid": "90f23dfd156949eab58bffe2eeed5af9",
//                "payway": 1,
//                "ordermoney": 2980.0,
//                "paytime": "2020-05-19 09:56:33",
//                "orderstate": 5,
//                "paymoney": 2980.0,
//                "addtime": "2020-05-19 09:55:27",
//                "proid": "1",
//                "shopid": "0081b1c7-207e-4134-ba14-4b5f3720b552"
@end

NS_ASSUME_NONNULL_END
