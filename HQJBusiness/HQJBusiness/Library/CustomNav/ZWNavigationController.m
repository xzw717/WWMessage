//
//  KSNavigationController.m
//  WuWuMap
//
//  Created by mymac on 16/6/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZWNavigationController.h"

@interface ZWNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    //设置NavigationBar
//    [self setupNavigationBar];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

//设置导航栏主题
- (void)setupNavigationBar
{
    
//    self.lh_barTintColor = [ManagerEngine getColor:@"00ccb8"];
    
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
    [appearance setBarTintColor:[ManagerEngine getColor:@"18abf5"]];
    
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    [appearance setTitleTextAttributes:textAttribute];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
        [backButton setImage:[UIImage imageNamed:@"ARROW---LEFT"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"ARROW---LEFT"] forState:UIControlStateHighlighted];
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [backButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popView
{
    [self popViewControllerAnimated:YES];
}

//手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
