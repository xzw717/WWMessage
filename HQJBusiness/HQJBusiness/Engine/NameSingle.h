//
//  NameSingle.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameSingle : NSObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *role;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *memberid;
+(instancetype) shareInstance ;

@end
