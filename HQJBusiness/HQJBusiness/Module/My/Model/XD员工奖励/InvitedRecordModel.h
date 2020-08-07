//
//  InvitedRecordModel.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/6.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
   "area": null,
             "uname": "hqj18049950316",
             "gender": "",
             "registerTime": 0,
             "mobile": "18049950316",
             "birth": 0,
             "merchantId": "13",
             "parent_id": 1,
             "isLocked": 0,
             "idcard": "",
             "nickname": "",
             "id": 34017,
             "itype": 1
 */
@interface InvitedRecordModel : NSObject
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *registerTime;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *birth;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *parent_id;
@property (nonatomic, strong) NSString *isLocked;
@property (nonatomic, strong) NSString *idcard;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *itype;

@end

NS_ASSUME_NONNULL_END
