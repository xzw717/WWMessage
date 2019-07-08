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
@end

@implementation HQJBaseSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.fd_prefersNavigationBarHidden = YES;
   

    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, 0, 22, 22);
    [_backButton bk_addEventHandler:^(id  _Nonnull sender) {
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
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = barItem;
}


-(void)whiteType {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor] ;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:18.f]};
    [_backButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateNormal];
}

- (void)blueType {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barTintColor = DefaultAPPColor;
    [self.navigationController.navigationBar setBackgroundImage:[ManagerEngine createImageWithColor:DefaultAPPColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18.f]};
    [_backButton setImage:[UIImage imageNamed:@"icon_back_arrow_white"] forState:UIControlStateNormal];

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
