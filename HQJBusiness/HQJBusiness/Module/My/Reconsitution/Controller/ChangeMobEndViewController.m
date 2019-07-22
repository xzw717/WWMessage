//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangeMobEndViewController.h"
#import "JKCountDownButton.h"


@interface ChangeMobEndViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView *mobileView;
@property (nonatomic,strong)UILabel *mobileLabel;
@property (nonatomic,strong)UITextField *mobileText;
@property (nonatomic,strong)UIView *mobileBottomView;

@property (nonatomic,strong)UIView *authCodeView;
@property (nonatomic,strong)UITextField *authCodeText;
@property (nonatomic,strong)JKCountDownButton *getAuthCodeBtn;

@property (nonatomic,strong)UIButton *submitBtn;
@end

@implementation ChangeMobEndViewController

#pragma lazy-load



- (UIView *)mobileView{
    if (_mobileView == nil) {
        _mobileView = [[UIView alloc]init];
        _mobileView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_mobileView];
    }
    return _mobileView;
}
- (UILabel *)mobileLabel{
    if ( _mobileLabel == nil ) {
        _mobileLabel = [[UILabel alloc]init];
        _mobileLabel.font = [UIFont systemFontOfSize:16];
        _mobileLabel.text = @"手机号";
        [self.mobileView addSubview:_mobileLabel];
        
    }
    
    return _mobileLabel;
}

-(UITextField *)mobileText {
    if ( _mobileText == nil ) {
        _mobileText = [[UITextField alloc]init];
        _mobileText.clearsOnBeginEditing = YES;
        _mobileText.placeholder = @"请输入新的手机号";
        _mobileText.delegate = self;
        _mobileText.font = [UIFont systemFontOfSize:16];
        //        _pswText.clearButtonMode = UITextFieldViewModeAlways;
        _mobileText.keyboardType = UIKeyboardTypeASCIICapable;
        [self.mobileView addSubview:_mobileText];
    }
    
    
    
    return _mobileText;
}

- (UIView *)mobileBottomView{
    if ( _mobileBottomView  == nil ) {
        _mobileBottomView = [[UIView alloc]init];
        _mobileBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.mobileView addSubview:_mobileBottomView];
    }
    return _mobileBottomView;
}


- (UIView *)authCodeView{
    if (_authCodeView == nil) {
        _authCodeView = [[UIView alloc]init];
        _authCodeView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_authCodeView];
    }
    return _authCodeView;
}

-(UITextField *)authCodeText {
    
    if ( _authCodeText == nil ) {
        _authCodeText = [[UITextField alloc]init];
        _authCodeText.backgroundColor = [UIColor whiteColor];
        _authCodeText.font = [UIFont systemFontOfSize:16];
        _authCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
        _authCodeText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _authCodeText.delegate = self;
        _authCodeText.clearsOnBeginEditing = YES;
        _authCodeText.clearButtonMode = UITextFieldViewModeAlways;
        _authCodeText.keyboardType = UIKeyboardTypeNumberPad;
        _authCodeText.placeholder = @"请输入短信验证码";
        [self.authCodeView addSubview:_authCodeText];
        
    }
    return _authCodeText;
}


- (JKCountDownButton *)getAuthCodeBtn{
    if ( _getAuthCodeBtn == nil ) {
        _getAuthCodeBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getAuthCodeBtn setTitleColor:[ManagerEngine getColor:@"ff4949"] forState:UIControlStateNormal];
        _getAuthCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:40/3];
        _getAuthCodeBtn.layer.masksToBounds = YES;
        _getAuthCodeBtn.layer.cornerRadius = S_XRatioH(15);
        _getAuthCodeBtn.layer.borderColor = [ManagerEngine getColor:@"ff4949"].CGColor;
        _getAuthCodeBtn.layer.borderWidth = 0.5f;
        [_getAuthCodeBtn countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            self.getAuthCodeBtn.enabled = NO;
//            [self getCodeRequst];
        }];
        
        [self.authCodeView addSubview:_getAuthCodeBtn];
    }
    return _getAuthCodeBtn;
}



- (UIButton *)submitBtn{
    if ( _submitBtn == nil ) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = S_XRatioH(145/6);
        _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [self.view addSubview:_submitBtn];
    }
    
    return _submitBtn;
}

#pragma click method

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarWhite;
    [self hideShadowLine];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更改绑定手机号";
    [self.view setBackgroundColor:[ManagerEngine getColor:@"f7f7f7"]];
    [self layoutTheSubViews];
    
    [self setSignal];
    
    // Do any additional setup after loading the view.

    
}
#pragma private method
- (void)layoutTheSubViews{

    
    self.mobileView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view,40.f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.mobileLabel.sd_layout.leftSpaceToView(self.mobileView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.mobileText.sd_layout.leftSpaceToView(self.mobileLabel, 10).rightEqualToView(self.mobileView).heightIs(S_XRatioH(130.0f/3));
    
    self.mobileBottomView.sd_layout.leftEqualToView(self.mobileLabel).bottomEqualToView(self.mobileView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.authCodeView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.mobileView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.authCodeText.sd_layout.leftSpaceToView(self.authCodeView, 70.0f/3).rightSpaceToView(self.authCodeView,S_XRatioW(55.0f/3 + 100)).widthIs(WIDTH-S_XRatioW(110.0f/3 + 100)).heightIs(S_XRatioH(130.0f/3));
    
    self.getAuthCodeBtn.sd_layout.rightSpaceToView(self.authCodeView,S_XRatioW(55.0f/3)).centerYEqualToView(self.authCodeView).heightIs(S_XRatioH(30)).widthIs(S_XRatioW(100));
    
    self.submitBtn.sd_layout.leftSpaceToView(self.view, 70.0f/3).topSpaceToView(self.authCodeView,S_XRatioH(40.0f/3)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
}

-(void)setSignal {
//    RACSignal *codeTexeFieldSignal =[self.authCodeText.rac_textSignal map:^id(id value) {
//        return @([self codeLength:value]);
//    }];
//
//    [codeTexeFieldSignal subscribeNext:^(NSNumber *nextNumer) {
//        self.submitBtn.enabled = [nextNumer boolValue];
//        if ([nextNumer boolValue]) {
//            self.submitBtn.backgroundColor = DefaultAPPColor;
//        } else {
//            self.submitBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
//        }
//
//    }];
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self nextStep];
    }];
    
}

-(void)getCodeRequst{
    NSString *urlStr;
    NSMutableDictionary *dict = @{@"pwdtype":@2,@"mobile":[NameSingle shareInstance].mobile}.mutableCopy;
    urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetPwdSMSInterface];
    HQJLog(@"---%@",urlStr);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if([dic[@"code"]integerValue] != 49000) {
            self.getAuthCodeBtn.enabled = YES;
            
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        } else {
            [self.getAuthCodeBtn startCountDownWithSecond:60];
            
            [self.getAuthCodeBtn countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                self.getAuthCodeBtn.enabled = NO;
//                self.getAuthCodeBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
                
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [self.getAuthCodeBtn countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
//                self.getAuthCodeBtn.backgroundColor = DefaultAPPColor;
                return @"重新获取";
            }];
        }
        
    } andError:^(NSError *error) {
        
        [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"确认"];
        
    } ShowHUD:YES];
    
}



-(void)nextStep{
//    NSMutableDictionary *dict = @{@"newpwd":self.pswText.text,
//                 @"pwdtype":@2,
//                 @"mobile":[NameSingle shareInstance].mobile,
//                 @"inputcode":self.authCodeText.text}.mutableCopy;
//
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBInputNewpwdActionInterface];
//
//    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
//        if ([dic[@"code"]integerValue] == 49000) {
//            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//            [ManagerEngine SVPAfter:@"修改成功" complete:^{
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }else{
//            [SVProgressHUD showSuccessWithStatus:@"修改失败"];
//            [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"确认"];
//        }
//
//    } andError:^(NSError *error) {
//        [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"确认"];
//
//    } ShowHUD:YES];
}




-(BOOL)codeLength:(NSString *)text {
    if (text.length == 6) {
        return YES;
    } else {
        return NO;
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (self.authCodeText.text.length >=6) {
        return NO;
    } else {
        return YES;
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
