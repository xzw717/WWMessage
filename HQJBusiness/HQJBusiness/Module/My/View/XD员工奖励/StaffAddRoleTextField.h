//
//  StaffAddRoleTextField.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/31.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@protocol AddRoleDelegate <NSObject>

@optional
- (void)addRoleWithTile:(NSString *)role;
@end
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffAddRoleTextField : UIView
@property (nonatomic, weak) id <AddRoleDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
