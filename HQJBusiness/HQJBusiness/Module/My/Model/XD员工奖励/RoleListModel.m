//
//  RoleListModel.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/6.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RoleListModel.h"

@implementation RoleListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nid":@"id"};
}

- (id)copyWithZone:(nullable NSZone *)zone {
    RoleListModel *model = [[RoleListModel allocWithZone:zone]init];
    model.nid = self.nid;
    model.mid = self.mid;
    model.roleName = self.roleName;
    model.roleDesc = self.roleDesc;
    model.roleAward = self.roleAward;
    model.roleAwardLimit = self.roleAwardLimit;
    model.roleRate = self.roleRate;
    model.roleLimitDesc = self.roleLimitDesc;
    model.roleLimit = self.roleLimit;
    model.createTime = self.createTime;
    model.curstate = self.curstate;
    model.note = self.note;
    return model;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
        RoleListModel *model = [[RoleListModel allocWithZone:zone]init];
        model.nid = self.nid;
        model.mid = self.mid;
        model.roleName = self.roleName;
        model.roleDesc = self.roleDesc;
        model.roleAward = self.roleAward;
        model.roleAwardLimit = self.roleAwardLimit;
        model.roleRate = self.roleRate;
        model.roleLimitDesc = self.roleLimitDesc;
        model.roleLimit = self.roleLimit;
        model.createTime = self.createTime;
        model.curstate = self.curstate;
        model.note = self.note;
        return model;
    
}
@end
