//
//  MyModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
@property (nonatomic,copy)NSString *memberid;
@property (nonatomic,copy)NSString *loginname;
@property (nonatomic,copy)NSString *realname;
@property (nonatomic,copy)NSString *zh;
@property (nonatomic,copy)NSString *bonus;
@property (nonatomic,copy)NSString *cashZH;
@property (nonatomic,copy)NSString *bonusZH;
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *role;
@property (nonatomic,copy)NSString *identitynum;
@property (nonatomic,copy)NSString *zipcode;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *typeid;
@property (nonatomic,copy)NSString *membertype;
@property (nonatomic,copy)NSString *addtime;

/// 当日积分
@property (nonatomic,copy)NSString *incomeBToday;

/// 当日现金
@property (nonatomic,copy)NSString *incomCToday;

@end
