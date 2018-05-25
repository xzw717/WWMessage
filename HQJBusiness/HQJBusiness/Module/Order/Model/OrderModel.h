//
//  OrderModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class GoodsModel;
#import "GoodsModel.h"

@interface OrderModel : NSObject

@property (nonatomic,strong) NSString *nid;

@property (nonatomic,strong) NSString *state;

@property (nonatomic,strong) NSString *shopname;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,assign) CGFloat  price;

@property (nonatomic,assign) NSInteger date;

@property (nonatomic,strong) NSString *username;

@property (nonatomic, strong) NSString *userid;

@property (nonatomic,strong) NSString *goodspicture;

@property (nonatomic,strong) NSString *role;

@property (nonatomic,strong) NSString *memberid;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *shoppicture;

@property (nonatomic, strong) NSString *classify;

@property (nonatomic, strong) NSString *shopid;

@property (nonatomic, assign) NSInteger usedate;

@property (nonatomic, strong) NSMutableArray <GoodsModel *>*goodslist;

@end
