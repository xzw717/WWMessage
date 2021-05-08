//
//  ContentTextView.h
//  WuWuLive
//
//  Created by mymac on 2020/7/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentTextView : UITextView
/// 占位符
@property (nonatomic, strong) NSString *placeholder;

/// 占位符颜色
@property (nonatomic, strong) UIColor *placeholderColor;

/// 占位符大小
@property (nonatomic, strong) UIFont *placeholderFont;
@end

NS_ASSUME_NONNULL_END
