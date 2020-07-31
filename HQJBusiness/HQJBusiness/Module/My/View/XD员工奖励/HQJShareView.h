//
//  PerfectView.h
//  WuWuMap
//
//  Created by 姚 on 2019/9/23.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cancelClickblock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface HQJShareView : UIView
@property (nonatomic, strong) void(^clickItemblock)(NSString *title);
@property (nonatomic, copy  ) cancelClickblock cancel;
@property (nonatomic, strong) UIView *maskView;

- (instancetype)initWithTitleArray:(NSArray *)titleArray;
+ (instancetype)showShareViewWithArray:(NSArray *)titleArray;

@end

NS_ASSUME_NONNULL_END
