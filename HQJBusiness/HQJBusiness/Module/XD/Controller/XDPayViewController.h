//
//  XDViewController.h
//  HQJBusiness
//
//  Created by mymac on 2020/5/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XDPayViewController : ZW_ViewController

@property (nonatomic,strong) NSString *orderid;
@property (nonatomic,assign) NSInteger xdType;
@property (nonatomic,strong) NSString *priceStr;
@end

NS_ASSUME_NONNULL_END