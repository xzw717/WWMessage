//
//  MessageNotificationModel.h
//  HQJBusiness
//
//  Created by mymac on 2017/4/17.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageNotificationModel : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *title;
@end
