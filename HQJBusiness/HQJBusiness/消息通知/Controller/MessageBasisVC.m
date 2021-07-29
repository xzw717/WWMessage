//
//  MessageBasisVC.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageBasisVC.h"

@interface MessageBasisVC ()

@end

@implementation MessageBasisVC
-(UIView *)messageNavView {
    if (!_messageNavView) {
        _messageNavView = [[UIView alloc]init];
        _messageNavView.frame = CGRectMake(0, 0, WIDTH, NavigationControllerHeight);
        _messageNavView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    }
    
    return _messageNavView;
}

-(UILabel *)messageTitLabel {
    
    if (!_messageTitLabel) {
        _messageTitLabel = [[UILabel alloc]init];
        _messageTitLabel.font = [UIFont systemFontOfSize:18.f];
        _messageTitLabel.textColor = [UIColor blackColor];
        [_messageNavView addSubview:_messageTitLabel];
    }
    
    return _messageTitLabel ;
}

-(UIButton *)messageBackButton {
    if (!_messageBackButton) {
        _messageBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBackButton setImage:[UIImage imageNamed:@"return_black"] forState:UIControlStateNormal];
        [_messageNavView addSubview:_messageBackButton];
    }
    
    
    return _messageBackButton;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _bottomLineView;
}
- (void)setNavBackgroundColor:(UIColor *)color {
    [self setNavBackgroundColor:color alpha:1.f];
}
- (void)setNavBackgroundColor:(UIColor *)color alpha:(CGFloat)apl{
    self.messageNavView.backgroundColor = [color colorWithAlphaComponent:apl];
    self.bottomLineView.hidden = apl != 1 ? YES : NO;  /// 如果导航栏有设置透明度底部线条就隐藏
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.messageNavView];
    [self.view bringSubviewToFront:self.messageNavView];
    [self.messageNavView addSubview:self.bottomLineView];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.messageBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(NavigationControllerHeight - 44.f);
        make.width.height.mas_equalTo(44.f);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5f);
        make.bottom.mas_equalTo(-1.f);
    }];

    [self.messageTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.messageNavView);
        make.centerY.mas_equalTo(self.messageBackButton);
    }];
    [self.messageBackButton addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)backBtnAction:(UIButton *)btn {
    if (self.viewControllerName) {
        
        
        for (UIViewController* v in self.navigationController.viewControllers) {
            
            if ([[NSString stringWithFormat:@"%@",[v class]] isEqualToString:self.viewControllerName]) {
                [self.navigationController popToViewController:v animated:YES];
        
            }
    
        }
        
    
    } else {
        if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];

        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    
    }
}
- (void)setMessageRightOneButton:(UIButton *)messageRightOneButton {
    _messageRightOneButton = messageRightOneButton;
    [self.messageNavView addSubview:_messageRightOneButton];
    [_messageRightOneButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(-15.f);
          make.centerY.mas_equalTo(self.messageTitLabel);
          make.width.height.mas_equalTo(40.f);
      }];
    
}
- (void)setMessageRightTwoButton:(UIButton *)messageRightTwoButton {
    _messageRightTwoButton = messageRightTwoButton;
    [self.messageNavView addSubview:_messageRightTwoButton];
    [_messageRightTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.messageTitLabel);
    }];

}







 

- (void)setMessageTitle:(NSString *)messageTitle {
    _messageTitle = messageTitle;
    self.messageTitLabel.text =messageTitle;
}


@end
