//
//  AllOrdeVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AllOrdeVC.h"
#import "OrderModel.h"
#import "OrderDetailsViewController.h"
#import "OrderDetailPageViewController.h"

@interface AllOrdeVC ()

@end

@implementation AllOrdeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"0";
    [self requstType:@"0" andPage:@"0"];
    @weakify(self);
    [self setSelectRowBlock:^(OrderModel *model) {
        @strongify(self);
        OrderDetailPageViewController *vc = [[OrderDetailPageViewController alloc]init];
        vc.orderDetailModel = model;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
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
