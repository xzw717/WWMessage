//
//  AddressDetailsViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddressDetailsViewController.h"

@interface AddressDetailsViewController ()
@property (nonatomic,strong)UILabel *addsLabel;
@end

@implementation AddressDetailsViewController

-(UILabel *)addsLabel {
    if ( _addsLabel == nil ) {
        _addsLabel= [[UILabel alloc]init];
        _addsLabel.font = [UIFont systemFontOfSize:16.0];
        _addsLabel.numberOfLines = 0;
    }
    
    return _addsLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zw_title = @"地址";
    
    UIView *backgroundView = [[UIView alloc]init];
    
    backgroundView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:backgroundView];
    
    backgroundView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,NavigationControllerHeight + kEDGE).heightIs(90).widthIs(WIDTH);
    
    
    self.addsLabel.text = _addressStr;
    [backgroundView addSubview:self.addsLabel];
    
    self.addsLabel.sd_layout.leftSpaceToView(backgroundView,kEDGE).topSpaceToView(backgroundView,0).heightIs(90 - kEDGE * 2).widthIs(WIDTH - kEDGE * 2);
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
