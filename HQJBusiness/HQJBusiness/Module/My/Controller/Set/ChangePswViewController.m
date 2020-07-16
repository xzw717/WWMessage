//
//  ChangePswViewController.m
//  HQJFacilitator
//
//  Created by mymac on 2016/10/18.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangePswViewController.h"

#import "ChangePswViewModel.h"



static NSString * kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

@interface ChangePswViewController ()<UITextFieldDelegate>
{
    NSString *_typePswStr;
}
@property (nonatomic,strong)UITextField *oldPsWTextField;
@property (nonatomic,strong)UITextField *oneNewPsWTextField;
@property (nonatomic,strong)UITextField *twoNewPsWTextField;
@property (nonatomic,strong)UIButton *okBtn;
@property (nonatomic, assign) PswType pswType;
@end

@implementation ChangePswViewController
- (instancetype)initWithLoginPassWordType:(PswType)type {
    self = [super init];
    if (self) {
        self.pswType = type;
    }
    return self;
}
-(UIButton *)okBtn {
    if ( _okBtn == nil ) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.cornerRadius = 5;
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.view addSubview:_okBtn];
    }
    
    
    
    return _okBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.pswType == SetLoginPassWordType) {
        self.zw_title = @"设置登录密码";

    }
    if (self.pswType == ChangeLoginPassWordType) {
        self.zw_title = @"修改登录密码";

    }
    [self createChangeUI];
    [self signalChangePsw];
    // Do any additional setup after loading the view.
}

-(void)createChangeUI {
    NSArray *labelAry = [NSArray array];
    NSArray *pswAry = [NSArray array];
    if (self.pswType == SetLoginPassWordType) {
        labelAry = @[@"新的密码:",@"确认密码:"];
        pswAry = @[@"新密码(限6到12位)",@"请再次输入新密码"];

    }
    if (self.pswType == ChangeLoginPassWordType) {
        labelAry = @[@"原始密码:",@"新的密码:",@"确认密码:"];
        pswAry = @[@"请输入原始登录密码",@"新密码(限6到12位)",@"请再次输入新密码"];

    }
    _typePswStr = @"loginpwd";

    CGFloat LabelSize = [ManagerEngine setTextWidthStr:labelAry[0] andFont:[UIFont systemFontOfSize:17]];
    for (NSInteger i=0; i<labelAry.count; i++) {
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.frame = CGRectMake(15, i%3*(20+60)+30+NavigationControllerHeight, LabelSize, 20);
        titleLabel.text  =labelAry[i];
        [self.view addSubview:titleLabel];
        
        UITextField *PswTextField = [[UITextField alloc]init];
     
            PswTextField.keyboardType = UIKeyboardTypeASCIICapable;

        PswTextField.font = [UIFont systemFontOfSize:15];
        PswTextField.tag  = i;
        PswTextField.clearButtonMode = UITextFieldViewModeAlways;
        PswTextField.secureTextEntry = YES;
        PswTextField.frame = CGRectMake(15+5+ LabelSize, i%3*(44+35)+20+NavigationControllerHeight,WIDTH- 15 * 2 - 5-LabelSize, 44);
        PswTextField.placeholder = pswAry[i];
        PswTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:PswTextField];
        if (self.pswType == SetLoginPassWordType) {
            switch (PswTextField.tag) {
                   case 0:
                       _oneNewPsWTextField = PswTextField;
                       _oneNewPsWTextField.delegate = self;

                       
                       break;
                   case 1:
                       _twoNewPsWTextField = PswTextField;
                       _twoNewPsWTextField.delegate = self;
                       break;
                   default:
                       break;
               }
        }
        if (self.pswType == ChangeLoginPassWordType) {
        switch (PswTextField.tag) {
               case 0:
                   _oldPsWTextField = PswTextField;
                   break;
               case 1:
                   _oneNewPsWTextField = PswTextField;
                   _oneNewPsWTextField.delegate = self;

                   
                   break;
               case 2:
                   _twoNewPsWTextField = PswTextField;
                   _twoNewPsWTextField.delegate = self;
                   break;
               default:
                   break;
           }
        }
   
        
    }
    
    // ---   交易密码界面的忘记密码按钮
    
    self.okBtn.sd_layout.leftSpaceToView(self.view,15).topSpaceToView(_twoNewPsWTextField,30).heightIs(44).widthIs(WIDTH-15*2);
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _oneNewPsWTextField || textField == _twoNewPsWTextField) {

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

#pragma mark --
#pragma mark --- 信号
-(void)signalChangePsw {
    @weakify(self);
    RACSignal * oldPswSignal;
    if (self.pswType != SetLoginPassWordType) {
    oldPswSignal = [_oldPsWTextField.rac_textSignal map:^id(id value) {
          @strongify(self);
          return @([self isVaildString:value]);
      }];
    }
  
    RACSignal *oneNewPswSignal = [_oneNewPsWTextField.rac_textSignal map:^id(id value) {
        @strongify(self);
        return @([self isVaildString:value]);
    }];
    RACSignal *twoNewPswSignal = [_twoNewPsWTextField.rac_textSignal map:^id(id value) {
        @strongify(self);
        return @([self isVaildString:value]);
    }];
    RACSignal *upSignal;
    if (self.pswType != SetLoginPassWordType) {
        upSignal = [RACSignal combineLatest:@[oldPswSignal,oneNewPswSignal,twoNewPswSignal] reduce:^id (NSNumber *oldNumer,NSNumber *oneNumer,NSNumber *twoNumer){
            return @([oldNumer boolValue]&&[oneNumer boolValue]&&[twoNumer boolValue]);
        }];
    }
    RACSignal *upSignalTwo = [RACSignal combineLatest:@[oneNewPswSignal,twoNewPswSignal] reduce:^id (NSNumber *oneNumer,NSNumber *twoNumer){
           return @([oneNumer boolValue]&&[twoNumer boolValue]);
       
    }];
    if (self.pswType == SetLoginPassWordType) {
        
        [upSignalTwo subscribeNext:^(NSNumber *x) {
            @strongify(self);
             self.okBtn.enabled = [x boolValue];
             if ([x boolValue]) {
                 self.okBtn.backgroundColor = DefaultAPPColor;

             } else {
                 self.okBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];

             }
         }];
      }
      if (self.pswType == ChangeLoginPassWordType) {
          [upSignal subscribeNext:^(NSNumber *x) {
              @strongify(self);
               self.okBtn.enabled = [x boolValue];
               if ([x boolValue]) {
                   self.okBtn.backgroundColor = DefaultAPPColor;

               } else {
                   self.okBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];

               }
           }];
      }
 
    [[self.okBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [ManagerEngine loadDateView:self.okBtn andPoint:CGPointMake(self.okBtn.mj_w / 2, self.okBtn.mj_h / 2)];
        
        
        if(![self.oneNewPsWTextField.text isEqualToString:self.twoNewPsWTextField.text]){
            
            [ManagerEngine dimssLoadView:self.okBtn andtitle:@"确定"];
            
            [SVProgressHUD showErrorWithStatus:@"两次新密码不一致"];
            
        } else if ([self.oldPsWTextField.text isEqualToString:self.oneNewPsWTextField.text]) {
            [ManagerEngine dimssLoadView:self.okBtn andtitle:@"确定"];

            [SVProgressHUD showErrorWithStatus:@"新旧密码不得一致"];


        } else {
            [ChangePswViewModel changePswWithOldpwd:self.oldPsWTextField.text andNewpwd:self.oneNewPsWTextField.text andBlock:^(NSDictionary * changepswBlock) {
                if ([changepswBlock[@"code"]integerValue] == 49000) {
                    
                    [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                    [ManagerEngine SVPAfter:@"操作成功" complete:^{
                        [ManagerEngine dimssLoadView:self.okBtn andtitle:@"确定"];

                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } else {
                    [ManagerEngine dimssLoadView:self.okBtn andtitle:@"确定"];

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


#pragma mark --
#pragma mark --- 更改密码请求
-(void)requstPswChange {
    
//    [RequestEngine HQJFacilitatorRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
//
//        HQJLog(@"更改的密码:%@",dic);
//        
//        if([dic[@"error"] integerValue] == 0){
//            [ManagerEngine customAlert:@"修改成功,请妥善保管好新密码" andViewController:self isBack:YES];
//        } else {
//            [ManagerEngine customAlert:dic[@"result"][@"errmsg"] andViewController:self isBack:NO];
//        }
//        
//    } andError:^(NSError *error) {
//        
//    } ShowHUD:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
