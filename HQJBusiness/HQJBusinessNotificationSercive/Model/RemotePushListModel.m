//
//  RemotePushListModel.m
//  HQJBusinessNotificationSercive
//
//  Created by mymac on 2019/5/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RemotePushListModel.h"

@implementation RemotePushListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[RemotePushGoodsModel class]};
}
@end
