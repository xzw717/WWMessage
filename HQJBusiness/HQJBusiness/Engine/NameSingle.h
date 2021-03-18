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
@property (nonatomic,strong)NSString *membertype;
@property (nonatomic,assign)NSInteger peugeotid;//peugeotid;//XD企业类型 0非XD企业 1.标识企业 2.异盟企业 3.标杆企业 4.兄弟企业 5.生态企业 6.XD商家


//子公司名称
@property (nonatomic,strong)NSString *subCompanyName;
/// 提示设置密码的弹窗是否已经出现
@property (nonatomic, assign) BOOL isShow;
+(instancetype) shareInstance ;

@end
