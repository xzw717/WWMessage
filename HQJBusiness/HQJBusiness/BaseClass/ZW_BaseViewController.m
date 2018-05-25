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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = DefaultBackgroundColor;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
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
