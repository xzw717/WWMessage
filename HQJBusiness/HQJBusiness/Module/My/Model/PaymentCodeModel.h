//
//  PaymentCodeModel.h
//  HQJBusiness
//
//  Created by mymac on 2017/10/20.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentCodeModel : NSObject
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *sellerid;
@property (nonatomic, strong) NSString *codetype;
@property (nonatomic, strong) NSString *codeurl;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *flag;
//原来的codetype
@property (nonatomic, strong) NSString *useage;

@end
