//
//  ChildNav.m
//  WuWuMap
//  首页子视图导航
//  Created by mymac on 2017/2/27.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChildNav.h"

@interface ChildNav()

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIView *backButtonBgView;
@property (nonatomic, strong) UIView *rightToolButtonBgView;
@property (nonatomic, strong) UIView *rightToolsButtonBgView;
@end

@implementation ChildNav



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.zPosition = INT_MAX;
        
        self.backButtonBgView.hidden =   YES;
        self.rightToolButtonBgView.hidden =  YES;
        self.rightToolsButtonBgView.hidden = YES;
  
        self.backButtonBgView.alpha =   0;
        self.rightToolButtonBgView.alpha =  0;
        self.rightToolsButtonBgView.alpha = 0;

      
        [self addSubview:self.backButtonBgView];
        [self addSubview:self.rightToolButtonBgView];
        [self addSubview:self.rightToolsButtonBgView];
        
        [self addSubview:self.backButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightToolButton];
        [self addSubview:self.rightToolsButton];
        [self addSubview:self.childNavLineView];
        [self addSubview:self.progressView];
        self.backgroundColor = [UIColor whiteColor];
        
        [self.backButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.backButton);
            make.size.mas_equalTo(CGSizeMake(28, 28));
        }];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(StatusBarHeight);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WIDTH * 317 /670, 44));
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(StatusBarHeight);

        }];
        [self.rightToolButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.rightToolButton);
            make.size.mas_equalTo(CGSizeMake(28, 28));
        }];
        
        [self.rightToolsButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.rightToolsButton);
            make.size.mas_equalTo(CGSizeMake(28, 28));
        }];
        [self.rightToolButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.right).offset(-10);
            make.top.mas_equalTo(self.backButton.top);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];

        [self.rightToolsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightToolButton.left).offset(0);
            make.top.mas_equalTo(self.rightToolButton.top);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        [self.childNavLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottom).offset(0.5);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(0).priorityMedium();
            make.bottom.mas_equalTo(self.bottom).offset(0.5);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    return self;
}

- (void)setClarity:(CGFloat)clarity {
    self.backButtonBgView.hidden       =  NO;
    self.rightToolButtonBgView.hidden  =  NO;
    self.rightToolsButtonBgView.hidden =  NO;
    _clarity = clarity;
    CGFloat a = clarity  > 1 ? 1.f : clarity ;
    self.backButtonBgView.alpha=  fabs(1 - a) ;
    self.rightToolButtonBgView.alpha =  fabs(1 - a) ;
    self.rightToolsButtonBgView.alpha = fabs(1 - a) ;
    
    
}

- (void)setWebProgress:(CGFloat)webProgress {
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH * webProgress);
        if (webProgress == 1) {
            self.progressView.hidden = YES;
        }
    }];
}

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [ButtonItem buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)rightToolButton {
    if (_rightToolButton == nil) {
        _rightToolButton = [ButtonItem buttonWithType:UIButtonTypeCustom];
        [_rightToolButton setTitleColor:[ManagerEngine getColor:@"323232"] forState:UIControlStateNormal];
        _rightToolButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
    }
    
    return _rightToolButton;
}
- (UIButton *)rightToolsButton {
    if (_rightToolsButton == nil) {
        _rightToolsButton = [ButtonItem buttonWithType:UIButtonTypeCustom];
        
    }
    
    return _rightToolsButton;
}

- (UIView *)backButtonBgView {
    if (!_backButtonBgView) {
        _backButtonBgView = [[UIView alloc]init];
        _backButtonBgView.backgroundColor = [UIColor blackColor];
        _backButtonBgView.layer.masksToBounds = YES;
        _backButtonBgView.layer.cornerRadius = 14.f;
    }
    return _backButtonBgView;
}


- (UIView *)rightToolButtonBgView {
    if (!_rightToolButtonBgView) {
        _rightToolButtonBgView = [[UIView alloc]init];
        _rightToolButtonBgView.backgroundColor = [UIColor blackColor];
        _rightToolButtonBgView.layer.masksToBounds = YES;
        _rightToolButtonBgView.layer.cornerRadius = 14.f;
    }
    return _rightToolButtonBgView;
}

- (UIView *)rightToolsButtonBgView {
    if (!_rightToolsButtonBgView) {
        _rightToolsButtonBgView = [[UIView alloc]init];
        _rightToolsButtonBgView.backgroundColor = [UIColor blackColor];
        _rightToolsButtonBgView.layer.masksToBounds = YES;
        _rightToolsButtonBgView.layer.cornerRadius = 14.f;
    }
    return _rightToolsButtonBgView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:S_RatioW(18.f)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
    
}

-(UIView *)childNavLineView {
    if (_childNavLineView == nil) {
        _childNavLineView = [[UIView alloc]init];
        _childNavLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _childNavLineView;
}



- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc]init];
        _progressView.backgroundColor = DefaultAPPColor;
    }
    return _progressView;
}
@end
