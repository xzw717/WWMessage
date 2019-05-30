//
//  RemotePushOrderModel.h
//  HQJBusinessNotificationSercive
//
//  Created by mymac on 2019/5/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemotePushApsModel.h"
#import "RemotePushListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RemotePushOrderModel : NSObject
@property (nonatomic, strong) NSString *_j_business;
@property (nonatomic, strong) NSString *_j_msgid;
@property (nonatomic, strong) NSString *_j_uid;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) RemotePushApsModel *aps;
@property (nonatomic, assign) NSInteger itype;
@property (nonatomic, strong) RemotePushListModel *list;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *ordertime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *totalmoney;
@property (nonatomic, strong) NSString *totalquantity;


@end

NS_ASSUME_NONNULL_END
