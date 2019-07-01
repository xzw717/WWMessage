//
//  ChildBaseViewController.m
//  WuWuMap
//
//  Created by mymac on 2017/2/27.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChildBaseViewController.h"

@interface ChildBaseViewController ()

@end




@implementation ChildBaseViewController

- (ChildNav *)navView {
    if (_navView == nil) {
        _navView = [[ChildNav alloc]initWithFrame:CGRectMake(0, 0, WIDTH, NavigationControllerHeight )];
    }
    
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.navView];
//    [self.view bringSubviewToFront:self.navView];

    self.fd_prefersNavigationBarHidden = YES;
    if (_isNavBackgroundColorAlpha) {
        self.navView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    }

    @weakify(self);

    
    [[self.navView.backButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
     
        self.back ? self.back(): [self.navigationController popViewControllerAnimated:YES];
        
        }];


}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)setTitleString:(NSString *)titleString {
    self.navView.titleLabel.text = titleString;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    HQJLog(@"-child---%@",viewControllerToPresent.presentedViewController);
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
