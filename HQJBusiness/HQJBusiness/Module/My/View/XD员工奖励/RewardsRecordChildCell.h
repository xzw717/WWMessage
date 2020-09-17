//
//  RewardsRecordChildCell.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/3.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
@class RewardsRecordModel;
NS_ASSUME_NONNULL_BEGIN

@interface RewardsRecordChildCell : ZW_TableViewCell
//@property (nonatomic, strong) RewardsRecordModel *cellModel;
- (void)setModelWithModel:(RewardsRecordModel *)cellModel type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
