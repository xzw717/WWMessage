//
//  HQJBaseSubVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJBaseSubVC.h"

@interface HQJBaseSubVC ()
@property (nonatomic, strong)  UIButton *backButton;
@property (nonatomic, assign) HQJNavigationBarColor shadowType;
@property (nonatomic, strong) UIView *stateBackgroundView;
@end

@implementation HQJBaseSubVC

- (instancetype)initWithNavType:(HQJNavigationBarColor)type
{
    self = [super init];
    if (self) {
        self.shadowType = type;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)setIsHideShadowLine:(BOOL)isHideShadowLine {
    _isHideShadowLine = isHideShadowLine;
    if (isHideShadowLine) {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    } else {
        [self.navigationController.navigationBar setShadowImage:nil];

    }
}
//- (void)hideShadowLine {
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//}
- (void)setNavType:(HQJNavigationBarColor)navType {
    _navType = navType;
    switch (navType) {
        case HQJNavigationBarWhite: {
            [self whiteType];
            }
            break;
        case HQJNavigationBarBlue: {
            [self blueType];
        }
            break;
        default:
            break;
    }
}
- (void)setStateBarType:(HQJNavigationBarColor)stateBarType {
    _stateBarType = stateBarType;
    self.stateBackgroundView.hidden = NO;
    switch (stateBarType) {
        case HQJNavigationBarWhite: {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.stateBackgroundView.backgroundColor = [UIColor whiteColor];
        }
            break;
        case HQJNavigationBarBlue: {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.stateBackgroundView.backgroundColor = DefaultAPPColor;
        }
            break;
        default:
            break;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.stateBackgroundView.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.fd_prefersNavigationBarHidden = YES;
   

    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, 0, 22, 22);
    @weakify(self);
    [_backButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.backBlock) {
            self.backBlock();
        } else {
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
        }
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = barItem;
    self.navType = self.shadowType;
    [self.view addSubview:self.stateBackgroundView];
    [self.stateBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(StatusBarHeight);
    }];
    
    
}


-(void)whiteType {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor] ;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:18.f]};
    [_backButton setImage:[UIImage imageNamed:@"goodsRelease_return"] forState:UIControlStateNormal];
}

- (void)blueType {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barTintColor = DefaultAPPColor;
    [self.navigationController.navigationBar setBackgroundImage:[ManagerEngine createImageWithColor:DefaultAPPColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18.f]};
    [_backButton setImage:[UIImage imageNamed:@"icon_back_arrow_white"] forState:UIControlStateNormal];

}

-(void)popViews {
    
    for (UIViewController* v in self.navigationController.viewControllers) {
        
        if ([[NSString stringWithFormat:@"%@",[v class]] isEqualToString:self.viewControllerName]) {
            [self.navigationController popToViewController:v animated:YES];
            
        }
        
    }
    
    
}
- (UIView *)stateBackgroundView {
    if (!_stateBackgroundView) {
        _stateBackgroundView = [[UIView alloc]init];
        _stateBackgroundView.hidden = YES;
    }
    return _stateBackgroundView;
}

@end
