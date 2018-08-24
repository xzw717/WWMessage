//
//  BuyZHViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BuyZHViewController.h"

#import "OkBuyViewController.h"

@interface BuyZHViewController () <UITextFieldDelegate>
{
    BOOL isHaveDian;

}

@end

@implementation BuyZHViewController
-(NoticeView *)titleView {
    if (!_titleView) {
        _titleView = [[NoticeView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 45) withNav:NO];
        [self.view addSubview:_titleView];
    }
    
    return _titleView;
}



-(ZW_Label *)payerLabel {
    if (!_payerLabel) {
        _payerLabel = [[ZW_Label alloc]initWithStr:[NSString stringWithFormat:@"支付方：%@",[NameSingle shareInstance].name] addSubView:self.view];
    }
    
    return _payerLabel;
}


-(ZW_Label *)BonusNumerLabel {
    if (!_BonusNumerLabel) {
        _BonusNumerLabel = [[ZW_Label alloc]initWithStr:@"购买数量：" addSubView:self.view];
    }
    return _BonusNumerLabel;
}

-(ZW_TextField *)BonusNumerTextField {
    if (!_BonusNumerTextField) {
        _BonusNumerTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入需要购买RY值数额" isType:isMoneyType addSubView:self.view];
        _BonusNumerTextField.delegate = self;
    }
    return _BonusNumerTextField;
}
-(ZW_Label *)collectionLabel {
    if (!_collectionLabel) {
        _collectionLabel = [[ZW_Label alloc]initWithStr:[NSString stringWithFormat:@"收款方：%@",_model.parentName] addSubView:self.view];
    }
    return _collectionLabel;
}

-(UIButton *)nextButton {
    
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 5 ;
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton bk_addEventHandler:^(id  _Nonnull sender) {
            [ManagerEngine loadDateView:self.nextButton andPoint:CGPointMake(self.nextButton.frame.size.width/2, self.nextButton.frame.size.height/2)];
            [self nextBtn];

        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_nextButton];
    }
    
    return _nextButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zw_title = @"购买RY值";
    
    [BuyZHViewModel buyZH:^(id sender) {
        _model = sender;
        [self.titleView setTitleStr: [NSString stringWithFormat:@"当前商家账户有%@个积分",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",_model.score.score] afterPoint:5]] andisNav:NO andColor:[ManagerEngine getColor:@"fff2b2"]];
        [self setViewframe];

    }];
    [self signalSet];
}




-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.BonusNumerTextField resignFirstResponder];

}

-(void)setViewframe {
    CGFloat payLabelWith = [ManagerEngine setTextWidthStr:self.payerLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.payerLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,75 + kNAVHEIGHT).heightIs(17).widthIs(payLabelWith);
    
    CGFloat bonusWidth = [ManagerEngine setTextWidthStr:self.BonusNumerLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.BonusNumerLabel.sd_layout.leftEqualToView(self.payerLabel).topSpaceToView(self.payerLabel,30 + (44 - 17) / 2).heightIs(17).widthIs(bonusWidth);
    
    self.BonusNumerTextField.sd_layout.leftSpaceToView(self.BonusNumerLabel,0).topSpaceToView(self.payerLabel,30).heightIs(44).widthIs(WIDTH - bonusWidth - kEDGE *2);
    
    CGFloat collectionWidth = [ManagerEngine setTextWidthStr:self.collectionLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.collectionLabel.sd_layout.leftEqualToView(self.BonusNumerLabel).topSpaceToView(self.BonusNumerLabel,30 + (44 - 17) / 2).heightIs(17).widthIs(collectionWidth);
    
    self.nextButton.sd_layout.leftEqualToView(self.payerLabel).topSpaceToView(self.collectionLabel,40).heightIs(44).widthIs(WIDTH - kEDGE * 2);
}

#pragma mark --
#pragma mark --- 下一步按钮响应方法
-(void)nextBtn {
    
    if ([self.BonusNumerTextField.text doubleValue] < 0 ) {
        [ManagerEngine dimssLoadView:self.nextButton andtitle:@"下一步"];
        [SVProgressHUD showErrorWithStatus:@"数量要大于 0"];
    } else {
        OkBuyViewController *OVC = [[OkBuyViewController alloc]init];
        OVC.numerStr = self.BonusNumerTextField.text;
        [ManagerEngine dimssLoadView:self.nextButton andtitle:@"下一步"];
        
        [self.navigationController pushViewController:OVC animated:YES];
    }

}

#pragma mark --
#pragma mark --- 信号创建
-(void)signalSet {
    
    
    RACSignal *validBounsSignal = [self.BonusNumerTextField.rac_textSignal map:^id(NSString *value) {
        
       
        return @([self textFieldChanged:value]);
    }];
   
  
    
    RACSignal *signUp = [RACSignal combineLatest:@[validBounsSignal] reduce:^id(NSNumber *bounsValid){
        return @([bounsValid boolValue]);
    }];
    [signUp subscribeNext:^(NSNumber * signUpActive) {
        self.nextButton.enabled = [signUpActive boolValue];
        if ([signUpActive boolValue]) {
            self.nextButton.backgroundColor = DefaultAPPColor;
            
        } else {
            self.nextButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
            
        }
        
    }];

    
    
    
}

#pragma mark ----条件
-(BOOL)textFieldChanged:(NSString *)text
{
    if ([text floatValue]<=0) {
        return  NO;
    }  else{
        return  YES;
    }
    
}


#pragma mark --
#pragma mark ---UITextFiled Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([self.BonusNumerTextField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
        
    {
        if ([self.BonusNumerTextField.text length]>7)
        {
            [ManagerEngine homeSvpStr:@"亲，输入超出限制了哟" andcenterView:self.view andStyle:promptViewDefault];
            
            return NO;
        }
        
        
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            
            
            if (single=='.')
            {
                if(! isHaveDian  )//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [ManagerEngine homeSvpStr:@"亲，您已经输入过小数点了" andcenterView:self.view andStyle:promptViewDefault];
                    
                    [self.BonusNumerTextField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[self.BonusNumerTextField.text rangeOfString:@"."];
                    
                    NSInteger tt = range.location-ran.location;
                    
                    if (tt <= 2){
                        return YES;
                    }else{
                        [ManagerEngine homeSvpStr:@"亲，您最多输入两位小数" andcenterView:self.view andStyle:promptViewDefault];
                        return NO;
                    }
                }
                else
                {
                    return YES;
                    
                }
                
                
            }
        }else{//输入的数据格式不正确
            [ManagerEngine homeSvpStr:@"亲，您输入的格式不正确" andcenterView:self.view andStyle:promptViewDefault];
            [self.BonusNumerTextField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
            
        }
        
    }
    
    else
    {
        return YES;
        
    }
    
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
