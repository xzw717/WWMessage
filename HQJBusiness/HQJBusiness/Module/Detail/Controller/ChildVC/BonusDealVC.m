//
//  BonusDealVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BonusDealVC.h"

@interface BonusDealVC ()

@end

@implementation BonusDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typePage = 0;
    self.type = @"myBonusList";
    [self requstType:@"myBonusList" andPage:[NSString stringWithFormat:@"%ld",(long)self.page]];


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
