//
//  NewXDChildViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/27.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NewXDChildViewController.h"

@interface NewXDChildViewController ()

@end

@implementation NewXDChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.zwBackButton setImage:[UIImage imageNamed:@"icon_Return"] forState:UIControlStateNormal];
    self.zwNavView.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
    self.view.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
    
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
