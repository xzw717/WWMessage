//
//  RequestEngine.h
//  HQJFacilitator
//
//  Created by mymac on 16/9/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestEngine : NSObject
+(void)HQJBusinessRequestDetailsUrl:(NSString *)urlStr complete:(void (^)(NSDictionary *dic))complete andError:(void(^)(NSError *error))errors ShowHUD:(BOOL)show;

@end
