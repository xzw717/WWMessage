//
//  RemotePushListModel.h
//  HQJBusinessNotificationSercive
//
//  Created by mymac on 2019/5/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemotePushGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RemotePushListModel : NSObject
@property (nonatomic, strong)  NSMutableArray <RemotePushGoodsModel *>*list;
@end

NS_ASSUME_NONNULL_END
