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
#import "XDPayModel.h"
@interface XDPayViewController ()
@property (nonatomic,strong) XDPayView *payView;
@property(nonatomic,strong)  XDPayModel *model;

@end

@implementation XDPayViewController
- (instancetype)initWithXDPayModel:(XDPayModel *)model {
    self = [super init];
    if (self) {
        
        self.model = model;
        
    }
    return self;
    
}
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
    self.payView.priceLabel.text = [NSString stringWithFormat:@"服务费用¥%@元",self.model.ordermoney];
    [ManagerEngine setTextColor:self.payView.priceLabel FontNumber:[UIFont systemFontOfSize:24.0] AndRange:[NSString stringWithFormat:@"¥%@",self.model.ordermoney] AndColor:[ManagerEngine getColor:@"ff4a49"]];
    [self.payView.payButton addTarget:self action:@selector(getoPay) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayResults:) name:kNoticationPayResults object:nil];

}

- (void)getoPay{
    
    if (!self.payView.selectBtn.selected) {
         [SVProgressHUD showErrorWithStatus:@"请选择支付方式"];
    }else{
        [PayEngine payActionOutTradeNOStr:self.model.orderid andSubjectStr:self.model.proname  andNameStr:self.model.proname  andTotalFeeSt:[NSString stringWithFormat:@"%@",self.model.ordermoney] andNotifyUrl:[NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,HQJBAlipayServiceInterface] buytype:self.payType];


    }
    
    
}

#pragma mark --- 支付宝支付结果
-(void)alipayResults:(NSNotification *)infos {
    NSString *stateStr = infos.userInfo[@"strMsg"];
    if ([stateStr isEqualToString:@"支付成功"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showSuccessWithStatus:stateStr];
        [ManagerEngine SVPAfter:stateStr complete:^{
            XDPaySureViewController *psvc = [[XDPaySureViewController alloc]initWithOrderid:self.model.orderid];
            [self.navigationController pushViewController:psvc animated:YES];
        }];
    } else {

        [SVProgressHUD showErrorWithStatus:stateStr];
    }
    
    
    
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
