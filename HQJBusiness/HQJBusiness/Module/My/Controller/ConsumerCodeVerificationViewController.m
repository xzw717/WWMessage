//
//  ConsumerCodeVerificationViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/19.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ConsumerCodeVerificationViewController.h"
#import "ScanViewController.h"
#import "ManuallyAddViewController.h"
#import "VerificationOrderDetailsViewController.h"

@interface ConsumerCodeVerificationViewController ()

@end

@implementation ConsumerCodeVerificationViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.zw_title = @"消费码核销";
    NSArray *titleAry = @[@"扫一扫",
                          @"手动添加"];
    
    for (NSInteger i= 0 ; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:titleAry[i] forState:UIControlStateNormal];
        [btn setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        btn.tag = i;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 45/2;
        btn.frame = CGRectMake((WIDTH - 180)/2, i%2*(45+30)+120+kNAVHEIGHT, 180, 45);
        [btn bk_addEventHandler:^(UIButton *sender) {
            if (sender.tag == 0) {
                
                
                
                ScanViewController *SVC =[[ScanViewController alloc]init];
                [self presentViewController:SVC animated:YES completion:nil];
                
            } else {
                ManuallyAddViewController *ManuallyAddVC = [[ManuallyAddViewController alloc]init];
                [self.navigationController pushViewController:ManuallyAddVC animated:YES];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertView:) name:@"Qrcode" object:nil];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)alertView:(NSNotification *)infos {
    NSInteger  stateCode = [infos.userInfo[@"state"] integerValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (stateCode == -1) {
            [self alertMessage:@"消费码不存在"];
            
        } else if (stateCode == 1) {
            
            VerificationOrderDetailsViewController *vc = [[VerificationOrderDetailsViewController alloc]initWithOrderId:infos.userInfo[@"orderid"] consumerCode:infos.userInfo[@"salecode"]];
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        } else if (stateCode == 2) {
        
            [self alertMessage:@"已使用"];
            
        } else if (stateCode == 3) {
         
            [self alertMessage:@"已退款"];
            
        } else if (stateCode == 4) {
            
            [self alertMessage:@"已过期"];
        }

    });
    
    
}


- (void)useConsumerCode:(NSString *)code {
    NSString *url = [NSString stringWithFormat:@"%@salecode/employcode.action?memberid=%@&sale_code=%@",OrderTest_URL,MmberidStr,code];
    @weakify(self);
    [RequestEngine HQJBusinessRequestDetailsUrl:url complete:^(NSDictionary *dic) {
        @strongify(self);
        if ([dic[@"resultCode"]integerValue] == 2200) {
            [self alertMessage:@"核销成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}
- (void)alertMessage:(NSString *)mesg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:mesg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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
