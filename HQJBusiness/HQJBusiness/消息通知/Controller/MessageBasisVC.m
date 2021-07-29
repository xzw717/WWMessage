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
        _messageNavView.backgroundColor = [UIColor whiteColor];
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
        [_messageBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateNormal];
//        [_zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateHighlighted];
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
//    self.zwBackButton.sd_layout.leftSpaceToView(self.zwNavView,0).topSpaceToView(self.zwNavView,NavigationControllerHeight - 44).heightIs(44).widthIs(44);
//    self.bottomLineView.sd_layout.leftSpaceToView(self.zwNavView, 0).rightSpaceToView(self.zwNavView, 0).heightIs(0.5).topSpaceToView(self, NavigationControllerHeight - 0.5);
    [self.messageTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.messageNavView);
        make.centerY.mas_equalTo(self.messageBackButton);
    }];
    @weakify(self);
    [self.messageBackButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
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
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)setZw_rightOneButton:(UIButton *)zw_rightOneButton {
    
//    _zw_rightOneButton = zw_rightOneButton;
//
//    [self.zwNavView addSubview:zw_rightOneButton];
//
////    zw_rightOneButton.sd_layout.rightSpaceToView(self.zwNavView, kEDGE).centerYEqualToView(self.zwTitLabel).heightIs(40).widthIs(40);
//    [zw_rightOneButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(15.f);
//        make.centerY.mas_equalTo(self.zwTitLabel);
//        make.width.height.mas_equalTo(40.f);
//    }];
//
}
- (void)setZw_rightTwoButton:(UIButton *)zw_rightTwoButton {
    
//    _zw_rightTwoButton = zw_rightTwoButton;
//
//    [self.zwNavView addSubview:zw_rightTwoButton];
//        zw
//    zw_rightTwoButton.sd_layout.leftSpaceToView(self.zw_rightOneButton,WIDTH - 14 * 2 - 22 * 2).topSpaceToView(self.zwNavView,33).heightIs(22).widthIs(22);

    
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    [ManagerEngine navColorStyle:self andColor:[UIColor whiteColor]];
    [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    

}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [ManagerEngine navViewWillDisappearColor:self];

    [ManagerEngine dismissHomeSvP];
    
}





 
-(void)setBackStyle:(NavBackStyle)backStyle {
    
    [self backOnAnInterface:backStyle];

    
}

-(void)backOnAnInterface:(NavBackStyle)style {

    if (style == BackOnAnInterfaceStyle) {
        [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else  if(style == AlertViewBackStyle){
        
//        self.fd_interactivePopDisabled = YES;
        
//        [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:self.zw_title preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self.navigationController popViewControllerAnimated:YES];
//
//            }]];
//            [self presentViewController:alert animated:YES completion:nil];
//        }];
//
        
    } else {
//        self.fd_interactivePopDisabled = YES;
        [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
            [self popViews];
        }];
        
    }
    
    
}
/*
* 返回时的类型
*
*/
-(void)popViews {
    
    for (UIViewController* v in self.navigationController.viewControllers) {
        
        if ([[NSString stringWithFormat:@"%@",[v class]] isEqualToString:self.viewControllerName]) {
            [self.navigationController popToViewController:v animated:YES];
            
        }
        
    }

    
}

- (void)setZw_title:(NSString *)zw_title {

    
//    self.zwTitLabel.text = zw_title;
    
    CGFloat titleWidth = [ManagerEngine setTextWidthStr:zw_title andFont:[UIFont systemFontOfSize:18.f]];
    
//    self.zwTitLabel.sd_layout.leftSpaceToView(self.zwNavView,(WIDTH - titleWidth) / 2).bottomSpaceToView(self.zwNavView,15).heightIs(18).widthIs(titleWidth);
    
    
    
//    [ManagerEngine navTitle:self andTitle:zw_title];

    
}
@end
