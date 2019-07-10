//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangeTradePWViewController.h"
#import "JKCountDownButton.h"

static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

@interface ChangeTradePWViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UILabel *mobileLabel;

@property (nonatomic,strong)UIView *authCodeView;
@property (nonatomic,strong)UITextField *authCodeText;
@property (nonatomic,strong)JKCountDownButton *getAuthCodeBtn;
@property (nonatomic,strong)UIView *acBottomView;


@property (nonatomic,strong)UIView *pswView;
@property (nonatomic,strong)UILabel *pswLabel;
@property (nonatomic,strong)UITextField *pswText;

@property (nonatomic,strong)UIButton *submitBtn;
@end

@implementation ChangeTradePWViewController

#pragma lazy-load

-(UILabel *)mobileLabel {
    
    if ( _mobileLabel == nil ) {
        _mobileLabel = [[UILabel alloc]init];
        _mobileLabel.font = [UIFont systemFontOfSize:16];
        NSString *text = [NameSingle shareInstance].mobile ? [NSString stringWithFormat:@"手机号码：%@",[[NameSingle shareInstance].mobile  stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]]:@"暂无手机号码";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[ManagerEngine getColor:@"909399"] range:NSMakeRange(5, text.length - 5)];
        _mobileLabel.attributedText = attributeStr;
        
        [self.view addSubview:_mobileLabel];
        
    }
    
    return _mobileLabel;
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

- (UIView *)acBottomView{
    if ( _acBottomView  == nil ) {
        _acBottomView = [[UIView alloc]init];
        _acBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.authCodeView addSubview:_acBottomView];
    }
    return _acBottomView;
}
- (UIView *)pswView{
    if (_pswView == nil) {
        _pswView = [[UIView alloc]init];
        _pswView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_pswView];
    }
    return _pswView;
}

- (UILabel *)pswLabel{
    if ( _pswLabel == nil ) {
        _pswLabel = [[UILabel alloc]init];
        _pswLabel.font = [UIFont systemFontOfSize:16];
        _pswLabel.text = @"设置密码";
        [self.pswView addSubview:_pswLabel];
        
    }
    
    return _pswLabel;
}

-(UITextField *)pswText {
    if ( _pswText == nil ) {
        _pswText = [[UITextField alloc]init];
        _pswText.clearsOnBeginEditing = YES;
        _pswText.placeholder = @"密码为6-18位数字及字母、下划线组成";
        _pswText.delegate = self;
        _pswText.font = [UIFont systemFontOfSize:16];
//        _pswText.clearButtonMode = UITextFieldViewModeAlways;
        _pswText.keyboardType = UIKeyboardTypeASCIICapable;
        [self.pswView addSubview:_pswText];
    }
    
    
    
    return _pswText;
}




- (UIButton *)submitBtn{
    if ( _submitBtn == nil ) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置交易密码";
    [self.view setBackgroundColor:[ManagerEngine getColor:@"f7f7f7"]];
    [self layoutTheSubViews];
    
    [self setSignal];
    
    // Do any additional setup after loading the view.

    
}
#pragma private method
- (void)layoutTheSubViews{

    
    self.mobileLabel.sd_layout.leftSpaceToView(self.view, 70.0f/3).topEqualToView(self.view).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH -  70.0f/3);
    
    
    self.authCodeView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.mobileLabel,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.authCodeText.sd_layout.leftSpaceToView(self.authCodeView, 70.0f/3).rightSpaceToView(self.authCodeView,S_XRatioW(55.0f/3 + 100)).widthIs(WIDTH-S_XRatioW(110.0f/3 + 100)).heightIs(S_XRatioH(130.0f/3));
    
    self.getAuthCodeBtn.sd_layout.rightSpaceToView(self.authCodeView,S_XRatioW(55.0f/3)).centerYEqualToView(self.authCodeView).heightIs(S_XRatioH(30)).widthIs(S_XRatioW(100));
    
    self.acBottomView.sd_layout.leftEqualToView(self.authCodeText).bottomEqualToView(self.authCodeView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    
    self.pswView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.authCodeView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);

    self.pswLabel.sd_layout.leftSpaceToView(self.pswView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);

    self.pswText.sd_layout.leftSpaceToView(self.pswLabel, 10).rightEqualToView(self.pswView).heightIs(S_XRatioH(130.0f/3));


    self.submitBtn.sd_layout.leftSpaceToView(self.view, 70.0f/3).topSpaceToView(self.pswView,S_XRatioH(125.0f/3)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
}

-(void)setSignal {
    RACSignal *codeTexeFieldSignal =[self.authCodeText.rac_textSignal map:^id(id value) {
        return @([self codeLength:value]);
    }];
    RACSignal *newsPswTexeFieldSignal =[self.pswText.rac_textSignal map:^id(id value) {
        return @([self pswlength:value]);
    }];
    RACSignal *allSignal = [RACSignal combineLatest:@[codeTexeFieldSignal,newsPswTexeFieldSignal] reduce:^id(NSNumber *codeValid,NSNumber *newsPswValid){
        return @([codeValid boolValue]&&[newsPswValid boolValue]);
    }];
    [allSignal subscribeNext:^(NSNumber *nextNumer) {
        self.submitBtn.enabled = [nextNumer boolValue];
        if ([nextNumer boolValue]) {
            self.submitBtn.backgroundColor = DefaultAPPColor;
        } else {
            self.submitBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        }
        
    }];
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [ManagerEngine loadDateView:self.submitBtn andPoint:CGPointMake(self.submitBtn.mj_w / 2, self.submitBtn.mj_h / 2)];
        if (self.pswText.text.length < 6 || self.pswText.text.length > 12) {
            [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"确认"];
            [SVProgressHUD showErrorWithStatus:@"交易密码要设置6-12位哦"];
        }
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
    NSMutableDictionary *dict = @{@"newpwd":self.pswText.text,
                 @"pwdtype":@2,
                 @"mobile":[NameSingle shareInstance].mobile,
                 @"inputcode":self.authCodeText.text}.mutableCopy;

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBInputNewpwdActionInterface];
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [ManagerEngine SVPAfter:@"修改成功" complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"修改失败"];
            [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"确认"];
        }
        
    } andError:^(NSError *error) {
        [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"确认"];
        
    } ShowHUD:YES];
}




-(BOOL)codeLength:(NSString *)text {
    if (text.length == 6) {
        return YES;
    } else {
        return NO;
    }
    
}

- (BOOL)pswlength:(NSString *)text {
    
    if (text.length >0 && text.length <=12) {
        return YES;
    } else {
        return NO;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField == self.pswText) {
        
            if (self.pswText.text.length >=12) {
                return NO;
            } else {
                NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
                NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
                return [string isEqualToString:filtered];
            }

    }else{
        if (self.authCodeText.text.length >=6) {
            return NO;
        } else {
            return YES;
        }
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
