//
//  BonusExchangeViewController.m
//  HQJBusiness
//   积分兑现 && 现金提现
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BonusExchangeViewController.h"
#import "NoticeView.h"
#import "BonusExchangeViewModel.h"
#import "BonusExchangeModel.h"
#import "SelectBankViewController.h"

@interface BonusExchangeViewController ()<UITextFieldDelegate>
{
    BOOL isHaveDian;
    
    NSString *_withdrawDepositStr;
    
    NSString *_withdrawDepositNumerStr;
    
    NSString *_manageStr;
}
@property (nonatomic,strong) NoticeView *titleView ;  // ---- 黄色广告条

@property (nonatomic,strong) BonusExchangeModel *model;  // ---- 商家信息模型

@property (nonatomic,strong) ZW_Label *payerLabel;  // ---- 支付方 &  提现方

@property (nonatomic,strong) ZW_Label *BonusNumerLabel;  // ---- 积分数 & 提现金额

@property (nonatomic,strong) ZW_Label *BeneficiaryLabel;  // ---- 收款方 & 受理方

@property (nonatomic,strong) ZW_Label *passwordLabel;  // ---- 交易密码

@property (nonatomic,strong) UILabel *canExchangeLabel; // ---- 可兑换多少元

@property (nonatomic,strong) ZW_TextField *BonusNumerTextField;  // ---- 积分 & 现金 输入框 

@property (nonatomic,strong) ZW_TextField *passwordTextField;    // ---- 交易密码输入框

@property (nonatomic,strong) UIButton *submitButton ;  // ---- 提交按钮

@property (nonatomic,strong) ZW_Label *selectBankLabel; // ---- 选择银行


@property (nonatomic,strong) ZW_TextField *selectBankTextField;

@property (nonatomic,strong) UIView *selectLeftView;

@property (nonatomic,strong)NSString *cardIDStr;
@end

@implementation BonusExchangeViewController

-(NoticeView *)titleView {
    if ( _titleView == nil ) {
        _titleView = [[NoticeView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 45) withNav:NO];
        [self.view addSubview:_titleView];
    }
    
    
    return _titleView;
}

-(ZW_Label *)payerLabel {
    if ( _payerLabel == nil ) {
        _payerLabel = [[ZW_Label alloc]initWithStr:[NSString stringWithFormat:@"%@：%@",_withdrawDepositStr,[NameSingle shareInstance].name] addSubView:self.view];
    }
    
    return _payerLabel;
}

-(ZW_Label *)BonusNumerLabel {
    if ( _BonusNumerLabel == nil ) {
        _BonusNumerLabel = [[ZW_Label alloc]initWithStr:[NSString stringWithFormat:@"%@：",_withdrawDepositNumerStr] addSubView:self.view];
    }
    return _BonusNumerLabel;
}

-(ZW_Label *)BeneficiaryLabel {
    if ( _BeneficiaryLabel == nil ) {
        _BeneficiaryLabel = [[ZW_Label alloc]initWithStr:[NSString stringWithFormat:@"%@：%@",_manageStr,_model.frealname] addSubView:self.view];
    }
    return _BeneficiaryLabel;
}

-(ZW_Label *)passwordLabel {
    if ( _passwordLabel == nil ) {
        _passwordLabel = [[ZW_Label alloc]initWithStr:@"交易密码：" addSubView:self.view];
    }
    return _passwordLabel;
}

-(UILabel *)canExchangeLabel {
    if ( _canExchangeLabel == nil ) {
        _canExchangeLabel = [[UILabel alloc]init];
        _canExchangeLabel.text = @"可兑换0.000元";
        _canExchangeLabel.hidden = YES;
        _canExchangeLabel.font  = [UIFont systemFontOfSize:12.0];
        _canExchangeLabel.textColor = [ManagerEngine getColor:@"999999"];
        if ([_ViewControllerTitle isEqualToString:@"积分兑现"]) {
            [self.view addSubview:_canExchangeLabel];

        }

    }
    return _canExchangeLabel;
}

-(ZW_TextField *)BonusNumerTextField {
    if ( _BonusNumerTextField == nil ) {
        _BonusNumerTextField = [[ZW_TextField alloc]initWithPlaceholder:[NSString stringWithFormat:@"请输入%@数额",_ViewControllerTitle] isType:isMoneyType addSubView:self.view];
        _BonusNumerTextField.delegate = self;
    }
    return _BonusNumerTextField;
}

-(ZW_TextField *)passwordTextField {
    if ( _passwordTextField == nil ) {
        _passwordTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入交易密码" isType:isPasswordType addSubView:self.view];
    }
    return _passwordTextField;
}

-(UIButton *)submitButton {
    
    if ( _submitButton == nil ) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 5 ;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_submitButton];
    }
    
    return _submitButton;
}

-(ZW_Label *)selectBankLabel {
    if ( _selectBankLabel == nil ) {
        _selectBankLabel = [[ZW_Label alloc]initWithStr:@"商家账户：" addSubView:self.view];
    }
    
    return _selectBankLabel;
}

-(UIView *)selectLeftView {
    if ( _selectLeftView == nil ) {
        _selectLeftView = [[UIView alloc]init];
        _selectLeftView.backgroundColor = [UIColor whiteColor];
        _selectLeftView.layer.masksToBounds = YES;
        _selectLeftView.layer.cornerRadius = 5;
        _selectLeftView.layer.borderColor = [ManagerEngine getColor:@"cccccc"].CGColor;
        _selectLeftView.layer.borderWidth = 0.5;
        [self.view addSubview:_selectLeftView];
        
    }
    
    return _selectLeftView ;
}
-(ZW_TextField *)selectBankTextField {
    if ( _selectBankTextField == nil ) {
        _selectBankTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请选择商家账户" isType:isMobileType addSubView:self.view];
//        _selectBankTextField.placeholder = @"请选择商家账户";
//        [_selectLeftView addSubview:_selectBankTextField];
//        _selectBankTextField.delegate = self;
//        _selectBankTextField.tag = 3;
  
        [_selectBankTextField setRightViewWithimageName:@"icon_drop_right"];
     

    }
    
    return _selectBankTextField;
}
#pragma mark --
#pragma mark --- 积分及名称请求
-(void)BonusExchangeRequst {
    
    [BonusExchangeViewModel bonusExchaneViewmodelRequstandViewControllerTitle:_ViewControllerTitle AndBack:^(id sender) {
        _model = sender;
        if ([_ViewControllerTitle isEqualToString:@"积分兑现"]) {
            
            [self.titleView setTitleStr:[NSString stringWithFormat:@"当前商家账户有%.2f个积分",[_model.bonus floatValue]] andisNav:NO andColor:[ManagerEngine getColor:@"fff2b2"]];
            
        } else {
            
            [self.titleView setTitleStr:[NSString stringWithFormat:@"当前商家账户有%.2f元现金",[_model.cash floatValue]] andisNav:NO andColor:[ManagerEngine getColor:@"fff2b2"]];

            
        }
        [self setViewframe];

    }];
  
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([_ViewControllerTitle isEqualToString:@"积分兑现"]) {
        
        _withdrawDepositStr = @"支付方";
        
        _withdrawDepositNumerStr = @"积分数";
        
        _manageStr = @"收款方";
        

        
    } else {
        _withdrawDepositStr = @"提现方";
        
        _withdrawDepositNumerStr = @"提现金额";
        
        _manageStr = @"受理方";
    }
    
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.zw_title = _ViewControllerTitle;
    
    _model = [[BonusExchangeModel alloc]init];
    

    [self BonusExchangeRequst];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectInfo:) name:@"selectbank" object:nil];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark --
#pragma mark --- 信号创建
-(void)signalSet {
    
   
    RACSignal *validBounsSignal = [self.BonusNumerTextField.rac_textSignal map:^id(NSString *value) {
       
        if ([value isEqualToString:@""]) {
            self.canExchangeLabel.text = [NSString stringWithFormat:@"可兑现0.000元"];
        } else {
                self.canExchangeLabel.text = [NSString stringWithFormat:@"可兑现%.3f元",[value doubleValue] / 2 ];
           
        }
        [self updateCash];
        return @([self textFieldChanged:value]);
    }];
    RACSignal *validPswSignal = [self.passwordTextField.rac_textSignal map:^id(id value) {
        
        return @([self isValidPsw:value]);
    }];
    
    RAC(self.canExchangeLabel,textColor) = [validBounsSignal map:^id(NSNumber *values) {
        return [values boolValue]?DefaultAPPColor:[ManagerEngine getColor:@"999999"];
    }];
    
    RACSignal *signUp = [RACSignal combineLatest:@[validBounsSignal,validPswSignal] reduce:^id(NSNumber *bounsValid,NSNumber *pswValid){
        return @([bounsValid boolValue]&&[pswValid boolValue]);
    }];
    [signUp subscribeNext:^(NSNumber * signUpActive) {
        self.submitButton.enabled = [signUpActive boolValue];
        if ([signUpActive boolValue]) {
            self.submitButton.backgroundColor = DefaultAPPColor;
            
        } else {
            self.submitButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
            
        }
        
    }];
    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ManagerEngine loadDateView:self.submitButton andPoint:CGPointMake(self.submitButton.frame.size.width/2, self.submitButton.frame.size.height/2)];
        
        if ([self.BonusNumerTextField.text doubleValue] < 0 ) {
            [ManagerEngine dimssLoadView:self.submitButton andtitle:@"提交"];
            [SVProgressHUD showErrorWithStatus:@"数额要大于 0"];
        } else {
            
          
            [BonusExchangeViewModel bonusExchangSubmitRequstWithAmount:self.BonusNumerTextField.text andPassword:self.passwordTextField.text andViewControllerTitle:_ViewControllerTitle andcardId:self.cardIDStr andbonusBlock:^(NSDictionary * dic) {
                
                if ([dic[@"error"]integerValue] == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                    [ManagerEngine SVPAfter:@"提交成功" complete:^{
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                } else {
                    [ManagerEngine dimssLoadView:self.submitButton andtitle:@"提交"];

                    [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
                }

            }];
        }
        
        
        
        
    }];
    
    
    
}
-(BOOL)isValidPsw:(NSString *)text {
    if (text.length==6) {
        return YES;
    } else if (text.length >6) {
        
        [ManagerEngine homeSvpStr:@"交易密码不能超过6位数" andcenterView:self.view andStyle:promptViewDefault];
        return NO;
    } else {
        return NO;
        
    }
    
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



-(void)setViewframe {
    CGFloat payLabelWith = [ManagerEngine setTextWidthStr:self.payerLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    CGFloat bonusWidth = [ManagerEngine setTextWidthStr:self.BonusNumerLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
     CGFloat passwordWidth = [ManagerEngine setTextWidthStr:self.passwordLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    self.payerLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,75 + kNAVHEIGHT).heightIs(17).widthIs(payLabelWith);
    

    self.BonusNumerLabel.sd_layout.leftEqualToView(self.payerLabel).topSpaceToView(self.payerLabel,30 + (44 - 17) / 2).heightIs(17).widthIs(bonusWidth);
    
    self.BonusNumerTextField.sd_layout.leftSpaceToView(self.BonusNumerLabel,0).topSpaceToView(self.payerLabel,30).heightIs(44).widthIs(WIDTH - bonusWidth - kEDGE *2);

    
    [self updateCash];
    
    
    self.selectBankLabel.sd_layout.leftEqualToView(self.BonusNumerLabel).topSpaceToView(self.BonusNumerTextField,30 + (44 - 17) / 2).heightIs(17).widthIs(passwordWidth);
    
    
    self.selectBankTextField.sd_layout.leftSpaceToView(self.selectBankLabel,0).topSpaceToView(self.BonusNumerTextField,30).heightIs(44).widthIs(WIDTH - passwordWidth - kEDGE *2);
    
    CGFloat beneficiaryWidth = [ManagerEngine setTextWidthStr:self.BeneficiaryLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.BeneficiaryLabel.sd_layout.leftEqualToView(self.selectBankLabel).topSpaceToView(self.selectBankTextField,30).heightIs(17).widthIs(beneficiaryWidth);
    
    
    self.passwordLabel.sd_layout.leftEqualToView(self.BeneficiaryLabel).topSpaceToView(self.BeneficiaryLabel,30 + (44 - 17)/2).heightIs(17).widthIs(passwordWidth);

    self.passwordTextField.sd_layout.leftSpaceToView(self.passwordLabel,0).topSpaceToView(self.BeneficiaryLabel,30).heightIs(44).widthIs(WIDTH - passwordWidth - kEDGE * 2);
    
    self.submitButton.sd_layout.leftEqualToView(self.passwordLabel).topSpaceToView(self.passwordTextField,40).heightIs(44).widthIs(WIDTH - kEDGE * 2);
    
    
#pragma mark --
#pragma mark --- 选择银行

    
    [self.selectBankTextField isMaskBtn:^{
        SelectBankViewController *selectVC = [[SelectBankViewController alloc]init];
        [self.navigationController pushViewController:selectVC animated:YES];
    }];
    
    
    [self signalSet];

    
}

#pragma mark --
#pragma mark --- 更新 现金 值数额
-(void)updateCash {
    self.canExchangeLabel.hidden = NO;
    CGFloat cashWidth = [ManagerEngine setTextWidthStr:self.canExchangeLabel.text andFont:[UIFont systemFontOfSize:12.0]];
    self.canExchangeLabel.sd_layout.leftSpaceToView(self.view,WIDTH - kEDGE - cashWidth).topSpaceToView(self.BonusNumerTextField,(30 - 12) / 2).heightIs(12).widthIs(cashWidth);
    
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
                if(!isHaveDian)//text中还没有小数点
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
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.passwordTextField resignFirstResponder];
    [self.BonusNumerTextField resignFirstResponder];
    
}

-(void)selectInfo:(NSNotification *)info {
    
    HQJLog(@"我的选择是：%@",info.userInfo);
    NSString *texts = [NSString stringWithFormat:@"%@(尾号%@)",info.userInfo[@"payName"],info.userInfo[@"payAccount"]];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:texts];
    
    NSRange range = [texts rangeOfString:[NSString stringWithFormat:@"(尾号%@)",info.userInfo[@"payAccount"]]];
    
    [attributeString setAttributes:@{NSForegroundColorAttributeName:[ManagerEngine getColor:@"999999"],NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:range];
    self.cardIDStr = info.userInfo[@"id"];
    self.selectBankTextField.attributedText = attributeString;
    [self.selectBankTextField setLeftViewWithimageName:info.userInfo[@"icon"]];
    
}



@end
