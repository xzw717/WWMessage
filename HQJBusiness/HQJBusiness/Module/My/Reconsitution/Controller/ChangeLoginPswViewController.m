//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangeLoginPswViewController.h"

#import "ChangePswViewModel.h"

#define TopSpace 40/3.f
static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

@interface ChangeLoginPswViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UIView *oldPswView;
@property (nonatomic,strong)UILabel *oldPswLabel;
@property (nonatomic,strong)UITextField *oldPswText;
@property (nonatomic,strong)UIView *opBottomView;

@property (nonatomic,strong)UIView *newPswView;
@property (nonatomic,strong)UILabel *newPswLabel;
@property (nonatomic,strong)UITextField *newPswText;
@property (nonatomic,strong)UIView *npBottomView;

@property (nonatomic,strong)UIView *againPswView;
@property (nonatomic,strong)UILabel *againPswLabel;
@property (nonatomic,strong)UITextField *againPswText;


@property (nonatomic,strong)UIButton *sureBtn;
@end

@implementation ChangeLoginPswViewController

#pragma lazy-load

- (UIView *)oldPswView{
    if (_oldPswView == nil) {
        _oldPswView = [[UIView alloc]init];
        _oldPswView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_oldPswView];
    }
    return _oldPswView;
}

- (UILabel *)oldPswLabel{
    if ( _oldPswLabel == nil ) {
        _oldPswLabel = [[UILabel alloc]init];
        _oldPswLabel.font = [UIFont systemFontOfSize:16];
        _oldPswLabel.text = @"原始密码";
        [self.oldPswView addSubview:_oldPswLabel];
        
    }
    
    return _oldPswLabel;
}
-(UITextField *)oldPswText {
    if ( _oldPswText == nil ) {
        _oldPswText = [[UITextField alloc]init];
        _oldPswText.clearsOnBeginEditing = YES;
        _oldPswText.placeholder = @"请输入原始登录密码";
        _oldPswText.delegate = self;
        _oldPswText.font = [UIFont systemFontOfSize:16];
        //        _pswText.clearButtonMode = UITextFieldViewModeAlways;
        _oldPswText.keyboardType = UIKeyboardTypeASCIICapable;
        [self.oldPswView addSubview:_oldPswText];
    }

    return _oldPswText;
}
- (UIView *)opBottomView{
    if ( _opBottomView  == nil ) {
        _opBottomView = [[UIView alloc]init];
        _opBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.oldPswView addSubview:_opBottomView];
    }
    return _opBottomView;
}


- (UIView *)newPswView{
    if (_newPswView == nil) {
        _newPswView = [[UIView alloc]init];
        _newPswView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_newPswView];
    }
    return _newPswView;
}

- (UILabel *)newPswLabel{
    if ( _newPswLabel == nil ) {
        _newPswLabel = [[UILabel alloc]init];
        _newPswLabel.font = [UIFont systemFontOfSize:16];
        _newPswLabel.text = @"新的密码";
        [self.newPswView addSubview:_newPswLabel];
        
    }
    
    return _newPswLabel;
}

-(UITextField *)newPswText {
    if ( _newPswText == nil ) {
        _newPswText = [[UITextField alloc]init];
        _newPswText.clearsOnBeginEditing = YES;
        _newPswText.placeholder = @"密码为6-18位数字及字母、下划线组成";
        _newPswText.delegate = self;
        _newPswText.font = [UIFont systemFontOfSize:16];
//        _pswText.clearButtonMode = UITextFieldViewModeAlways;
        _newPswText.keyboardType = UIKeyboardTypeASCIICapable;
        [self.newPswView addSubview:_newPswText];
    }
    
    
    
    return _newPswText;
}
- (UIView *)npBottomView{
    if ( _npBottomView  == nil ) {
        _npBottomView = [[UIView alloc]init];
        _npBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.newPswView addSubview:_npBottomView];
    }
    return _npBottomView;
}

- (UIView *)againPswView{
    if (_againPswView == nil) {
        _againPswView = [[UIView alloc]init];
        _againPswView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_againPswView];
    }
    return _againPswView;
}

- (UILabel *)againPswLabel{
    if ( _againPswLabel == nil ) {
        _againPswLabel = [[UILabel alloc]init];
        _againPswLabel.font = [UIFont systemFontOfSize:16];
        _againPswLabel.text = @"确认密码";
        [self.againPswView addSubview:_againPswLabel];
        
    }
    
    return _againPswLabel;
}

-(UITextField *)againPswText {
    if ( _againPswText == nil ) {
        _againPswText = [[UITextField alloc]init];
        _againPswText.clearsOnBeginEditing = YES;
        _againPswText.placeholder = @"请再次输入新密码";
        _againPswText.delegate = self;
        _againPswText.font = [UIFont systemFontOfSize:16];
        //        _pswText.clearButtonMode = UITextFieldViewModeAlways;
        _againPswText.keyboardType = UIKeyboardTypeASCIICapable;
        [self.againPswView addSubview:_againPswText];
    }
    
    
    
    return _againPswText;
}


- (UIButton *)sureBtn{
    if ( _sureBtn == nil ) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = S_XRatioH(145/6);
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [self.view addSubview:_sureBtn];
    }
    
    return _sureBtn;
}

#pragma click method

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarWhite;
    self.isHideShadowLine = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置交易密码";
    [self.view setBackgroundColor:[ManagerEngine getColor:@"f7f7f7"]];
    [self layoutTheSubViews];
    
    [self signalChangePsw];
    
    // Do any additional setup after loading the view.

    
}
#pragma private method
- (void)layoutTheSubViews{

    self.oldPswView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, TopSpace).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.oldPswLabel.sd_layout.leftSpaceToView(self.oldPswView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.oldPswText.sd_layout.leftSpaceToView(self.oldPswLabel, 10).rightEqualToView(self.oldPswView).heightIs(S_XRatioH(130.0f/3));
    
    self.opBottomView.sd_layout.leftEqualToView(self.oldPswLabel).bottomEqualToView(self.oldPswView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.newPswView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.oldPswView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);

    self.newPswLabel.sd_layout.leftSpaceToView(self.newPswView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);

    self.newPswText.sd_layout.leftSpaceToView(self.newPswLabel, 10).rightEqualToView(self.newPswView).heightIs(S_XRatioH(130.0f/3));

    self.npBottomView.sd_layout.leftEqualToView(self.newPswLabel).bottomEqualToView(self.newPswView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));


    self.againPswView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.newPswView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);

    self.againPswLabel.sd_layout.leftSpaceToView(self.againPswView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);

    self.againPswText.sd_layout.leftSpaceToView(self.againPswLabel, 10).rightEqualToView(self.againPswView).heightIs(S_XRatioH(130.0f/3));


    self.sureBtn.sd_layout.leftSpaceToView(self.view, 70.0f/3).topSpaceToView(self.againPswView,S_XRatioH(125.0f/3)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
}

#pragma mark --
#pragma mark --- 信号
-(void)signalChangePsw {
    
    RACSignal * oldPswSignal = [_oldPswText.rac_textSignal map:^id(id value) {
        return @([self isVaildString:value]);
    }];
    RACSignal *oneNewPswSignal = [_newPswText.rac_textSignal map:^id(id value) {
        return @([self isVaildString:value]);
    }];
    RACSignal *twoNewPswSignal = [_againPswText.rac_textSignal map:^id(id value) {
        return @([self isVaildString:value]);
    }];
    RACSignal *upSignal = [RACSignal combineLatest:@[oldPswSignal,oneNewPswSignal,twoNewPswSignal] reduce:^id (NSNumber *oldNumer,NSNumber *oneNumer,NSNumber *twoNumer){
        return @([oldNumer boolValue]&&[oneNumer boolValue]&&[twoNumer boolValue]);
    }];
    [upSignal subscribeNext:^(NSNumber *x) {
        self.sureBtn.enabled = [x boolValue];
        if ([x boolValue]) {
            self.sureBtn.backgroundColor = DefaultAPPColor;
            
        } else {
            self.sureBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
            
        }
    }];
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ManagerEngine loadDateView:self.sureBtn andPoint:CGPointMake(self.sureBtn.mj_w / 2, self.sureBtn.mj_h / 2)];
        
        
        if(![_newPswText.text isEqualToString:_againPswText.text]){
            
            [ManagerEngine dimssLoadView:self.sureBtn andtitle:@"确定"];
            
            [SVProgressHUD showErrorWithStatus:@"两次新密码不一致"];
            
        } else if ([_oldPswText.text isEqualToString:_newPswText.text]) {
            [ManagerEngine dimssLoadView:self.sureBtn andtitle:@"确定"];
            
            [SVProgressHUD showErrorWithStatus:@"新旧密码不得一致"];
            
            
        } else {
            [ChangePswViewModel changePswWithOldpwd:_oldPswText.text andNewpwd:_newPswText.text andBlock:^(NSDictionary * changepswBlock) {
                if ([changepswBlock[@"code"]integerValue] == 49000) {
                    
                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                    [ManagerEngine SVPAfter:@"操作成功" complete:^{
                        [ManagerEngine dimssLoadView:self.sureBtn andtitle:@"确定"];
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } else {
                    [ManagerEngine dimssLoadView:self.sureBtn andtitle:@"确定"];
                    
                    [SVProgressHUD showErrorWithStatus:changepswBlock[@"msg"]];
                }
                
            }];
            
            
        }
        
        
    }];
    
}
#pragma mark --
#pragma mark --- 输入框条件
-(BOOL)isVaildString:(NSString *)text {
    if(text.length>=6&&text.length<=12){
        
        return YES;
    } else {
        return NO;
    }
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _newPswText || textField == _againPswText) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        } else {
            if (textField.text.length<12) {
                NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
                NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
                return [string isEqualToString:filtered];
                
            } else {
                
                return NO;
            }
        }
    } else {
        if ([string isEqualToString:@""]) {
            return YES;
        } else {
            return textField.text.length>=6?NO:YES;
            
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
