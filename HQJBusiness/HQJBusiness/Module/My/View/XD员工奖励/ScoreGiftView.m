//
//  ScoreGiftView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ScoreGiftView.h"
#define DEF_MAIL @"1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
@interface ScoreGiftView ()<UITextFieldDelegate>

@end
@implementation ScoreGiftView
- (UITextField *)userNameTextfield {
    if (_userNameTextfield == nil) {
        _userNameTextfield = [[UITextField alloc]init];
        _userNameTextfield.layer.masksToBounds = YES;
        _userNameTextfield.layer.cornerRadius = 5;
        _userNameTextfield.layer.borderWidth = 0.5;
        _userNameTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _userNameTextfield.backgroundColor = [UIColor whiteColor];
        _userNameTextfield.font = [UIFont systemFontOfSize:16];
        _userNameTextfield.delegate = self;
        _userNameTextfield.placeholder = @"请输入11位手机号码";
        _userNameTextfield.tintColor = [ManagerEngine getColor:@"bfbfbf"];
        _userNameTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _userNameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return _userNameTextfield;
}
- (UITextField *)authCodeTextfield{
    if (_authCodeTextfield == nil) {
        _authCodeTextfield = [[UITextField alloc]init];
        _authCodeTextfield.layer.masksToBounds = YES;
        _authCodeTextfield.layer.cornerRadius = 5;
        _authCodeTextfield.layer.borderWidth = 0.5;
        _authCodeTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _authCodeTextfield.backgroundColor = [UIColor whiteColor];
        _authCodeTextfield.font = [UIFont systemFontOfSize:16];
        _authCodeTextfield.delegate = self;
        _authCodeTextfield.placeholder = @"请输入验证码";
        _authCodeTextfield.tintColor = [ManagerEngine getColor:@"bfbfbf"];
        _authCodeTextfield.returnKeyType = UIReturnKeyDone;
        _authCodeTextfield.keyboardType = UIKeyboardTypeASCIICapable;
        _authCodeTextfield.clearButtonMode = UITextAutocorrectionTypeNo;
    }
    return _authCodeTextfield;
}

- (UIButton *)getCodeBtn{
    if (_getCodeBtn == nil) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.layer.masksToBounds = YES;
        _getCodeBtn.layer.cornerRadius = 5;
        
        _getCodeBtn.backgroundColor = DefaultAPPColor;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[ManagerEngine getColor:@"555555"] forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:48/3];
        
    }
    return _getCodeBtn;
    
}
- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 145/6;
        _submitButton.backgroundColor = DefaultAPPColor;
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:55/3];
    }
    
    return _submitButton;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.userNameTextfield];
        [self addSubview:self.authCodeTextfield];
        [self addSubview:self.getCodeBtn];
        [self addSubview:self.submitButton];
        [self addSubview:self.authCodeTextfield];
        
        [self setViewLayout];
        
    }
    
    return self;
}
- (void)setViewLayout {

    
    [self.userNameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 28 * 2, 50));
    }];

    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTextfield.mas_bottom).offset(20);
        make.right.mas_equalTo(-28);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.authCodeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTextfield.mas_bottom).offset(20);
        make.right.mas_equalTo(self.getCodeBtn.mas_left).offset(-5);
        make.left.height.mas_equalTo(self.userNameTextfield);
    }];

    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authCodeTextfield.mas_bottom).offset(NewProportion(100));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 28 * 2, 50));
    }];
    
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@""]) {
        return YES;
    }else {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DEF_MAIL]invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest){
            return NO;
        } else {
            
            if (textField == self.userNameTextfield) {
                return textField.text.length >= 20 ? NO : YES;
                
            }
            
            return YES;
        }
        
        
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
