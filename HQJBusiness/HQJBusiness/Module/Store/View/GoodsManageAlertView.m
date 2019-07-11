//
//  GoodsManageAlertView.m
//  HQJBusiness
//  商品管理提示框
//  Created by mymac on 2019/7/11.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//




#import "GoodsManageAlertView.h"

@interface AlertCustomButton : UIButton

@end
@interface AlertCustomButton ()

@end
@implementation AlertCustomButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    // 若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat deltaW = MAX(100 - bounds.size.width, 0);
    CGFloat deltaH = MAX(100 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -deltaW * 0.5, -deltaH * 0.5);
    return CGRectContainsPoint(bounds, point);
}

@end



@interface GoodsManageAlertView ()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) AlertCustomButton *noButton;
@property (nonatomic, strong) AlertCustomButton *yesButton;
@property (nonatomic, copy) GoodsManageAlertViewBlock deny; /// 否认
@property (nonatomic, copy) GoodsManageAlertViewBlock affirm; /// 确定

@end
@implementation GoodsManageAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self) {
        [self goodsManageAlertView_addSubView];
        [self goodsManageAlertView_layoutSubView];
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        [UIView animateWithDuration:1.5 animations:^{
            self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
            [[UIApplication sharedApplication].delegate.window addSubview:self];

        } completion:^(BOOL finished) {
            
        }];
    }
    return self;
}

+ (void)alertViewInitWithTitle:(NSString *)title Complete:(GoodsManageAlertViewBlock)complete {
    [GoodsManageAlertView alertViewInitWithTitle:title fristBtnTitle:nil twoBtnTitle:nil Complete:complete];
    
}

+ (void)alertViewInitWithTitle:(NSString *)title
                 fristBtnTitle:(NSString *)fristBtn
                   twoBtnTitle:(NSString *)twoBtn
                      Complete:(GoodsManageAlertViewBlock)complete {
    GoodsManageAlertView *view =  [[GoodsManageAlertView alloc]init];
    view.affirm = complete;
    view.titleLabel.text = title;
    if (fristBtn) {
        [view.noButton setTitle:fristBtn forState:UIControlStateNormal];
    }
    if (twoBtn) {
        [view.yesButton setTitle:twoBtn forState:UIControlStateNormal];
    }
}
- (void)clickYesBtn {
    !self.affirm ? :self.affirm();
    [self goodsManageAlertView_hiddeView];

}

- (void)clickNoBtn {
    [self goodsManageAlertView_hiddeView];
}
- (void)goodsManageAlertView_hiddeView {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
        
        for (UIView *view in self.subviews) {
            view.alpha = 0;
            [view removeFromSuperview];
            
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
- (void)goodsManageAlertView_addSubView {
    [self addSubview:self.maskView];
    [self.maskView addSubview:self.titleLabel];
    [self.maskView addSubview:self.lineView];
    [self.maskView addSubview:self.noButton];
    [self.maskView addSubview:self.yesButton];

}
- (void)goodsManageAlertView_layoutSubView {
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(67.5f);
        make.right.mas_equalTo(-67.5f);
        make.height.mas_equalTo(self.maskView.mas_width).multipliedBy(470 / 720.f);
        make.center.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(137 / 3.f);
        make.centerX.mas_equalTo(self.maskView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 / 3.f);
        make.right.mas_equalTo(-20 / 3.f);
        make.bottom.mas_equalTo(- 40 / 3 * 2 - 100 / 3.f);
        make.height.mas_equalTo(.5f);
    }];
    [self.noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40 / 3.f);
        make.bottom.mas_equalTo(-40 / 3.f);
        make.width.mas_equalTo(300 / 3.f);
        make.height.mas_equalTo(100 / 3.f);
    }];
    [self.yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-40 / 3.f);
        make.width.mas_equalTo(300 / 3.f);
        make.height.mas_equalTo(100 / 3.f);
    }];
}
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.layer.masksToBounds = YES;
        _maskView.layer.cornerRadius = 5.f;
        _maskView.backgroundColor = [UIColor whiteColor];
    }
    return _maskView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"占位标题";
        _titleLabel.textColor = [ManagerEngine getColor:@"010101"];
        _titleLabel.font = [UIFont systemFontOfSize:40 / 3.f];
    }
    return _titleLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"d8d6d6"];
    }
    return _lineView;
}
- (AlertCustomButton *)noButton {
    if (!_noButton) {
        _noButton = [AlertCustomButton buttonWithType:UIButtonTypeCustom];
        _noButton.layer.masksToBounds = YES;
        _noButton.layer.cornerRadius = 100 / 3 / 2.f;
        _noButton.layer.borderColor = [UIColor grayColor].CGColor;
        _noButton.layer.borderWidth = .5f;
        [_noButton setTitle:@"否" forState:UIControlStateNormal];
        [_noButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_noButton addTarget:self action:@selector(clickNoBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noButton;
}
- (AlertCustomButton *)yesButton {
    if (!_yesButton) {
        _yesButton = [AlertCustomButton buttonWithType:UIButtonTypeCustom];
        _yesButton.layer.masksToBounds = YES;
        _yesButton.layer.cornerRadius = 100 / 3 / 2.f;
        _yesButton.backgroundColor = [ManagerEngine getColor:@"ff49494"];
        [_yesButton setTitle:@"是" forState:UIControlStateNormal];
        [_yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_yesButton addTarget:self action:@selector(clickYesBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yesButton;
}
@end
