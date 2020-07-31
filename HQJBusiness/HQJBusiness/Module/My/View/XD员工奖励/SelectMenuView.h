//
//  SelectMenuView.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectMenuView;
typedef SelectMenuView *_Nonnull(^MenuArrayBlock)(NSArray * _Nonnull titAray);
typedef SelectMenuView *_Nonnull(^MenuViewSelf)(void);
typedef SelectMenuView *_Nonnull(^MenufromView)(UIView * _Nonnull view);
typedef  void(^ClickTitle)(NSString * _Nonnull str);

NS_ASSUME_NONNULL_BEGIN

@interface SelectMenuView : UIView
@property (nonatomic, copy) MenuArrayBlock munuAry;
@property (nonatomic, copy) MenuViewSelf showView;
@property (nonatomic, copy) MenufromView clickView;
@property (nonatomic, copy) ClickTitle clickTitle;

- (instancetype)initWithView:(UIView *)view;
+ (instancetype)showMenuWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
