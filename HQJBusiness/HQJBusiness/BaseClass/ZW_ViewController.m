//
//  ZW_ViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"

@interface ZW_ViewController ()

@end

@implementation ZW_ViewController
-(UIView *)zwNavView {
    if (!_zwNavView) {
        _zwNavView = [[UIView alloc]init];
        _zwNavView.frame = CGRectMake(0, 0, WIDTH, NavigationControllerHeight);
        _zwNavView.backgroundColor = [UIColor whiteColor];
    }
    
    return _zwNavView;
}

-(UILabel *)zwTitLabel {
    
    if (!_zwTitLabel) {
        _zwTitLabel = [[UILabel alloc]init];
        _zwTitLabel.font = [UIFont systemFontOfSize:18.f];
        _zwTitLabel.textColor = [UIColor blackColor];
        [_zwNavView addSubview:_zwTitLabel];
    }
    
    return _zwTitLabel ;
}

-(UIButton *)zwBackButton {
    if (!_zwBackButton) {
        _zwBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateNormal];
//        [_zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateHighlighted];
        [_zwNavView addSubview:_zwBackButton];
    }
    
    
    return _zwBackButton;
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
    self.zwNavView.backgroundColor = [color colorWithAlphaComponent:apl];
    self.bottomLineView.hidden = apl != 1 ? YES : NO;  /// 如果导航栏有设置透明度底部线条就隐藏
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.zwNavView];
    [self.view bringSubviewToFront:self.zwNavView];
    [self.zwNavView addSubview:self.bottomLineView];
    self.fd_prefersNavigationBarHidden = YES;
    self.zwBackButton.sd_layout.leftSpaceToView(self.zwNavView,0).topSpaceToView(self.zwNavView,NavigationControllerHeight - 44).heightIs(44).widthIs(44);
    self.bottomLineView.sd_layout.leftSpaceToView(self.zwNavView, 0).rightSpaceToView(self.zwNavView, 0).heightIs(0.5).topSpaceToView(self, NavigationControllerHeight - 0.5);
    [self.zwTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.zwNavView);
        make.centerY.mas_equalTo(self.zwBackButton);
    }];
    @weakify(self);
    [self.zwBackButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.viewControllerName) {
            
            
            for (UIViewController* v in self.navigationController.viewControllers) {
                
                if ([[NSString stringWithFormat:@"%@",[v class]] isEqualToString:self.viewControllerName]) {
                    [self.navigationController popToViewController:v animated:YES];
            
                }
        
            }
            
        
        } else {
            if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 0) {
                [self.navigationController popViewControllerAnimated:YES];

            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        
        }
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)setZw_rightOneButton:(UIButton *)zw_rightOneButton {
    
    _zw_rightOneButton = zw_rightOneButton;
    
    [self.zwNavView addSubview:zw_rightOneButton];
    
    zw_rightOneButton.sd_layout.rightSpaceToView(self.zwNavView, kEDGE).centerYIs(self.zwNavView.centerY_sd + 20 /2).heightIs(40).widthIs(40);
    
    
}
- (void)setZw_rightTwoButton:(UIButton *)zw_rightTwoButton {
    
    _zw_rightTwoButton = zw_rightTwoButton;
    
    [self.zwNavView addSubview:zw_rightTwoButton];
        
    zw_rightTwoButton.sd_layout.leftSpaceToView(self.zw_rightOneButton,WIDTH - 14 * 2 - 22 * 2).topSpaceToView(self.zwNavView,33).heightIs(22).widthIs(22);

    
    
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
        
        [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:self.zw_title preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }];
       
        
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

    
    self.zwTitLabel.text = zw_title;
    
    CGFloat titleWidth = [ManagerEngine setTextWidthStr:zw_title andFont:[UIFont systemFontOfSize:18.f]];
    
//    self.zwTitLabel.sd_layout.leftSpaceToView(self.zwNavView,(WIDTH - titleWidth) / 2).bottomSpaceToView(self.zwNavView,15).heightIs(18).widthIs(titleWidth);
    
    
    
//    [ManagerEngine navTitle:self andTitle:zw_title];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
