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
//子公司名称
@property (nonatomic,strong)NSString *subCompanyName;
/// 提示设置密码的弹窗是否已经出现
@property (nonatomic, assign) BOOL isShow;
+(instancetype) shareInstance ;

@end
