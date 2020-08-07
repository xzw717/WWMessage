//
//  ChangeTradePswViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangeTradePswViewController.h"
static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

@interface ChangeTradePswViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) ZW_Label *newsPswLabel;

@property (nonatomic,strong) ZW_TextField *newsPswTextField;

@property (nonatomic,strong) UIButton *okButtn;

@property (nonatomic,strong)ZW_TextField *modelTextField;

@property (nonatomic,assign)PswType pswType;
@end

@implementation ChangeTradePswViewController

- (instancetype)initWithPasswordType:(PswType)type {
    self = [super init];
    if (self) {
        self.pswType = type;
    }
    return self;
}

-(ZW_ChangeFigureColorLabel *)mobileLabel {
    if ( _mobileLabel == nil ) {
        NSString *changeMobileStr = [[NameSingle shareInstance].mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _mobileLabel = [[ZW_ChangeFigureColorLabel alloc]initWithStr:@"" addSubView:self.view];
        _mobileLabel.zw_number =  @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"*"];
        _mobileLabel.zw_color = [ManagerEngine getColor:@"999999"];
        if (_pswType == 1) {
             _mobileLabel.text = @"手机号码：";
        }else{
             _mobileLabel.text = [NSString stringWithFormat:@"手机号码：%@",changeMobileStr];
        }
        
    }
    return _mobileLabel;
}
-(ZW_TextField *)modelTextField {
    if ( _modelTextField == nil ) {
        _modelTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入手机号" isType:isMobileType addSubView:self.view];
    }
    
    return _modelTextField;
}

-(ZW_TextField *)verificationCodeTextField {
    if ( _verificationCodeTextField == nil ) {
        _verificationCodeTextField =[[ZW_TextField alloc]initWithPlaceholder:@"请输入验证码" isType:isMobileType addSubView:self.view];
        _verificationCodeTextField.delegate = self;
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

                [self getcodeRequst];
            }];
        
//        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_getCodeButton];
    }
    
    return _getCodeButton;
}
-(ZW_Label *)newsPswLabel {
    if ( _newsPswLabel == nil ) {
        _newsPswLabel =[[ZW_Label alloc]initWithStr:@"新密码：" addSubView:self.view];
    }
    
    return _newsPswLabel;
}
-(ZW_TextField *)newsPswTextField {
    if ( _newsPswTextField == nil ) {
        _newsPswTextField =[[ZW_TextField alloc]initWithPlaceholder:@"请输入新的密码" isType:isPasswordType addSubView:self.view];
        if (_pswType != 2) {
            _newsPswTextField.keyboardType = UIKeyboardTypeASCIICapable;
        }
        _newsPswTextField.delegate = self;
    }
    
    return _newsPswTextField;
}
-(UIButton *)okButtn {
    if ( _okButtn == nil ) {
        _okButtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _okButtn.layer.masksToBounds = YES;
        _okButtn.layer.cornerRadius = 5 ;
        [_okButtn setTitle:@"提交" forState:UIControlStateNormal];
        [_okButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_okButtn];
        
    }
    
    return _okButtn;
}
//-(UIButton *)nextButton {
//    if ( _nextButton == nil ) {
//        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nextButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
//        _nextButton.layer.masksToBounds = YES;
//        _nextButton.layer.cornerRadius = 5 ;
//        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.view addSubview:_nextButton];
//
//    }
//
//    return _nextButton;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.zw_title isEqualToString:@""] || self.zw_title == nil) {
        self.zw_title = [ManagerEngine pswTitleWithType:self.pswType];
    }
 
    [self initializeTheView];
    
    [self setSignal];
    

}

-(void)initializeTheView {
    
    CGFloat mobileWidth = [ManagerEngine setTextWidthStr:self.mobileLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    if (self.pswType == SetDealPassWordType  || self.pswType == ChangeDealPassWordType ||  self.pswType == FindLoginPassWordType) {
        self.mobileLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,20 + NavigationControllerHeight).heightIs(44).widthIs(mobileWidth);
        
//        self.modelTextField.sd_layout.leftSpaceToView(self.mobileLabel,0).topSpaceToView(self.view,NavigationControllerHeight + 20 ).heightIs(44).widthIs(WIDTH - mobileWidth - kEDGE * 2);
    }else{
//        self.mobileLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,20 + NavigationControllerHeight).heightIs(17).widthIs(mobileWidth);
    }

    self.verificationCodeTextField.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.mobileLabel,20).heightIs(44).widthIs(WIDTH - 100 - kEDGE * 2 - 10);
    
    self.getCodeButton.sd_layout.leftSpaceToView(self.verificationCodeTextField,10).topEqualToView(self.verificationCodeTextField).heightIs(44).widthIs(100);
    
    //
    CGFloat pswLabelWidth  = [ManagerEngine setTextWidthStr:self.newsPswLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.newsPswLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.verificationCodeTextField,20).heightIs(44).widthIs(pswLabelWidth);
    
    self.newsPswTextField.sd_layout.leftSpaceToView(self.newsPswLabel,0).topSpaceToView(self.verificationCodeTextField,20).heightIs(44).widthIs(WIDTH - pswLabelWidth - kEDGE * 2);
    self.okButtn.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.newsPswTextField,20).heightIs(44).widthIs(WIDTH - kEDGE * 2);
    
}

-(void)getcodeRequst{
    NSString *urlStr;
    NSMutableDictionary *dict;
    if (self.pswType == SetDealPassWordType || self.pswType == ChangeDealPassWordType) {
        dict = @{@"pwdtype":@2,@"mobile":[NameSingle shareInstance].mobile}.mutableCopy;
    } else {
        dict = @{@"pwdtype":@1,@"mobile":self.modelTextField.text}.mutableCopy;
    }
    urlStr = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,HQJBGetPwdSMSInterface];
    
    HQJLog(@"---%@",urlStr);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        //            if (!isGet) {
        ////                [ManagerEngine dimssLoadView:self.nextButton andtitle:@"下一步"];
        //            }
        
        if([dic[@"code"]integerValue] != 49000) {
            self.getCodeButton.enabled = YES;
            
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        } else {
            
            
            [self.getCodeButton startCountDownWithSecond:60];
            
            [self.getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                self.getCodeButton.enabled = NO;
                self.getCodeButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
                
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [self.getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                self.getCodeButton.backgroundColor = DefaultAPPColor;
                return @"重新获取";
            }];
        }
        
    } andError:^(NSError *error) {
        
        [ManagerEngine dimssLoadView:self.okButtn andtitle:@"提交"];
        
    } ShowHUD:YES];

}



-(void)nextStep{
    NSMutableDictionary *dict;
    if (self.pswType == SetDealPassWordType || self.pswType == ChangeDealPassWordType) {
        dict = @{@"newpwd":self.newsPswTextField.text,
                       @"pwdtype":[NSNumber numberWithInteger:self.pswType],
                       @"mobile":[NameSingle shareInstance].mobile,
                       @"inputcode":self.verificationCodeTextField.text}.mutableCopy;
    }else{
        dict = @{@"newpwd":self.newsPswTextField.text,
                  @"pwdtype":[NSNumber numberWithInteger:self.pswType],
                  @"mobile":self.modelTextField.text,
                  @"inputcode":self.verificationCodeTextField.text}.mutableCopy;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,HQJBInputNewpwdActionInterface];
    @weakify(self);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                
                [ManagerEngine SVPAfter:@"修改成功" complete:^{
                    @strongify(self);
                    [self.navigationController popViewControllerAnimated:YES];
                    //                [self popViews];
                }];
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            [ManagerEngine dimssLoadView:self.okButtn andtitle:@"提交"];
        }
        
    } andError:^(NSError *error) {
        [ManagerEngine dimssLoadView:self.okButtn andtitle:@"提交"];
        
    } ShowHUD:YES];
}


-(void)setSignal {
    @weakify(self);
    if (self.pswType == FindLoginPassWordType) {
        RACSignal *mobileFieldSignal =[self.modelTextField.rac_textSignal map:^id(id value) {
            return @([ManagerEngine valiMobile:value]);
        }];
        [mobileFieldSignal subscribeNext:^(NSNumber *nextNumer) {
            @strongify(self);
            self.getCodeButton.enabled = [nextNumer boolValue];
            if ([nextNumer boolValue]) {
                self.getCodeButton.backgroundColor = DefaultAPPColor;
            } else {
                self.getCodeButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
            }
            
        }];
    }
    RACSignal *codeTexeFieldSignal =[self.verificationCodeTextField.rac_textSignal map:^id(id value) {
         @strongify(self);
        return @([self codeLength:value]);
    }];
    RACSignal *newsPswTexeFieldSignal =[self.newsPswTextField.rac_textSignal map:^id(id value) {
         @strongify(self);
        return @([self pswlength:value]);
    }];
    RACSignal *allSignal = [RACSignal combineLatest:@[codeTexeFieldSignal,newsPswTexeFieldSignal] reduce:^id(NSNumber *codeValid,NSNumber *newsPswValid){
        return @([codeValid boolValue]&&[newsPswValid boolValue]);
    }];
    [allSignal subscribeNext:^(NSNumber *nextNumer) {
         @strongify(self);
        self.okButtn.enabled = [nextNumer boolValue];
        if ([nextNumer boolValue]) {
            self.okButtn.backgroundColor = DefaultAPPColor;
        } else {
            self.okButtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        }
        
    }];
    [[self.okButtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
         @strongify(self);
        [ManagerEngine loadDateView:self.okButtn andPoint:CGPointMake(self.okButtn.mj_w / 2, self.okButtn.mj_h / 2)];
        if (self.pswType == SetDealPassWordType || self.pswType == ChangeDealPassWordType ) {
            if (self.newsPswTextField.text.length != 6) {
                [ManagerEngine dimssLoadView:self.okButtn andtitle:@"提交"];
                [SVProgressHUD showErrorWithStatus:@"交易密码要设置6位哦"];
            } else {
                [self nextStep];
            }
        } else {
            if (self.newsPswTextField.text.length < 6 || self.newsPswTextField.text.length > 12) {
                [ManagerEngine dimssLoadView:self.okButtn andtitle:@"提交"];
                [SVProgressHUD showErrorWithStatus:@"登录密码要设置6-12位哦"];
            } else {
                [self nextStep];
            }
        }
        
    }];
    
}

-(BOOL)codeLength:(NSString *)text {
    if (text.length == 6) {
        return YES;
    } else {
        return NO;
    }
    
}

- (BOOL)pswlength:(NSString *)text {
    if (self.pswType == SetDealPassWordType || self.pswType == ChangeDealPassWordType ) {
        if (text.length >0 && text.length <=6) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (text.length >0 && text.length <=12) {
            return YES;
        } else {
            return NO;
        }
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField == self.newsPswTextField) {
        if (self.pswType == SetDealPassWordType || self.pswType == ChangeDealPassWordType ) {
            if (self.newsPswTextField.text.length >=6) {
                return NO;
            } else {
                return YES;
            }
        } else {
            if (self.newsPswTextField.text.length >=12) {
                return NO;
            } else {
                NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
                NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
                return [string isEqualToString:filtered];
            }
        }
    }else{
        if (self.verificationCodeTextField.text.length >=6) {
            return NO;
        } else {
            return YES;
        }
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



@end
