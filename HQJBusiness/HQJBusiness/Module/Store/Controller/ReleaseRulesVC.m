//
//  ReleaseRulesVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/19.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ReleaseRulesVC.h"
#import "GoodsReleaseVC.h"
@interface ReleaseRulesVC ()
@property (nonatomic, strong) UIButton *agreedButton;
@end

@implementation ReleaseRulesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品发布规则";
    // Do any additional setup after loading the view.
    
    [self.view addSubview: self.agreedButton];
    [self.agreedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-80 / 3.f);
        make.left.mas_equalTo(30 / 3.f);
        make.right.mas_equalTo(-30 / 3.f);
        make.height.mas_equalTo(44.f);
        
    }];
    if (self.isInitiative) {
        [self.agreedButton setHidden:YES];
    } else {
        [self.agreedButton setHidden:NO];

    }
}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//     [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.stateBarType = HQJNavigationBarBlue;
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//
//}
- (UIButton *)agreedButton {
    if (!_agreedButton) {
        _agreedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreedButton setBackgroundColor:DefaultAPPColor];
        [_agreedButton setTitle:@"阅读并同意" forState:UIControlStateNormal];
        [_agreedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_agreedButton.layer setMasksToBounds:YES];
        [_agreedButton.layer setCornerRadius:22.f];
        [_agreedButton bk_addEventHandler:^(id  _Nonnull sender) {
            SetHaveAgreed;
            GoodsReleaseVC * vc = [[GoodsReleaseVC alloc]initWithNavType:HQJNavigationBarWhite buttonStyle:ReleaseButtonStylePublishNow controllerTitle:@"商品发布"];
            [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreedButton;
}

@end
