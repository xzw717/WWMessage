//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "JKCountDownButton.h"
#import "HintView.h"

static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

@interface ForgetPswViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UILabel *topicLabel;


@property (nonatomic,strong)UITextField *mobileText;
@property (nonatomic,strong)UIView *unBottomView;
@property (nonatomic,strong)UITextField *authCodeText;

@property (nonatomic,strong)JKCountDownButton *getAuthCodeBtn;

@property (nonatomic,strong)UIView *acBottomView;
@property (nonatomic,strong)UITextField *pswText;
@property (nonatomic,strong)UIButton *secureBtn;
@property (nonatomic,strong)UIView *pswBottomView;

@property (nonatomic,strong)UITextField *againPswText;
@property (nonatomic,strong)UIButton *agSecureBtn;
@property (nonatomic,strong)UIView *apBottomView;

@property (nonatomic,strong)UIButton *confirmBtn;
@end

@implementation ForgetPswViewController

#pragma lazy-load

- (UILabel *)titleLabel{
    if ( _titleLabel  == nil ) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.text = @"忘记密码";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (UIButton *)backBtn{
    if ( _backBtn == nil ) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backBtn bk_addEventHandler:^(id  _Nonnull sender) {
            NSLog(@"pop success");
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}

-(UIImageView *)logoImageView {
    if ( _logoImageView  == nil ) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"logowuwumap"];
        [self.view addSubview:_logoImageView];
    }
    
    return _logoImageView;
}
- (UILabel *)topicLabel{
    if ( _topicLabel  == nil ) {
        _topicLabel = [[UILabel alloc]init];
        _topicLabel.font = [UIFont systemFontOfSize:18.0f];
        _topicLabel.text = @"【物物地图】商家入驻系统";
        _topicLabel.textAlignment = NSTextAlignmentCenter;
        _topicLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
        [self.view addSubview:_topicLabel];
    }
    
    return _topicLabel;
}

-(UITextField *)mobileText {
    
    if ( _mobileText == nil ) {
        _mobileText = [[UITextField alloc]init];
        _mobileText.font = [UIFont systemFontOfSize:16];
        _mobileText.autocorrectionType = UITextAutocorrectionTypeNo;
        _mobileText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _mobileText.delegate = self;
        _mobileText.clearsOnBeginEditing = YES;
        _mobileText.clearButtonMode = UITextFieldViewModeAlways;
        _mobileText.keyboardType = UIKeyboardTypeNumberPad;
        _mobileText.placeholder = @"请输入手机号码/用户名";
        
        [self.view addSubview:_mobileText];
        
    }
    
    
    return _mobileText;
}
- (UIView *)unBottomView{
    if ( _unBottomView  == nil ) {
        _unBottomView = [[UIView alloc]init];
        _unBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_unBottomView];
    }
    
    return _unBottomView;
}

-(UITextField *)authCodeText {
    
    if ( _authCodeText == nil ) {
        _authCodeText = [[UITextField alloc]init];
        _authCodeText.font = [UIFont systemFontOfSize:16];
        _authCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
        _authCodeText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _authCodeText.delegate = self;
        _authCodeText.clearsOnBeginEditing = YES;
        _authCodeText.clearButtonMode = UITextFieldViewModeAlways;
        _authCodeText.keyboardType = UIKeyboardTypeNumberPad;
        _authCodeText.placeholder = @"请输入验证码";
        [self.view addSubview:_authCodeText];
        
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
            [self getCodeRequst];
        }];
        
        [self.view addSubview:_getAuthCodeBtn];
    }
    return _getAuthCodeBtn;
}

- (UIView *)acBottomView{
    if ( _acBottomView  == nil ) {
        _acBottomView = [[UIView alloc]init];
        _acBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_acBottomView];
    }
    return _acBottomView;
}


-(UITextField *)pswText {
    if ( _pswText == nil ) {
        _pswText = [[UITextField alloc]init];
        _pswText.clearsOnBeginEditing = YES;
        _pswText.placeholder = @"新密码 | 请设置6-18位登录新密码";
        _pswText.delegate = self;
        _pswText.font = [UIFont systemFontOfSize:16];
//        _pswText.clearButtonMode = UITextFieldViewModeAlways;
        _pswText.keyboardType = UIKeyboardTypeASCIICapable;
        _secureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_secureBtn setImage:[UIImage imageNamed:@"Invisible"] forState:UIControlStateNormal];
        [_secureBtn setImage:[UIImage imageNamed:@"visual"] forState:UIControlStateSelected];
        [_secureBtn addTarget:self action:@selector(secureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _pswText.rightView = _secureBtn;
        _pswText.secureTextEntry = _secureBtn.selected ? NO : YES;
        _pswText.rightViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_pswText];
    }
    
    
    
    return _pswText;
}
- (UIView *)pswBottomView{
    if ( _pswBottomView  == nil ) {
        _pswBottomView = [[UIView alloc]init];
        _pswBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_pswBottomView];
    }
    
    return _pswBottomView;
}


- (UITextField *)againPswText{
    if ( _againPswText == nil ) {
        _againPswText = [[UITextField alloc]init];
        _againPswText.clearsOnBeginEditing = YES;
        _againPswText.placeholder = @"确认新密码 | 再次输入新密码";
        _againPswText.delegate = self;
        _againPswText.font = [UIFont systemFontOfSize:16];
//        _againPswText.clearButtonMode = UITextFieldViewModeAlways;
        _againPswText.keyboardType = UIKeyboardTypeASCIICapable;
        _agSecureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_agSecureBtn setImage:[UIImage imageNamed:@"Invisible"] forState:UIControlStateNormal];
        [_agSecureBtn setImage:[UIImage imageNamed:@"visual"] forState:UIControlStateSelected];
        [_agSecureBtn addTarget:self action:@selector(agSecureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _againPswText.rightView = _agSecureBtn;
        _againPswText.secureTextEntry = _agSecureBtn.selected ? NO : YES;
        _againPswText.rightViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_againPswText];
        
    }
    return _againPswText;
}
- (UIView *)apBottomView{
    if ( _apBottomView  == nil ) {
        _apBottomView = [[UIView alloc]init];
        _apBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_apBottomView];
    }
    
    return _apBottomView;
}

- (UIButton *)confirmBtn{
    if ( _confirmBtn == nil ) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = S_XRatioH(145/6);
        _confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [self.view addSubview:_confirmBtn];
    }
    
    return _confirmBtn;
}

#pragma click method

- (void)secureBtnClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    _pswText.secureTextEntry = sender.selected ? NO : YES;
}
- (void)agSecureBtnClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    _againPswText.secureTextEntry = sender.selected ? NO : YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutTheSubViews];
    
    [self setSignal];
    
    // Do any additional setup after loading the view.

    
}
#pragma private method
- (void)layoutTheSubViews{
    self.titleLabel.sd_layout.topSpaceToView(self.view,StatusBarHeight).centerXEqualToView(self.view).heightIs(44).widthIs(100.0f);
    
    self.backBtn.sd_layout.centerYEqualToView(self.titleLabel).leftSpaceToView(self.view, 50.0f/3).heightIs(30.0f).widthIs(30.0f);
    
    self.logoImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.titleLabel,S_XRatioH(170.0f/3)).heightIs(S_XRatioH(154.0f/3)).widthIs(S_XRatioW(76.0f));
    
    self.topicLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.logoImageView,S_XRatioH(50.0f)).heightIs(S_XRatioH(20.0f)).widthIs(S_XRatioW(300.0f));
    
    
    self.mobileText.sd_layout.leftSpaceToView(self.view,S_XRatioW(55.0f/3)).topSpaceToView(self.topicLabel,S_XRatioH(170.0f/3)).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.unBottomView.sd_layout.leftEqualToView(self.mobileText).topSpaceToView(self.mobileText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.authCodeText.sd_layout.leftEqualToView(self.mobileText).topEqualToView(self.unBottomView).rightSpaceToView(self.view,S_XRatioW(55.0f/3 + 100)).widthIs(WIDTH-S_XRatioW(110.0f/3 + 100)).heightIs(S_XRatioH(130.0f/3));
    self.getAuthCodeBtn.sd_layout.rightSpaceToView(self.view,S_XRatioW(55.0f/3)).topSpaceToView(self.unBottomView, S_XRatioH(20.0f/3)).heightIs(S_XRatioH(30)).widthIs(S_XRatioW(100));
    
    self.acBottomView.sd_layout.leftEqualToView(self.authCodeText).topSpaceToView(self.authCodeText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.pswText.sd_layout.leftEqualToView(self.authCodeText).topEqualToView(self.acBottomView).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.pswBottomView.sd_layout.leftEqualToView(self.mobileText).topSpaceToView(self.pswText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.againPswText.sd_layout.leftEqualToView(self.mobileText).topEqualToView(self.pswBottomView).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.apBottomView.sd_layout.leftEqualToView(self.mobileText).topSpaceToView(self.againPswText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.confirmBtn.sd_layout.leftEqualToView(self.mobileText).topSpaceToView(self.apBottomView,S_XRatioH(125.0f/3)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
}

-(void)setSignal {
    RACSignal *mobileFieldSignal =[self.mobileText.rac_textSignal map:^id(id value) {
        return @([ManagerEngine valiMobile:value]);
    }];
    [mobileFieldSignal subscribeNext:^(NSNumber *nextNumer) {
        self.getAuthCodeBtn.enabled = [nextNumer boolValue];
//        if ([nextNumer boolValue]) {
//            self.getAuthCodeBtn.backgroundColor = DefaultAPPColor;
//        } else {
//            self.getAuthCodeBtn.backgroundColor = [ManagerEngine getColor:@"ff4949"];
//        }
        
    }];
    
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
        self.confirmBtn.enabled = [nextNumer boolValue];
        if ([nextNumer boolValue]) {
            self.confirmBtn.backgroundColor = DefaultAPPColor;
        } else {
            self.confirmBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        }
        
    }];
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [ManagerEngine loadDateView:self.confirmBtn andPoint:CGPointMake(self.confirmBtn.mj_w / 2, self.confirmBtn.mj_h / 2)];
        if (self.pswText.text.length < 6 || self.pswText.text.length > 12) {
            [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
            [SVProgressHUD showErrorWithStatus:@"登录密码要设置6-12位哦"];
        } else {
            if ([self.pswText.text isEqualToString:self.againPswText.text]) {
                [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一样"];
            }else{
                [self nextStep];
            }
        }
        
        
    }];
    
}

-(void)getCodeRequst{
    NSString *urlStr;
    NSMutableDictionary *dict = @{@"pwdtype":@1,@"mobile":self.mobileText.text}.mutableCopy;
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
        
        [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
        
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
            [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
        }
        
    } andError:^(NSError *error) {
        [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
        
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
