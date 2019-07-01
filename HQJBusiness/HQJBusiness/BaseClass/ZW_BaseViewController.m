//
//  ZW_BaseViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/16.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_BaseViewController.h"

@interface ZW_BaseViewController ()

@end

@implementation ZW_BaseViewController
+ (void)load {
    [super load];
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
    [navigationBar setBarTintColor:[UIColor blackColor]];
    
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    [navigationBar setTitleTextAttributes:textAttribute];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = DefaultBackgroundColor;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
}

//设置导航栏主题
- (void)setupNavigationBar
{
    
    //    self.lh_barTintColor = [ManagerEngine getColor:@"00ccb8"];
    
    

    
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
