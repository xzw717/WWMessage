//
//  NewTradePasswordViewController.m
//  HQJBusiness
//  新交易密码
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NewTradePasswordViewController.h"


static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";




@interface NewTradePasswordViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) ZW_Label *newsPswLabel;
@property (nonatomic,strong) ZW_TextField *newsPswTextField;
@property (nonatomic,strong) UIButton *okButtn;
@end

@implementation NewTradePasswordViewController
-(ZW_Label *)newsPswLabel {
    if ( _newsPswLabel == nil ) {
        _newsPswLabel =[[ZW_Label alloc]initWithStr:@"新密码：" addSubView:self.view];
    }
    
    return _newsPswLabel;
}
-(ZW_TextField *)newsPswTextField {
    if ( _newsPswTextField == nil ) {
        _newsPswTextField =[[ZW_TextField alloc]initWithPlaceholder:@"请输入新的密码" isType:isPasswordType addSubView:self.view];
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
        [_okButtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_okButtn];
        
    }
    
    return _okButtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"新密码";
    [self initializeTheView];
    [self setSignal];
    if (![_pswType isEqualToString:@"tradepwd"]) {
        _newsPswTextField.keyboardType = UIKeyboardTypeASCIICapable;
    }
}
-(void)viewWillAppear:(BOOL)animated {
    self.fd_interactivePopDisabled = YES;
    self.viewControllerName = _viewControllerStr;
//    self.backStyle = SpecifyTheInterfaceStyle;
}

-(void)initializeTheView {
    
    CGFloat pswLabelWidth  = [ManagerEngine setTextWidthStr:self.newsPswLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.newsPswLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,kNAVHEIGHT + 30 + (44 - 17) / 2).heightIs(17).widthIs(pswLabelWidth);
    
    self.newsPswTextField.sd_layout.leftSpaceToView(self.newsPswLabel,0).topSpaceToView(self.view,kNAVHEIGHT + 30).heightIs(44).widthIs(WIDTH - pswLabelWidth - kEDGE * 2);
    self.okButtn.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.newsPswTextField,30).heightIs(44).widthIs(WIDTH - kEDGE * 2);
    
}


-(void)setSignal {
    RACSignal *newsPswTexeFieldSignal =[self.newsPswTextField.rac_textSignal map:^id(id value) {
        return @([self pswlength:value]);
    }];
    [newsPswTexeFieldSignal subscribeNext:^(NSNumber *nextNumer) {
        self.okButtn.enabled = [nextNumer boolValue];
        if ([nextNumer boolValue]) {
            self.okButtn.backgroundColor = DefaultAPPColor;
        } else {
            self.okButtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        }
        
    }];
    [[self.okButtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [ManagerEngine loadDateView:self.okButtn andPoint:CGPointMake(self.okButtn.mj_w / 2, self.okButtn.mj_h / 2)];
        if ([_pswType isEqualToString:@"tradepwd"]) {
            if (self.newsPswTextField.text.length != 6) {
                [ManagerEngine dimssLoadView:self.okButtn andtitle:@"确定"];
                [SVProgressHUD showErrorWithStatus:@"交易密码要设置6位哦"];
            } else {
                [self newPswRequst];
            }
        } else {
            if (self.newsPswTextField.text.length < 6 || self.newsPswTextField.text.length > 12) {
                [ManagerEngine dimssLoadView:self.okButtn andtitle:@"确定"];
                [SVProgressHUD showErrorWithStatus:@"登录密码要设置6-12位哦"];
            } else {
                [self newPswRequst];
            }
        }
       
    }];
    
    
}

- (BOOL)pswlength:(NSString *)text {
     if ([_pswType isEqualToString:@"tradepwd"]) {
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
    
    if ([_pswType isEqualToString:@"tradepwd"]) {
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
    
    
    
}



-(void)newPswRequst {
//    NSMutableDictionary *dict =
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/inputNewpwdAction/newpwd/%@/pwdtype/%@/mobile/%@",AppSel_URL,self.newsPswTextField.text,_pswType,_mobileStr];
    
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [ManagerEngine SVPAfter:@"修改成功" complete:^{
                [self popViews];
            }];
        }
    } andError:^(NSError *error) {
        [ManagerEngine dimssLoadView:self.okButtn andtitle:@"确定"];

    } ShowHUD:YES];
    
}



@end
