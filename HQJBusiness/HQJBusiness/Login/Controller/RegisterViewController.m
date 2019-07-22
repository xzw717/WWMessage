//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "CreateShopViewController.h"
#import "ProtocolViewController.h"

#import "JKCountDownButton.h"
#import "HintView.h"
@interface RegisterViewController ()<UITextFieldDelegate>


@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *loginBtn;

@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UILabel *topicLabel;


@property (nonatomic,strong)UITextField *userNameText;
@property (nonatomic,strong)UIView *unBottomView;
@property (nonatomic,strong)UITextField *authCodeText;
@property (nonatomic,strong)JKCountDownButton *getAuthCodeBtn;
@property (nonatomic,strong)UIView *acBottomView;
@property (nonatomic,strong)UITextField *pswText;
@property (nonatomic,strong)UIButton *secureBtn;
@property (nonatomic,strong)UIView *pswBottomView;
@property (nonatomic,strong)UITextField *inviteCodeText;
@property (nonatomic,strong)UIView *icBottomView;

@property (nonatomic,strong)UIButton *inviteCodeBtn;

@property (nonatomic,strong)UIView *accessoryView;
@property (nonatomic,strong)UIButton *accessoryBtn;
@property (nonatomic,strong)UIButton *protocolBtn;


@property (nonatomic,strong)UIButton *registerBtn;

@property (nonatomic,strong)HintView *hintView;
@end

@implementation RegisterViewController

#pragma lazy-load

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

- (UILabel *)titleLabel{
    if ( _titleLabel  == nil ) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.text = @"注册";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (UIButton *)loginBtn{
    if ( _loginBtn == nil ) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[ManagerEngine getColor:@"ff494b"] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        [_loginBtn addTarget:self action:@selector(popMethod) forControlEvents:UIControlEventTouchUpInside];

        [_loginBtn bk_addEventHandler:^(id  _Nonnull sender) {
            NSLog(@"pop success");
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
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

-(UITextField *)authCodeText {
    
    if ( _authCodeText == nil ) {
        _authCodeText = [[UITextField alloc]init];
        _authCodeText.font = [UIFont systemFontOfSize:16];
        _authCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
        _authCodeText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _authCodeText.delegate = self;
        _authCodeText.clearsOnBeginEditing = YES;
        _authCodeText.clearButtonMode = UITextFieldViewModeAlways;
        _authCodeText.keyboardType = UIKeyboardTypeASCIICapable;
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
//        [_getAuthCodeBtn bk_addEventHandler:^(id  _Nonnull sender) {
//            CreateShopViewController *csvc = [[CreateShopViewController alloc]init];
//            [self.navigationController pushViewController:csvc animated:YES];
//        } forControlEvents:UIControlEventTouchUpInside];
        
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
        _pswText.placeholder = @"登录密码 | 请设置登录密码";
        _pswText.delegate = self;
        _pswText.font = [UIFont systemFontOfSize:16];
        _pswText.clearButtonMode = UITextFieldViewModeAlways;
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


- (UITextField *)inviteCodeText{
    if ( _inviteCodeText == nil ) {
        _inviteCodeText = [[UITextField alloc]init];
        _inviteCodeText.font = [UIFont systemFontOfSize:16];
        _inviteCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
        _inviteCodeText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _inviteCodeText.delegate = self;
        _inviteCodeText.clearsOnBeginEditing = YES;
        _inviteCodeText.clearButtonMode = UITextFieldViewModeAlways;
        _inviteCodeText.keyboardType = UIKeyboardTypeASCIICapable;
        _inviteCodeText.placeholder = @"邀请码 | 123456（自动获取）";
        [self.view addSubview:_inviteCodeText];
        
    }
    return _inviteCodeText;
}

- (UIButton *)inviteCodeBtn{
    if ( _inviteCodeBtn == nil ) {
        _inviteCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _inviteCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_inviteCodeBtn setTitle:@"没有邀请码？点击这里？" forState:UIControlStateNormal];
        [_inviteCodeBtn setTitleColor:[ManagerEngine getColor:@"20a0ff"] forState:UIControlStateNormal];
        _inviteCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:_inviteCodeBtn];
    }
    return _inviteCodeBtn;
}
- (UIView *)icBottomView{
    if ( _icBottomView  == nil ) {
        _icBottomView = [[UIView alloc]init];
        _icBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_icBottomView];
    }
    
    return _icBottomView;
}

- (UIView *)accessoryView{
    if ( _accessoryView == nil ) {
        _accessoryView = [[UIView alloc]init];
        _accessoryView.userInteractionEnabled = YES;
        _accessoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _accessoryBtn.frame = CGRectMake(0, 0, 20, 20);
        [_accessoryBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        [_accessoryBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        _accessoryBtn.userInteractionEnabled = NO;
        
        UILabel *accessoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 100, 20)];
        accessoryLabel.text = @"我已阅读并同意";
        accessoryLabel.textColor = [ManagerEngine getColor:@"909399"];
        accessoryLabel.font = [UIFont systemFontOfSize:12.0f];
        [_accessoryView addSubview:accessoryLabel];
        [_accessoryView addSubview:_accessoryBtn];
        
        UITapGestureRecognizer *accessoryTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accessoryClick)];
        [_accessoryView addGestureRecognizer:accessoryTap];
        
        [self.view addSubview:_accessoryView];
    }
    return _accessoryView;
    
    
}

- (UIButton *)protocolBtn{
    if ( _protocolBtn == nil ) {
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_protocolBtn setTitleColor:[ManagerEngine getColor:@"ff4949"] forState:UIControlStateNormal];
        _protocolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_protocolBtn setTitle:@"《【物物地图】商家入驻协议》" forState:UIControlStateNormal];
        [_protocolBtn bk_addEventHandler:^(id  _Nonnull sender) {
            ProtocolViewController *pvc = [[ProtocolViewController alloc]init];
            pvc.webUrlStr = @"http://47.98.45.218/shopH5/register/#/storemessage?shopid=0000";
            [self.navigationController pushViewController:pvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_protocolBtn];
    }
    return _protocolBtn;
}



- (UIButton *)registerBtn{
    if ( _registerBtn == nil ) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"立即入驻" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = DefaultAPPColor;
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = S_XRatioH(145/6);
        _registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [_registerBtn bk_addEventHandler:^(id  _Nonnull sender) {
            ProtocolViewController *pvc = [[ProtocolViewController alloc]init];
            pvc.webUrlStr = @"http://47.98.45.218/shopH5/register/#/newstore?mobile=13855555555";
            [self.navigationController pushViewController:pvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registerBtn];
    }
    
    return _registerBtn;
}

- (HintView *)hintView{
    if (_hintView == nil) {
        _hintView = [[HintView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) withTopic:@"请联系客服：400-0591-081" andSureTitle:@"呼叫" cancelTitle:@"取消"];
        [_hintView.sureButton bk_addEventHandler:^(id  _Nonnull sender) {
            //调用系统方法拨号
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://400-0591-081"]]];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _hintView;
}

#pragma click method
- (void)popMethod{
    NSLog(@"pop");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)accessoryClick{
    _accessoryBtn.selected = !_accessoryBtn.isSelected;
}
- (void)secureBtnClicked:(UIButton *)sender{
    [[UIApplication sharedApplication].keyWindow addSubview:self.hintView];
    //    sender.selected = !sender.selected;
    //    _pswText.secureTextEntry = sender.selected ? NO : YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutTheSubViews];
    
    // Do any additional setup after loading the view.

    
}
#pragma private method
- (void)layoutTheSubViews{
    self.titleLabel.sd_layout.topSpaceToView(self.view,StatusBarHeight).centerXEqualToView(self.view).heightIs(44).widthIs(100.0f);
    
    self.backBtn.sd_layout.centerYEqualToView(self.titleLabel).leftSpaceToView(self.view, 50.0f/3).heightIs(30.0f).widthIs(30.0f);
    
    self.loginBtn.sd_layout.topSpaceToView(self.view,StatusBarHeight).rightSpaceToView(self.view, 20).heightIs(44).widthIs(50);
    
    self.logoImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.titleLabel,S_XRatioH(170.0f/3)).heightIs(S_XRatioH(154.0f/3)).widthIs(S_XRatioW(76.0f));
    
    self.topicLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.logoImageView,S_XRatioH(50.0f)).heightIs(S_XRatioH(20.0f)).widthIs(S_XRatioW(300.0f));
    
    
    self.userNameText.sd_layout.leftSpaceToView(self.view,S_XRatioW(55.0f/3)).topSpaceToView(self.topicLabel,S_XRatioH(170.0f/3)).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.unBottomView.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.userNameText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.authCodeText.sd_layout.leftEqualToView(self.userNameText).topEqualToView(self.unBottomView).rightSpaceToView(self.view,S_XRatioW(55.0f/3 + 100)).widthIs(WIDTH-S_XRatioW(110.0f/3 + 100)).heightIs(S_XRatioH(130.0f/3));
    self.getAuthCodeBtn.sd_layout.rightSpaceToView(self.view,S_XRatioW(55.0f/3)).topSpaceToView(self.unBottomView, S_XRatioH(20.0f/3)).heightIs(S_XRatioH(30)).widthIs(S_XRatioW(100));
    
    self.acBottomView.sd_layout.leftEqualToView(self.authCodeText).topSpaceToView(self.authCodeText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.pswText.sd_layout.leftEqualToView(self.authCodeText).topEqualToView(self.acBottomView).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.pswBottomView.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.pswText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.inviteCodeText.sd_layout.leftEqualToView(self.userNameText).topEqualToView(self.pswBottomView).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.icBottomView.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.inviteCodeText,.5f).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.inviteCodeBtn.sd_layout.rightEqualToView(self.userNameText).topSpaceToView(self.icBottomView,10.0f).heightIs(20.0f).widthIs(S_XRatioW(200.0f));
    
    self.accessoryView.sd_layout.leftSpaceToView(self.view, 136.0f/3).topSpaceToView(self.inviteCodeBtn,S_XRatioH(125.0f/3)).heightIs(S_XRatioH(20.0f)).widthIs(120.0f);
    
    self.protocolBtn.sd_layout.rightSpaceToView(self.view, 136.0f/3).topSpaceToView(self.inviteCodeBtn,S_XRatioH(125.0f/3)).heightIs(S_XRatioH(20.0f)).widthIs(180.0f);
    
    self.registerBtn.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.accessoryView,S_XRatioH(10.0f)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
   
//    [self.loginBtn addSubview:self.testActivityIndicator];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
