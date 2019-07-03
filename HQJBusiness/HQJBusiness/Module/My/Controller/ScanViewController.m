//
//  ScanViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/19.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ScanViewController.h"
#import "ConsumerCodeViewModel.h"
#import "PaymentCodeViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import "ManuallyAddViewController.h"
@interface ScanViewController ()
@property (nonatomic, strong) PaymentCodeViewModel *viewModel;
@end

@implementation ScanViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShutDown:) name:@"ShutDownCamera" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openFlashlighe:) name:FlashLight object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(manualValidation) name:Validation object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    [self setCALScanQRCodeGetMetadataStringValue:^(NSString *str) {
        @strongify(self);
        if (self.isAddCode) {
            [self.viewModel paymentCodeAddList:str codetype:self.addcodeType complete:^(NSString *str){
                if ([str isEqualToString:@"操作成功"]) {
                    NSNotification *notification =[NSNotification notificationWithName:@"addCodeSuccess" object:nil userInfo:@{@"codeType":self.addcodeType}];
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                } else {
                    [SVProgressHUD showErrorWithStatus:str];
                }
                [self dismissViewControllerAnimated:YES completion:nil];

            }];
        } else {
            [ConsumerCodeViewModel QrCodeRequst:str andBlock:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
       

        
    }];
   

}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];;
}
-(void)QrCodeRequst:(NSString *)code {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@salecode/shopcheckcode.action?memberid=%@&sale_code=%@",HQJBBounsOrder,MmberidStr,code];
    HQJLog(@"%@",urlStr);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Qrcode" object:nil userInfo:@{@"state":dic[@"resultMsg"][@"state"]}];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
}

- (PaymentCodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PaymentCodeViewModel alloc]init];
    }
    return _viewModel;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShutDownCamera" object:nil];
}


- (void)ShutDown:(NSNotification *)messager {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)openFlashlighe:(NSNotification *)notifi {
    NSString *isOpen = notifi.userInfo[@"selected"];
    if ([isOpen isEqualToString:@"开"]) {
        [self openFlash];
    } else {
        [self closeFlash];
    }
}
- (void)manualValidation {
    [self dismissViewControllerAnimated:YES completion:^{
        !self.dismissBlock ? :self.dismissBlock();

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
