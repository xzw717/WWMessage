//
//  HQJSelectToolView.h
//  WuWuMap
//
//  Created by mymac on 2020/4/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickToolBtn)(NSInteger indx);
@interface HQJSelectToolView : UIView
@property (nonatomic, copy  ) ClickToolBtn index;
- (instancetype)initWithTitleAry:(NSArray <NSString *>*)ary;
@end

NS_ASSUME_NONNULL_END
