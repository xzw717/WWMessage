//
//  AlreadyVerificationVC.m
//  HQJBusiness
//
//  Created by mymac on 2017/12/1.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AlreadyVerificationVC.h"

@interface AlreadyVerificationVC ()

@end

@implementation AlreadyVerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"10086";
    [self requstType:@"10086" andPage:@"0"];
    
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
