//
//  BonusChangeVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BonusChangeVC.h"

@interface BonusChangeVC ()

@end

@implementation BonusChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typePage = 2;
    self.type = @"scoreExchangeList";

    [self requstType:@"scoreExchangeList" andPage:[NSString stringWithFormat:@"%ld",(long)self.page]];

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
