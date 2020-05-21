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
#import "XDPayViewModel.h"
#import "PayEngine.h"
#import "XDPayModel.h"
@interface XDPayViewController ()
@property (nonatomic,strong) XDPayView *payView;
@property (nonatomic,strong) NSArray *payTypeArray;
@end

@implementation XDPayViewController

- (XDPayView *)payView{
    if (_payView == nil) {
        _payView = [[XDPayView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight)];
    }
    return _payView;
}
- (NSArray *)payTypeArray{
    if (_payTypeArray == nil) {
        _payTypeArray = @[@"标识企业",@"异盟企业",@"标杆企业",@"兄弟企业",@"生态企业"];
    }
    return _payTypeArray;
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayResults:) name:kNoticationPayResults object:nil];

}

- (void)getoPay{
    if (!self.payView.selectBtn.selected) {
         [SVProgressHUD showErrorWithStatus:@"请选择支付方式"];
    }else{
        [XDPayViewModel submitXDOrder:@"f46d46d8-debc-4d48-a08c-78cc857d2ae1" andProid:[NSString stringWithFormat:@"%ld",self.xdType] andPrice:self.priceStr completion:^(XDPayModel *model) {
            [PayEngine payActionOutTradeNOStr:model.orderid andSubjectStr:self.payTypeArray[self.xdType - 1] andNameStr:self.payTypeArray[self.xdType - 1] andTotalFeeSt:@"0.01"];
        }];
    }
    
    
}

#pragma mark --- 支付宝支付结果
-(void)alipayResults:(NSNotification *)infos {
    NSString *stateStr = infos.userInfo[@"strMsg"];
    if ([stateStr isEqualToString:@"支付成功"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showSuccessWithStatus:stateStr];
        [ManagerEngine SVPAfter:stateStr complete:^{
            self.viewControllerName = @"XDPaySureViewController";
            [self popViews];
        }];
    } else {

        [SVProgressHUD showErrorWithStatus:stateStr];
    }
    
    
    
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
