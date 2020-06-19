//
//  HQJAlertView.m
//  HQJBusiness
//
//  Created by mymac on 2020/6/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJAlertView.h"
@interface HQJAlertView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *firstAction;
@property (nonatomic, strong) UIButton *twoAction;
@end
@implementation HQJAlertView
static HQJAlertView *alert;
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

+ (instancetype)shareShowView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert = [[HQJAlertView alloc]initWithFrame:CGRectZero];
    });
    return alert;
}

- (instancetype)showViewWithMessage:(NSString *)message {

    return [HQJAlertView shareShowView];
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
//        _bgView.backgroundColor = [];
    }
    return _bgView;
}



@end
