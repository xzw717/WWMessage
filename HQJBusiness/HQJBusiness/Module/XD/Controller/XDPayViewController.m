//
//  XDViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDPayViewController.h"
#import "XDPayView.h"
#import "XDPaySureViewController.h"
@interface XDPayViewController ()
@property (nonatomic,strong) XDPayView *payView;
@end

@implementation XDPayViewController

- (XDPayView *)payView{
    if (_payView == nil) {
        _payView = [[XDPayView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight)];
    }
    return _payView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zwNavView.backgroundColor = [UIColor whiteColor];
    self.zw_title = @"支付";
    [self.view addSubview:self.payView];
    self.payView.priceLabel.text = [NSString stringWithFormat:@"服务费用¥%@元",self.priceStr];
    [ManagerEngine setTextColor:self.payView.priceLabel FontNumber:[UIFont systemFontOfSize:24.0] AndRange:[NSString stringWithFormat:@"¥%@",self.priceStr] AndColor:[ManagerEngine getColor:@"ff4a49"]];
    [self.payView.payButton addTarget:self action:@selector(getoPay) forControlEvents:UIControlEventTouchUpInside];
    
    

}

- (void)getoPay{
    XDPaySureViewController *psvc = [[XDPaySureViewController alloc]init];
    [self.navigationController pushViewController:psvc animated:YES];
    //    [PayEngine payActionOutTradeNOStr:self.orderID andSubjectStr:[NSString stringWithFormat:@"%@@%@",self.model.parentName,[NameSingle shareInstance].name] andNameStr:@"商品一批" andTotalFeeSt:[NSString stringWithFormat:@"%.2f",[_numerStr doubleValue] * 2]];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
