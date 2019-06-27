//
//  LoginViewController.m
//  HQJFacilitator
//
//  Created by mymac on 16/9/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "LoginViewController.h"
#import "ZWTabBarViewController.h"
#import "MyViewController.h"
#import "ChangeTradePswViewController.h"
#import "TabbarManager.h"
#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
#import "HintView.h"
#import "RegisterViewController.h"
#import "ForgetPswViewController.h"
#import "JKCountDownButton.h"

static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

@interface LoginViewController ()<UITextFieldDelegate>
{
    BOOL isNetWork;
    UIButton *secureBtn;
    
}
@property (nonatomic,assign)BOOL isAuthCode;

@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *registerBtn;

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UIButton *pswBtn;
@property (nonatomic,strong)UIView *verticalView;
@property (nonatomic,strong)UIButton *authCodeBtn;

@property (nonatomic,strong)UITextField *userNameText;
@property (nonatomic,strong)UIView *unBottomView;
@property (nonatomic,strong)UITextField *PswText;
@property (nonatomic,strong)UIView *pswBottomView;
@property (nonatomic,strong)JKCountDownButton *getAuthCodeBtn;


@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UIButton *forgetPswBtn;
@property (nonatomic,strong)UIButton *sendAuthCodeBtn;

@property (nonatomic,strong)UILabel *thirdPartyLabel;
@property (nonatomic,strong)UIButton *weixinBtn;
@property (nonatomic,strong)UIButton *qqBtn;
@property (nonatomic,strong)UIButton *weiboBtn;

@property (nonatomic,strong)HintView *hintView;

@property (nonatomic,strong)MyViewController *MVC;
@property (nonatomic,strong)UIActivityIndicatorView *testActivityIndicator;

@end

@implementation LoginViewController

#pragma lazy-load

- (UILabel *)titleLabel{
    if ( _titleLabel  == nil ) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.text = @"登录";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (UIButton *)registerBtn{
    if ( _registerBtn == nil ) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[ManagerEngine getColor:@"ff494b"] forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_registerBtn bk_addEventHandler:^(id  _Nonnull sender) {
            RegisterViewController *registerVC = [[RegisterViewController alloc]init];
            [self.navigationController pushViewController:registerVC animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_registerBtn];
    }
    return _registerBtn;
}

-(UIImageView *)headerImageView {
    if ( _headerImageView  == nil ) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.image = [UIImage imageNamed:@"logowuwumap"];
        [self.view addSubview:_headerImageView];
    }
    
    return _headerImageView;
}
- (UIButton *)pswBtn{
    if ( _pswBtn == nil ) {
        _pswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pswBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        [_pswBtn setTitleColor:[ManagerEngine getColor:@"ff494b"] forState:UIControlStateNormal];
        _pswBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _pswBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _pswBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _pswBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_pswBtn bk_addEventHandler:^(id  _Nonnull sender) {
            [self changeLoginType:NO];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_pswBtn];
    }
    return _pswBtn;
}

- (UIView *)verticalView{
    if ( _verticalView  == nil ) {
        _verticalView = [[UIView alloc]init];
        _verticalView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_verticalView];
    }
    
    return _verticalView;
}

- (UIButton *)authCodeBtn{
    if ( _authCodeBtn == nil ) {
        _authCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_authCodeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        [_authCodeBtn setTitleColor:[ManagerEngine getColor:@"20a0ff"] forState:UIControlStateNormal];
        _authCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _authCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _authCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_authCodeBtn bk_addEventHandler:^(id  _Nonnull sender) {
            [self changeLoginType:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_authCodeBtn];
    }
    return _authCodeBtn;
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


-(UITextField *)userNameText {
    
    if ( _userNameText == nil ) {
        _userNameText = [[UITextField alloc]init];
        _userNameText.font = [UIFont systemFontOfSize:16];
        _userNameText.autocorrectionType = UITextAutocorrectionTypeNo;
        _userNameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userNameText.delegate = self;
        _userNameText.clearsOnBeginEditing = YES;
        _userNameText.clearButtonMode = UITextFieldViewModeAlways;
        _userNameText.keyboardType = UIKeyboardTypeASCIICapable;
        _userNameText.placeholder = @"请输入手机号码/用户名";

        [self.view addSubview:_userNameText];
        
    }
    
    
    return _userNameText;
}
- (UIView *)unBottomView{
    if ( _unBottomView  == nil ) {
        _unBottomView = [[UIView alloc]init];
        _unBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_unBottomView];
    }
    
    return _unBottomView;
}
-(UITextField *)PswText {
    if ( _PswText == nil ) {
        _PswText = [[UITextField alloc]init];
        _PswText.clearsOnBeginEditing = YES;
        _PswText.placeholder = @"请输入登录密码";
        _PswText.delegate = self;
        _PswText.font = [UIFont systemFontOfSize:16];
        _PswText.clearButtonMode = UITextFieldViewModeAlways;
        _PswText.keyboardType = UIKeyboardTypeASCIICapable;
        secureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [secureBtn setImage:[UIImage imageNamed:@"Invisible"] forState:UIControlStateNormal];
        [secureBtn setImage:[UIImage imageNamed:@"visual"] forState:UIControlStateSelected];
        [secureBtn addTarget:self action:@selector(secureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _PswText.rightView = secureBtn;
        _PswText.secureTextEntry = secureBtn.selected ? NO : YES;
        _PswText.rightViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_PswText];
    }
    
    
    
    return _PswText;
}
- (UIView *)pswBottomView{
    if ( _pswBottomView  == nil ) {
        _pswBottomView = [[UIView alloc]init];
        _pswBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_pswBottomView];
    }
    
    return _pswBottomView;
}

-(UIButton *)loginBtn {
    if ( _loginBtn == nil ) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = S_XRatioH(145/6);
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [self.view addSubview:_loginBtn];
    }

    return _loginBtn;
}


-(UIButton *)forgetPswBtn {
    if ( _forgetPswBtn == nil ) {
        _forgetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_forgetPswBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        
        [_forgetPswBtn setTitleColor:[ManagerEngine getColor:@"20a0ff"] forState:UIControlStateNormal];
        _forgetPswBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_forgetPswBtn bk_addEventHandler:^(id  _Nonnull sender) {
//            ChangeTradePswViewController *CTVC = [[ChangeTradePswViewController alloc]init];
//            CTVC.pswType = 1;
//            [self.navigationController pushViewController:CTVC animated:YES];
            ForgetPswViewController *fpVC = [[ForgetPswViewController alloc]init];
            [self.navigationController pushViewController:fpVC animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_forgetPswBtn];
    }
    
    
    return _forgetPswBtn;
}

- (UILabel *)thirdPartyLabel{
    if ( _thirdPartyLabel  == nil ) {
        _thirdPartyLabel = [[UILabel alloc]init];
        _thirdPartyLabel.font = [UIFont systemFontOfSize:16.0f];
        _thirdPartyLabel.text = @"使用第三方账号登录";
        _thirdPartyLabel.textAlignment = NSTextAlignmentCenter;
        _thirdPartyLabel.textColor = [ManagerEngine getColor:@"bfbfbf"];
        [self.view addSubview:_thirdPartyLabel];
    }
    
    return _thirdPartyLabel;
}

- (UIButton *)weixinBtn{
    if ( _weixinBtn == nil ) {
        _weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weixinBtn setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
        [self.view addSubview:_weixinBtn];
    }
    
    return _weixinBtn;
}
- (UIButton *)qqBtn{
    if ( _qqBtn == nil ) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        [self.view addSubview:_qqBtn];
    }
    
    return _qqBtn;
}
- (UIButton *)weiboBtn{
    if ( _weiboBtn == nil ) {
        _weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiboBtn setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
        [self.view addSubview:_weiboBtn];
    }
    
    return _weiboBtn;
}

-(UIActivityIndicatorView *)testActivityIndicator {
    
    if ( _testActivityIndicator == nil ) {
        _testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _testActivityIndicator.center = self.loginBtn.center;//只能设置中心，不能设置大小
        //        [testActivityIndicator setFrame = CGRectMack(100, 100, 100, 100)];//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
        _testActivityIndicator.color = [UIColor whiteColor]; // 改变圈圈的颜色； iOS5引入
        //        [_testActivityIndicator stopAnimating]; // 结束旋转
        [_testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
        
    }
    
    return _testActivityIndicator;
}

- (HintView *)hintView{
    if (_hintView == nil) {
        _hintView = [[HintView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) withTopic:@"账号或密码多次错误，试试验证码登录吧。" andSureTitle:@"验证码登录" cancelTitle:@"下次再说"];
        [_hintView.sureButton bk_addEventHandler:^(id  _Nonnull sender) {
            [_hintView dismssView];
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _hintView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self viewTheContent];
    
    [self signalDeal];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dianji:) name:kNetworkStatus object:nil];
    [ManagerEngine networkStatus];
    
  
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}




-(void)shutDownTheFirstResponse {
    [self.userNameText resignFirstResponder];
    [self.PswText resignFirstResponder];
}
- (void)secureBtnClicked:(UIButton *)sender{
    [[UIApplication sharedApplication].keyWindow addSubview:self.hintView];
//    sender.selected = !sender.selected;
//    _PswText.secureTextEntry = sender.selected ? NO : YES;
}
- (void)changeLoginType:(BOOL)isAuthCode{
    if (isAuthCode) {
        secureBtn.hidden = YES;
        self.getAuthCodeBtn.hidden = NO;
        [_authCodeBtn setTitleColor:[ManagerEngine getColor:@"ff494b"] forState:UIControlStateNormal];
        [_pswBtn setTitleColor:[ManagerEngine getColor:@"20a0ff"] forState:UIControlStateNormal];
        _authCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _pswBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _PswText.sd_layout.leftEqualToView(self.userNameText).topEqualToView(self.unBottomView).rightSpaceToView(self.view,S_XRatioW(55.0f/3 + 100)).widthIs(WIDTH-S_XRatioW(110.0f/3 + 100)).heightIs(S_XRatioH(130.0f/3));
        self.getAuthCodeBtn.sd_layout.rightSpaceToView(self.view,S_XRatioW(55.0f/3)).topSpaceToView(self.unBottomView, S_XRatioH(20.0f/3)).heightIs(S_XRatioH(30)).widthIs(S_XRatioW(100));
         _PswText.placeholder = @"请输入验证码";
    }else{
        self.getAuthCodeBtn.hidden = YES;
        [_authCodeBtn setTitleColor:[ManagerEngine getColor:@"20a0ff"] forState:UIControlStateNormal];
        [_pswBtn setTitleColor:[ManagerEngine getColor:@"ff494b"] forState:UIControlStateNormal];
        _pswBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _authCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        self.getAuthCodeBtn.sd_layout.heightIs(0).widthIs(0);
        _PswText.sd_layout.leftSpaceToView(self.view, S_XRatioW(55.0f/3)).topEqualToView(self.unBottomView).rightSpaceToView(self.view,S_XRatioW(55.0f/3)).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
        secureBtn.hidden = NO;
        _PswText.placeholder = @"请输入登录密码";
    }
    

}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

-(void)viewTheContent {
    
    self.titleLabel.sd_layout.topSpaceToView(self.view,StatusBarHeight).centerXEqualToView(self.view).heightIs(44).widthIs(100.0f);
    self.registerBtn.sd_layout.topSpaceToView(self.view,StatusBarHeight).rightSpaceToView(self.view, 20).heightIs(44).widthIs(50);
    
    self.headerImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.titleLabel,S_XRatioH(170.0f/3)).heightIs(S_XRatioH(154.0f/3)).widthIs(S_XRatioW(76.0f));
    
    self.verticalView.sd_layout.leftSpaceToView(self.view,WIDTH/2).topSpaceToView(self.headerImageView,S_XRatioH(75.0f)).heightIs(S_XRatioH(20.0f)).widthIs(0.5f);
    
    self.pswBtn.sd_layout.rightSpaceToView(self.verticalView,S_XRatioW(40.0f/3)).topSpaceToView(self.headerImageView,S_XRatioH(75.0f)).heightIs(S_XRatioH(20.0f)).widthIs(WIDTH/2-15);
    
    self.authCodeBtn.sd_layout.leftSpaceToView(self.verticalView,S_XRatioW(40.0f/3)).topSpaceToView(self.headerImageView,S_XRatioH(75.0f)).heightIs(S_XRatioH(20.0f)).widthIs(WIDTH/2-15);
    
    self.userNameText.sd_layout.leftSpaceToView(self.view,S_XRatioW(55.0f/3)).topSpaceToView(self.authCodeBtn,S_XRatioH(56.0f)).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    self.unBottomView.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.userNameText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    self.PswText.sd_layout.leftEqualToView(self.userNameText).topEqualToView(self.unBottomView).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.pswBottomView.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.PswText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.loginBtn.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.PswText,S_XRatioH(125.0f/3)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.forgetPswBtn.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.loginBtn,S_XRatioH(20.0f)).heightIs(S_XRatioH(20.0f)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    
    self.qqBtn.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view,S_XRatioH(200.0f/3)).heightIs(35.0f).widthIs(35.0f);
    
    self.weixinBtn.sd_layout.rightSpaceToView(self.qqBtn, 130.0f/3).bottomEqualToView(self.qqBtn).heightIs(35.0f).widthIs(35.0f);
    
    self.weiboBtn.sd_layout.leftSpaceToView(self.qqBtn, 130.0f/3).bottomEqualToView(self.qqBtn).heightIs(35.0f).widthIs(35.0f);
    
    self.thirdPartyLabel.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.qqBtn,S_XRatioH(30.0f)).heightIs(S_XRatioH(20.0f)).widthIs(WIDTH-S_XRatioW(100.0f));
    
    [self.loginBtn addSubview:self.testActivityIndicator];

    
    
}

-(void)signalDeal {
    @weakify(self);
    RACSignal *userNameSignal = [self.userNameText.rac_textSignal map:^id(NSString *value) {
       @strongify(self);
        return @([self userString:value]);
    }];
    RACSignal *pswSignal = [self.PswText.rac_textSignal map:^id(NSString *value) {
        @strongify(self);

        return @([self pswString:value]);
    }];
    RACSignal *CombinedSignal = [RACSignal combineLatest:@[userNameSignal,pswSignal] reduce:^id (NSNumber *user,NSNumber *psw){

        return @([user boolValue]&&[psw boolValue]);
    }];
    [CombinedSignal subscribeNext:^(NSNumber *combined) {
        @strongify(self);

        self.loginBtn.enabled = [combined boolValue];
        if ([combined boolValue]) {
            self.loginBtn.backgroundColor = [ManagerEngine getColor:@"18abf5"];

        } else {
            self.loginBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];

            
        }
     
    }];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);

        [self.testActivityIndicator startAnimating];
        [self.loginBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self LoginRequst];
        
        [self shutDownTheFirstResponse];
        
    }];
}

#pragma mark --
#pragma mark ---UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if (textField == self.userNameText) {
        if ([string isEqualToString:@"\n"])  //按回车可以改变
        {
            return YES;
        }
        return [self userString:string];
    } else {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];

    }
  
}





-(BOOL)userString:(NSString *)text {
#pragma mark --
#pragma mark ---限制输入内容
    if (![text isEqualToString:@""])
        {
            
            NSString * number = @"^[A-Za-z0-9\u4E00\u9FA5]+$";
            
            
            NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
            
            if ([numberPre evaluateWithObject:text] == NO)
            {
                [self customAlert:@"不能输入特殊字符"];

                
                return NO;
                
            }
            else
            {
                return YES;
                
            }
        }
    if ([_userNameText.text isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}
-(BOOL)pswString:(NSString *)text {
    if (text.length>=6&&text.length<=15) {
        return YES;
    }
    
    return NO;
}

-(void)getCodeRequst{
    NSString *urlStr;
    NSMutableDictionary *dict = @{@"pwdtype":@1,@"mobile":self.userNameText.text}.mutableCopy;
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
        
        [ManagerEngine dimssLoadView:self.loginBtn andtitle:@"确认"];
        
    } ShowHUD:YES];
    
}
#pragma mark --
#pragma mark ---请求
-(void)LoginRequst {

//    HQJLog(@"网络状态:%@",[ManagerEngine networkStatus])
    if (isNetWork == YES) {
//        NSMutableDictionary *dict;
//        NSString *urlText;
//        if ([ManagerEngine valiMobile:self.userNameText.text]) {
//            urlText = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBLoginCheckByMobileInterface];
//            dict = @{@"mobile":self.userNameText.text,@"password":self.PswText.text,@"membertype":@2}.mutableCopy;
//        }else{
//            urlText = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBLoginCheckInterface];
//            dict = @{@"username":self.userNameText.text,@"password":self.PswText.text,@"membertype":@2}.mutableCopy;
//        }
        NSMutableDictionary *dict = @{@"username":self.userNameText.text,@"password":self.PswText.text,@"membertype":@2}.mutableCopy;
        NSString *urlText = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBLoginCheckInterface];
        NSString *codeingUrl =  [urlText stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:codeingUrl parameters:dict complete:^(NSDictionary *dic) {

        if ([dic[@"code"]integerValue] != 49000) {
            
            [self.testActivityIndicator stopAnimating];
            [SVProgressHUD showErrorWithStatus:@"用户名或者密码错误"];
            [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
            
        } else {
            
            NSString *loginnameStr = [NSString stringWithFormat:@"%@",dic[@"result"][@"loginname"]];
            NSMutableDictionary *dic1;
            
            if (![loginnameStr isEqualToString:@"<null>"]) {
                dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        dic[@"result"][@"loginname"],@"loginname",
                        dic[@"result"][@"memberid"],@"memberid",
                        dic[@"result"][@"typecname"],@"typecname",
                        dic[@"result"][@"typeename"],@"typeename",dic[@"result"][@"hashCode"],@"hashCode",nil];
                
            } else {
                
                dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        dic[@"result"][@"memberid"],@"memberid",
                        dic[@"result"][@"typecname"],@"typecname",
                        dic[@"result"][@"typeename"],@"typeename",dic[@"result"][@"hashCode"],@"hashCode",nil];
            }
            
            [FileEngine filePathNameCreateandNameMutablefilePatch:fileLoginStyle Dictionary:dic1];
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeBonus" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
            
            
            // 初始化 tabbar
//            [[TabbarManager shareInstance]setTabbar];
            AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [UIView transitionWithView:delegate.window
                              duration:0.5
                               options: UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                delegate.window.rootViewController = [ZWTabBarViewController  new];
                            }
                            completion:nil];
            [UIView animateWithDuration:5 animations:^{
                
                [self.testActivityIndicator stopAnimating];
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:5 animations:^{
                    
                    [self.loginBtn setTitle:@"登录成功" forState:UIControlStateNormal];
                    
                    [JPUSHService setAlias:MmberidStr completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                        
                    } seq:1];
                    [JPUSHService findNotification:nil];
                } completion:^(BOOL finished) {
                    for (UIView *view in self.view.subviews) {
                        view.alpha = 0;
                        
                        [view removeFromSuperview];
                    }
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }];
                
                
            }];
            
            
        }
        
        //        HQJLog(@"地址:%@",NSHomeDirectory());
        
        
    } andError:^(NSError *error) {
        [self.testActivityIndicator stopAnimating];
        
        [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    } ShowHUD:YES];
        
        
    } else {
        [self.testActivityIndicator stopAnimating];
        
        [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        
        HQJLog(@"没有网了");
        
    }
}
-(void)dianji:(NSNotification *)infof {
    if ([infof.userInfo[@"IAmaNetwork"] isEqualToString:kNoInternet]) {
        
        isNetWork = NO;
    } else {
        
        
        isNetWork = YES;
    }
    
    
}
-(void)customAlert:(NSString *)str {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
