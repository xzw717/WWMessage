//
//  HQJBusinessAlertView.m
//  HQJBusiness
//
//  Created by mymac on 2017/12/7.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

@interface ZW_alertButton : UIButton
@end
@interface ZW_alertButton ()
@end
@implementation ZW_alertButton

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath_RoundedCornerRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    
    bezierPath_RoundedCornerRect.lineWidth = 0.5;
    [DefaultAPPColor set];
    [bezierPath_RoundedCornerRect stroke];

}

@end

#import "HQJBusinessAlertView.h"
#import "ZW_ChangeFigureColorLabel.h"

@interface HQJBusinessAlertView ()



/// 白色背景
@property (nonatomic, strong) UIView                            *bgView;
/// 内容的背景
@property (nonatomic, strong) UIView                            *contentBgView;
/// 头像
@property (nonatomic, strong) UIImageView                       *headerImageView;
/// 姓名
@property (nonatomic, strong) UILabel                           *nameTitleLabel;
/// 手机号
@property (nonatomic, strong) UILabel                           *numerTitleLabel;
/// 取消
@property (nonatomic, strong) ZW_alertButton                    *cancelButton;
/// 确定
@property (nonatomic, strong) UIButton                          *confirmButton;
/// 手机号
@property (nonatomic, strong) NSString                          *mobile;
/// 内容
@property (nonatomic, strong) ZW_ChangeFigureColorLabel         *contentLabel;

/// 是否是警告界面
@property (nonatomic, assign) BOOL                               isWarning;

@end
@implementation HQJBusinessAlertView

- (instancetype)initWithisWarning:(BOOL)isWarning {
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (!self) return nil;
    self.isWarning = isWarning;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [self addSubView];
    [self updateConstraintsIfNeeded];
    return self;
}




- (void)zw_showAlertWithContent {
    self.contentLabel.text = @"系统只允许添加5张银行卡，请先删除部分银行卡后再添加。";
    
    [self animationAlert:self.bgView];
    [CustomWindow addSubview:self];
}

- (void)zw_showAlertWithName:(NSString *)name mobile:(NSString *)mobile  {
    self.mobile = mobile;
    NSMutableString * starStr = [NSMutableString string];
    for (NSInteger i = 0; i < name.length - 1; i++) {
        [starStr appendString:@"*"];
    }
    NSString *mobileStr= !name ? @"" : [name stringByReplacingCharactersInRange:NSMakeRange(1, name.length - 1) withString:starStr];
    self.numerTitleLabel.text = [NSString stringWithFormat:@"联系方式：%@",mobile];
    self.nameTitleLabel.text  = [NSString stringWithFormat:@"会员姓名：%@",mobileStr];
    [self animationAlert:self.bgView];
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}


- (void)zw_alertCancel {
    [self layoutIfNeeded];
    [self.bgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 0;
        self.alpha = 0;
        self.bgView.bounds = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];

}

- (void)viewanimationModeWithHidden:(BOOL)isHidden {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.28f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionPush;
    animation.subtype =  kCATransitionFromBottom ;
    [self.bgView.layer addAnimation:animation forKey:@"animation"];
}

 - (void)animationAlert:(UIView *)view {
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
    
}

- (void)zw_alertConfirm {
    if (!self.isWarning) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.mobile]];
        [[UIApplication sharedApplication] openURL:url];
    }

    
    [self zw_alertCancel];
}

- (void)addSubView {
    [self addSubview:self.bgView];
    
    self.nameTitleLabel.hidden  = self.isWarning ?  YES : NO;
    self.numerTitleLabel.hidden = self.isWarning ?  YES : NO;
    self.cancelButton.hidden    = self.isWarning ?  YES : NO;
    [self.bgView addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.nameTitleLabel];
    [self.contentBgView addSubview:self.numerTitleLabel];
    [self.contentBgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.headerImageView];
    [self.bgView addSubview:self.cancelButton];
    [self.bgView addSubview:self.confirmButton];

}

- (void)updateConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.78);
        make.height.mas_equalTo(S_5sRatioH(170));
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(18);
        make.size.mas_equalTo(CGSizeMake(56, 41));
    }];
   
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(0);
        make.height.mas_equalTo(S_5sRatioH(75));
        make.left.right.mas_equalTo(self.bgView).offset(0);
    }];
    
 
    if (self.isWarning) {
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.width.right.mas_equalTo(self.bgView);
            make.height.mas_equalTo(40);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentBgView.mas_centerX);
            make.bottom.equalTo(self.contentBgView).offset(-S_5sRatioH(18));
            make.width.equalTo(self.bgView.mas_width).multipliedBy(0.764);
        }];
    } else {
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(self.bgView);
            make.width.mas_equalTo(self.bgView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.mas_equalTo(self.bgView);
            make.width.mas_equalTo(self.bgView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              NSLog(@"%@", self.contentBgView);
            CGFloat zw_spacing = (self.contentBgView.frame.size.height - 13 * 2 ) / 3;
            
            [self.nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.numerTitleLabel);
                make.top.mas_equalTo(self.contentBgView.mas_top).offset(zw_spacing);
            }];
            
            [self.numerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentBgView);
                make.top.mas_equalTo(self.nameTitleLabel.mas_bottom).offset(zw_spacing);
                
            }];
        });
        

      
    }
   

    [super updateConstraints];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10.f;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIView *)contentBgView {
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc]init];
        _contentBgView.backgroundColor = [UIColor clearColor];
    }
    return _contentBgView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.image = [UIImage imageNamed:self.isWarning ? @"icon_warn" : @"logo_img"];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headerImageView;
}

- (ZW_ChangeFigureColorLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[ZW_ChangeFigureColorLabel alloc]init];
        _contentLabel.zw_color = [UIColor redColor];
        _contentLabel.font = [UIFont systemFontOfSize:13.f];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (UILabel *)nameTitleLabel {
    if (!_nameTitleLabel) {
        _nameTitleLabel = [[UILabel alloc]init];
        _nameTitleLabel.font = [UIFont systemFontOfSize:13.f];
        _nameTitleLabel.textAlignment = NSTextAlignmentCenter;
        _nameTitleLabel.textColor = [UIColor blackColor];
    }
    return _nameTitleLabel;
}

- (UILabel *)numerTitleLabel {
    if (!_numerTitleLabel) {
        _numerTitleLabel = [[UILabel alloc]init];
        _numerTitleLabel.font = [UIFont systemFontOfSize:13.f];
        _numerTitleLabel.textAlignment = NSTextAlignmentCenter;
        _numerTitleLabel.textColor = [UIColor blackColor];
    }
    return _numerTitleLabel;
}

- (ZW_alertButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [ZW_alertButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(zw_alertCancel) forControlEvents:UIControlEventTouchUpInside];

    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = DefaultAPPColor;
        [_confirmButton setTitle:self.isWarning ? @"确定" : @"拨打" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(zw_alertConfirm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
