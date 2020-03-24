//
//  ShopModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/3/10.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopDetailModel : NSObject

@property (nonatomic,copy)NSString *mainBusiness;//用户头像
@property (nonatomic,copy)NSString *merchantsname;//姓名
@property (nonatomic,copy)NSString *QrCode;//二维码
@property (nonatomic,copy)NSString *sign;//签名

@end

NS_ASSUME_NONNULL_END
