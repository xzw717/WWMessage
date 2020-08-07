//
//  RewardSetHeaderView.h
//  HQJBusiness
//
//  Created by mymac on 2020/8/3.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

@protocol RewardSetEditDelegate <NSObject>

@optional
- (void)clickEdit;
@end

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardSetHeaderView : UIView
@property (nonatomic, weak) id <RewardSetEditDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
