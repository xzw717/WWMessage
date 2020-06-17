//
//  ContactModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactModel : NSObject
//"type": 1,      ----1：物联网新商业 2：国物追溯平台
//            "signUrl": "合同预览签署地址",
//"peugeotid": 3,   -----标识id
//            "signtime": "签署时间"
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *signUrl;
@property (nonatomic, strong) NSString *peugeotid;
@property (nonatomic, strong) NSString *signtime;
@end

NS_ASSUME_NONNULL_END
