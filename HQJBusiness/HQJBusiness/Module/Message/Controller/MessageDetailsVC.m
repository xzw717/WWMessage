//
//  MessageDetailsVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/22.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageDetailsVC.h"
#import "MessageDetailsView.h"

@interface MessageDetailsVC ()

@end

@implementation MessageDetailsVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setIsHideShadowLine:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统维护";
    MessageDetailsView *view = [[MessageDetailsView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
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
