//
//  CommodityViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/9.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CommodityViewController.h"

@interface CommodityViewController ()

@end

@implementation CommodityViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor ;
    self.title = @"商品";
 
    ZW_Label *backgroundLabel = [[ZW_Label alloc]initWithStr:@"暂未开放" addSubView:self.view];
    
    CGFloat backWith = [ManagerEngine setTextWidthStr:backgroundLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    backgroundLabel.bounds = CGRectMake(0, 0, backWith, 17);
    
    backgroundLabel.center = self.view.center;

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
