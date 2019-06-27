//
//  HQJBaseVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJBaseVC.h"

@interface HQJBaseVC ()

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
    self.navigationController.navigationBar.barTintColor = [ManagerEngine getColor:@"18abf5"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18.f]};

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.fd_prefersNavigationBarHidden = NO;
}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
