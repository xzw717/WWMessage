//
//  ChangeTradePswViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangeTradePswViewController.h"

@interface ChangeTradePswViewController ()






@end

@implementation ChangeTradePswViewController

-(ZW_ChangeFigureColorLabel *)mobileLabel {
    if ( _mobileLabel == nil ) {
        NSString *changeMobileStr = [[NameSingle shareInstance].mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _mobileLabel = [[ZW_ChangeFigureColorLabel alloc]initWithStr:@"" addSubView:self.view];
        _mobileLabel.zw_number =  @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"*"];
        _mobileLabel.zw_color = [ManagerEngine getColor:@"999999"];
        _mobileLabel.text = [NSString stringWithFormat:@"手机号码：%@",changeMobileStr];
        
    }
    return _mobileLabel;
}


-(ZW_TextField *)verificationCodeTextField {
    if ( _verificationCodeTextField == nil ) {
        _verificationCodeTextField =[[ZW_TextField alloc]initWithPlaceholder:@"请输入验证码" isType:isMobileType addSubView:self.view];
    }
    
    return _verificationCodeTextField;
}

- (JKCountDownButton *)getCodeButton {
    if ( _getCodeButton == nil ) {
        _getCodeButton =[JKCountDownButton buttonWithType: UIButtonTypeCustom];
        _getCodeButton.backgroundColor = DefaultAPPColor;
        _getCodeButton.layer.masksToBounds = YES;
        _getCodeButton.layer.cornerRadius = 5 ;
        _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_getCodeButton bk_addEventHandler:^(id  _Nonnull sender) {
        
            [_getCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
                self.getCodeButton.enabled = NO;

                [self getcodeRequst:YES];

                
            }];
        
//        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_getCodeButton];
    }
    
    return _getCodeButton;
}

-(UIButton *)nextButton {
    if ( _nextButton == nil ) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 5 ;
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_nextButton];

    }
    
    return _nextButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"修改交易密码";
    
    [self initializeTheView];
    
    [self setSignal];
    

}

-(void)initializeTheView {
    
    CGFloat mobileWidth = [ManagerEngine setTextWidthStr:self.mobileLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.mobileLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,20 + kNAVHEIGHT).heightIs(17).widthIs(mobileWidth);
    
    self.verificationCodeTextField.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.mobileLabel,20).heightIs(44).widthIs(WIDTH - 100 - kEDGE * 2 - 10);
    
    self.getCodeButton.sd_layout.leftSpaceToView(self.verificationCodeTextField,10).topEqualToView(self.verificationCodeTextField).heightIs(44).widthIs(100);
    
    self.nextButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.verificationCodeTextField,30).heightIs(44).widthIs(WIDTH - kEDGE * 2);
    
    
    
}

-(void)getcodeRequst:(BOOL)isGet {
    
    NSString *urlStr ;
    
    if (isGet) {
        urlStr = [NSString stringWithFormat:@"%@AppSel2/getPwdSMS/mobile/%@/pwdtype/tradepwd",AppSel_URL,[NameSingle shareInstance].mobile];
    } else {
        urlStr = [NSString stringWithFormat:@"%@AppSel2/inputSMSAction/inputCode/%@/mobile/%@",AppSel_URL,self.verificationCodeTextField.text,[NameSingle shareInstance].mobile];
    }
//    HQJLog(@"---%@",urlStr);
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {

        if (!isGet) {
            [ManagerEngine dimssLoadView:self.nextButton andtitle:@"下一步"];
        }
        
        if([dic[@"error"]integerValue] != 0) {
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
        } else {
            if (isGet == NO) {
                
                NewTradePasswordViewController *NewPswVC = [[NewTradePasswordViewController alloc]init];
                NewPswVC.viewControllerStr = @"SetViewController";
                NewPswVC.pswType = @"tradepwd";
                NewPswVC.mobileStr = [NameSingle shareInstance].mobile;
                [self.navigationController pushViewController:NewPswVC animated:YES];
            } else {
                
                [self.getCodeButton startCountDownWithSecond:60];
                
                [self.getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                    NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                    return title;
                }];
                [self.getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                    countDownButton.enabled = YES;
                    return @"重新获取";
                    
                }];

            }
        }
        
    } andError:^(NSError *error) {
        if (!isGet) {
            [ManagerEngine dimssLoadView:self.nextButton andtitle:@"下一步"];

        }
        
    } ShowHUD:NO];
    
    
}

-(void)setSignal {
    RACSignal *codeTexeFieldSignal =[self.verificationCodeTextField.rac_textSignal map:^id(id value) {
        return @([self codeLength:value]);
    }];
    [codeTexeFieldSignal subscribeNext:^(NSNumber *nextNumer) {
        self.nextButton.enabled = [nextNumer boolValue];
        if ([nextNumer boolValue]) {
            self.nextButton.backgroundColor = DefaultAPPColor;
        } else {
             self.nextButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        }
        
    }];
    [[self.nextButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [ManagerEngine loadDateView:self.nextButton andPoint:CGPointMake(self.nextButton.mj_w / 2, self.nextButton.mj_h / 2)];

        [self getcodeRequst:NO];
    }];
    
    
}

-(BOOL)codeLength:(NSString *)text {
    if (text.length == 4) {
        return YES;
    } else {
        return NO;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.verificationCodeTextField resignFirstResponder];
    
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
