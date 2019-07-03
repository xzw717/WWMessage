//
//  MessageGeneralCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/1.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageGeneralCell : ZW_TableViewCell
- (void)unreadMessage;
- (void)readMessage;
@end

NS_ASSUME_NONNULL_END
