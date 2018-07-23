//
//  ChangeLoginPswViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangeLoginPswViewController.h"

@interface ChangeLoginPswViewController ()
@property (nonatomic,strong)ZW_TextField *modelTextField;
@end

@implementation ChangeLoginPswViewController
-(ZW_TextField *)modelTextField {
    if ( _modelTextField == nil ) {
        _modelTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入手机号" isType:isMobileType addSubView:self.view];
    }

    return _modelTextField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"找回登录密码";
    self.mobileLabel.text = @"手机号码：";
    [self initializeTheView];
    self.getCodeButton.enabled = NO;
    self.getCodeButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
    [self childSignal];
    // Do any additional setup after loading the view.
}
-(void)initializeTheView {
    
    CGFloat mobileWidth = [ManagerEngine setTextWidthStr:self.mobileLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.mobileLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,30 + kNAVHEIGHT + (44 - 17) / 2).heightIs(17).widthIs(mobileWidth);
    
    self.modelTextField.sd_layout.leftSpaceToView(self.mobileLabel,0).topSpaceToView(self.view,kNAVHEIGHT + 30 ).heightIs(44).widthIs(WIDTH - mobileWidth - kEDGE * 2);
    
    
    self.verificationCodeTextField.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.modelTextField,30).heightIs(44).widthIs(WIDTH - 100 - kEDGE * 2 - 10);
    
    self.getCodeButton.sd_layout.leftSpaceToView(self.verificationCodeTextField,10).topEqualToView(self.verificationCodeTextField).heightIs(44).widthIs(100);
    
    self.nextButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.verificationCodeTextField,30).heightIs(44).widthIs(WIDTH - kEDGE * 2);
}
-(void)getcodeRequst:(BOOL)isGet {
    
    NSString *urlStr;
    NSMutableDictionary *dict;
    if (isGet) {
        dict = @{@"pwdtype":@1,@"mobile":self.modelTextField.text}.mutableCopy;
        urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetPwdSMSInterface];
        
        HQJLog(@"---%@",urlStr);
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            if (!isGet) {
                [ManagerEngine dimssLoadView:self.nextButton andtitle:@"下一步"];
            }
            
            if([dic[@"code"]integerValue] != 49000) {
                self.getCodeButton.enabled = YES;
                
                [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            } else {
                
        
                
                [self.getCodeButton startCountDownWithSecond:60];
                
                [self.getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                    self.getCodeButton.enabled = NO;
                    self.getCodeButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
                    
                    NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                    return title;
                }];
                [self.getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                    countDownButton.enabled = YES;
                    self.getCodeButton.backgroundColor = DefaultAPPColor;
                    return @"重新获取";
                }];
            }
            
        } andError:^(NSError *error) {
            if (!isGet) {
                [ManagerEngine dimssLoadView:self.nextButton andtitle:@"下一步"];
            }
            
        } ShowHUD:YES];
        
        
    } else {
        NewTradePasswordViewController *NewPswVC = [[NewTradePasswordViewController alloc]init];
        NewPswVC.viewControllerStr = @"LoginViewController";
        NewPswVC.pswType = 1;
        NewPswVC.inputcode = self.verificationCodeTextField.text;
        NewPswVC.mobileStr = self.modelTextField.text;
        [self.navigationController pushViewController:NewPswVC animated:YES];
      
    }
    
}


-(void)childSignal {
    
    RACSignal *codeTexeFieldSignal =[self.modelTextField.rac_textSignal map:^id(id value) {
        return @([ManagerEngine valiMobile:value]);
    }];
    [codeTexeFieldSignal subscribeNext:^(NSNumber *nextNumer) {
        self.getCodeButton.enabled = [nextNumer boolValue];
        if ([nextNumer boolValue]) {
            self.getCodeButton.backgroundColor = DefaultAPPColor;
        } else {
            self.getCodeButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        }
        
    }];
   
    
    
}
@end
