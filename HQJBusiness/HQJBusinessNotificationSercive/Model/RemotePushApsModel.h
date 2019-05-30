//
//  RemotePushApsModel.h
//  HQJBusinessNotificationSercive
//
//  Created by mymac on 2019/5/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RemotePushApsModel : NSObject
@property (nonatomic, strong) NSString *alert;
@property (nonatomic, strong) NSString *badge;
@property (nonatomic, strong) NSString *nmutable;
@property (nonatomic, strong) NSString *sound;

@end

NS_ASSUME_NONNULL_END
