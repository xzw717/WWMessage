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
#import "ChangeLoginPswViewController.h"
#import "TabbarManager.h"
#import "AppDelegate.h"
static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

@interface LoginViewController ()<UITextFieldDelegate>
{
    BOOL isNetWork;
    
}
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UITextField *userNameText;
@property (nonatomic,strong)UITextField *PswText;
@property (nonatomic,strong)UIButton *forgetPswBtn;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)MyViewController *MVC;
@property (nonatomic,strong)UIActivityIndicatorView *testActivityIndicator;

@end

@implementation LoginViewController



-(UIImageView *)headerImageView {
    if ( _headerImageView  == nil ) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.layer.cornerRadius = 35;
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.image = [UIImage imageNamed:@"icon_default_avatar"];
        [self.view addSubview:_headerImageView];
    }
    
    return _headerImageView;
}
-(UITextField *)userNameText {
    
    if ( _userNameText == nil ) {
        _userNameText = [[UITextField alloc]init];
        _userNameText.font = [UIFont systemFontOfSize:15];
        _userNameText.autocorrectionType = UITextAutocorrectionTypeNo;
        _userNameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userNameText.borderStyle = UITextBorderStyleRoundedRect;
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
        _userNameText.leftView=image;
        _userNameText.delegate = self;
        _userNameText.clearsOnBeginEditing = YES;
        _userNameText.clearButtonMode = UITextFieldViewModeAlways;
        _userNameText.keyboardType = UIKeyboardTypeASCIICapable;
        _userNameText.leftViewMode = UITextFieldViewModeAlways;
        _userNameText.placeholder = @"在此输入账号或手机号";
        [self.view addSubview:_userNameText];
        
    }
    
    
    return _userNameText;
}

-(UITextField *)PswText {
    if ( _PswText == nil ) {
        _PswText = [[UITextField alloc]init];
        _PswText.clearsOnBeginEditing = YES;
        _PswText.placeholder = @"请输入登录密码";
        _PswText.borderStyle = UITextBorderStyleRoundedRect;
        _PswText.delegate = self;
        _PswText.font = [UIFont systemFontOfSize:15];
        _PswText.clearButtonMode = UITextFieldViewModeAlways;
        _PswText.keyboardType = UIKeyboardTypeASCIICapable;
        _PswText.secureTextEntry = YES;
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
        _PswText.leftView=image;
        _PswText.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_PswText];
    }
    
    
    
    return _PswText;
}

-(UIButton *)forgetPswBtn {
    if ( _forgetPswBtn == nil ) {
        _forgetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_forgetPswBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        
        [_forgetPswBtn setTitleColor:[ManagerEngine getColor:@"18abf5"] forState:UIControlStateNormal];
        _forgetPswBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_forgetPswBtn bk_addEventHandler:^(id  _Nonnull sender) {
            ChangeLoginPswViewController *LVC =[[ChangeLoginPswViewController alloc]init];
//            ZWNavigationController *Nav = [[ZWNavigationController alloc]initWithRootViewController:RVC];
//            [self.navigationController presentModalViewController:Nav animated:YES];

//            self.view.window.rootViewController = Nav;
            [self.navigationController pushViewController:LVC animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_forgetPswBtn];
    }
    
    
    return _forgetPswBtn;
}
-(UIButton *)loginBtn {
    if ( _loginBtn == nil ) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
        [self.view addSubview:_loginBtn];
    }
    
    
    
    
    return _loginBtn;
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

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.fd_prefersNavigationBarHidden = YES;
   
    
    [self.view setBackgroundColor:DefaultBackgroundColor];
    [self ViewTheContent];
    
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

-(void)ViewTheContent {
    
    
    
    self.headerImageView.sd_layout.leftSpaceToView(self.view,(WIDTH-70)/2).topSpaceToView(self.view,(100.f/568.f)*HEIGHT).heightIs(70).widthIs(70);
    
    self.userNameText.sd_layout.leftSpaceToView(self.view,15).topSpaceToView(self.headerImageView,30).heightIs(40).widthIs(WIDTH-30);
    
    self.PswText.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.userNameText,15).heightIs(40).widthIs(WIDTH-30);
    
    CGFloat forgetWidth = [ManagerEngine setTextWidthStr:self.forgetPswBtn.titleLabel.text andFont:[UIFont systemFontOfSize:12]];
    self.forgetPswBtn.sd_layout.leftSpaceToView(self.view,WIDTH - 15 - forgetWidth).topSpaceToView(self.PswText,10).heightIs(20).widthIs(forgetWidth);
    
    self.loginBtn.sd_layout.leftEqualToView(self.userNameText).topSpaceToView(self.PswText,40).heightIs(44).widthIs(WIDTH-30);
    
    [self.loginBtn addSubview:self.testActivityIndicator];

    
    
}

-(void)signalDeal {
    RACSignal *userNameSignal = [self.userNameText.rac_textSignal map:^id(NSString *value) {
        return @([self userString:value]);
    }];
    RACSignal *pswSignal = [self.PswText.rac_textSignal map:^id(NSString *value) {
        return @([self pswString:value]);
    }];
    RACSignal *CombinedSignal = [RACSignal combineLatest:@[userNameSignal,pswSignal] reduce:^id (NSNumber *user,NSNumber *psw){
        return @([user boolValue]&&[psw boolValue]);
    }];
    [CombinedSignal subscribeNext:^(NSNumber *combined) {
        self.loginBtn.enabled = [combined boolValue];
        if ([combined boolValue]) {
            _loginBtn.backgroundColor = [ManagerEngine getColor:@"18abf5"];

        } else {
            _loginBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];

            
        }
     
    }];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
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
    if (text.length>=6&&text.length<=12) {
        return YES;
    }
    
    return NO;
}

#pragma mark --
#pragma mark ---请求
-(void)LoginRequst {

//    HQJLog(@"网络状态:%@",[ManagerEngine networkStatus])
    if (isNetWork == YES) {
  
        NSString *urlText = [NSString stringWithFormat:@"%@loginCheck/username/%@/password/%@/membertype/2",Api_URL,self.userNameText.text,self.PswText.text];
        NSString *codeingUrl =  [urlText stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        [RequestEngine HQJBusinessRequestDetailsUrl:codeingUrl complete:^(NSDictionary *dic) {

        if ([dic[@"error"]integerValue] != 0) {
            
            [self.testActivityIndicator stopAnimating];
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
            [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
            
        } else {
            
            NSString *loginnameStr = [NSString stringWithFormat:@"%@",dic[@"result"][@"loginname"]];
            NSMutableDictionary *dic1;
            
            if (![loginnameStr isEqualToString:@"<null>"]) {
                dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        dic[@"result"][@"loginname"],@"loginname",
                        dic[@"result"][@"memberid"],@"memberid",
                        dic[@"result"][@"typecname"],@"typecname",
                        dic[@"result"][@"typeename"],@"typeename",nil];
                
            } else {
                
                dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        dic[@"result"][@"memberid"],@"memberid",
                        dic[@"result"][@"typecname"],@"typecname",
                        dic[@"result"][@"typeename"],@"typeename",nil];
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
