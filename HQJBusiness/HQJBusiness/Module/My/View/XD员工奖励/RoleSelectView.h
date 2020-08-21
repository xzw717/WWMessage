//
//  RoleSelectView.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@protocol RoleDelegate <NSObject>

@optional
- (void)clickRoleView:(id _Nonnull )view;
@end
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoleSelectView : UIView
@property (nonatomic, strong) UILabel *roleLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, weak) id <RoleDelegate> delegate;
@property (nonatomic, strong) NSString *roleTitleString;
@end

NS_ASSUME_NONNULL_END
