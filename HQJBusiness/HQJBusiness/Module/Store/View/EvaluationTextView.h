//
//  EvaluationTextView.h
//  
//
//  Created by mymac on 2017/7/13.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationTextView : UITextView

/// 占位符
@property (nonatomic, strong) NSString *placeholder;

/// 占位符颜色
@property (nonatomic, strong) UIColor *placeholderColor;

/// 占位符大小
@property (nonatomic, strong) UIFont *placeholderFont;
@end
