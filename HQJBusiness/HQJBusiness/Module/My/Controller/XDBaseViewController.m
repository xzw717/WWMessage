//
//  XDBaseViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDBaseViewController.h"

@interface XDBaseViewController ()

@end

@implementation XDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.zwBackButton setImage:[UIImage imageNamed:@"icon_Return"] forState:UIControlStateNormal];
    self.zwTitLabel.textColor = [ManagerEngine getColor:@"333333"];
    self.zwTitLabel.font = [UIFont systemFontOfSize:NewProportion(54) weight:UIFontWeightBold];
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
