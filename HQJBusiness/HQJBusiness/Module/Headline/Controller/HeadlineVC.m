//
//  HeadlineVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HeadlineVC.h"

@interface HeadlineVC ()

@end

@implementation HeadlineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"头条";
  




}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backButton.hidden = YES;
        
    });
}
@end
