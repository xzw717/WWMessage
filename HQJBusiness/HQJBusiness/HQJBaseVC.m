//
//  HQJBaseVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJBaseVC.h"

@interface HQJBaseVC ()
//@property (nonatomic, strong) id *name;
@end

@implementation HQJBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.tabBarItem.title;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.fd_prefersNavigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barTintColor = DefaultAPPColor;
    [self.navigationController.navigationBar setBackgroundImage:[ManagerEngine createImageWithColor:DefaultAPPColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18.f]};

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.fd_prefersNavigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[ManagerEngine createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

}

- (void)setIsHiddenshadowImage:(BOOL)isHiddenshadowImage {
    _isHiddenshadowImage = isHiddenshadowImage;
    if (isHiddenshadowImage == YES) {
        self.navigationController.navigationBar.shadowImage = [UIImage new];
    }else {
        self.navigationController.navigationBar.shadowImage = nil;

    }

}

@end
