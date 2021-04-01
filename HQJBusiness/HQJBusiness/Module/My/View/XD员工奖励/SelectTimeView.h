//
//  SelectTimeView.h
//  HQJBusiness
//
//  Created by Ethan on 2020/8/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TimerClickBlock)(NSString * _Nonnull timer);
NS_ASSUME_NONNULL_BEGIN

@interface SelectTimeView : UIView
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy  ) TimerClickBlock finish;
@end

NS_ASSUME_NONNULL_END
