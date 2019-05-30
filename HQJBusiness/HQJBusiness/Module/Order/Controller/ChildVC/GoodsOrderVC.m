//
//  GoodsOrderVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsOrderVC.h"
#import "OrderDetailsViewController.h"
@interface GoodsOrderVC ()

@end

@implementation GoodsOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"1";
    [self requstType:@"1" andPage:@"0"];
    @weakify(self);
    [self setSelectRowBlock:^(OrderModel *model) {
        @strongify(self);
        OrderDetailsViewController *vc = [[OrderDetailsViewController alloc]initWithModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    }];
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
