//
//  MemberStaffModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/5.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 id      long    数据库编码
 sid      long    所属的商家
 nickname    String    姓名
 mobile    String    手机号
 title    String    职务类型
 createTime    long    创建时间
 gender    int    性别(0:女，1:男)
 age       int    年龄
 entryTime    long    入职时间
 epassword    String    密码    不返回值
 account    String    帐号
 role        int    角色
 empNo       String    商家定义的员工编号
 salt        String    盐    不返回值
 isLocked    int    是否锁定
 qrcode     String    二维码
 note       String    备注
 */
@interface MemberStaffModel : NSObject


///           通用字段
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *isLocked;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *idcard;


///                 员工字段
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *entryTime;
@property (nonatomic, strong) NSString *epassword;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *empNo;
@property (nonatomic, strong) NSString *salt;
@property (nonatomic, strong) NSString *qrcode;


/*
 id    long    数据库编号
 parent_id    long    父级ID
 merchantId    long    商家ID
 uname    String    用户名
 nickname    String    真实姓名
 idcard    String    身份证
 isLocked    int    是否锁定
 birth    long    出生日期
 mobile    String    手机号
 registerTime    long    注册时间
 gender    int    性别(0:女,1:男)
 area    String    区域
 itype    int    类型
 */
///                 会员字段
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *merhcnat_employee_id;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *registerTime;
@property (nonatomic, strong) NSString *birth;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *parent_id;
@property (nonatomic, strong) NSString *itype;

@end

NS_ASSUME_NONNULL_END
