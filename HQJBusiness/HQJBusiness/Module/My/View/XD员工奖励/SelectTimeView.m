//
//  SelectTimeView.m
//  HQJBusiness
//
//  Created by Ethan on 2020/8/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SelectTimeView.h"
@interface SelectTimeView ()
@property (nonatomic, strong) NSString *timerString;
@end
@implementation SelectTimeView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self addSubview:self.datePicker];
//        [CustomWindow addSubview:self];
        self.timerString = [self formattingTime:[NSDate date]];
    }
    return self;
}
- (NSString *)formattingTime:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

      //设置时间格式
     
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}
- (void)dateChange:(UIDatePicker *)datePicker {
    !self.finish ? :self.finish([self formattingTime:datePicker.date]);

}


- (void)finishAction {
//    [self removeFromSuperview];
//    [self.textField resignFirstResponder];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3)];
               //设置中文
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
               //设置日期格式
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
                 // 设置当前显示时间
        [_datePicker setDate:[NSDate date] animated:YES];
                   // 设置显示最大时间（此处为当前时间）
//        [_datePicker setMaximumDate:[NSDate date]];
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];

    }
    return _datePicker;
}

@end
