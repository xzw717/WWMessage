//
//  CashSalesViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CashSalesViewController.h"
#import "CustomerModel.h"
#import "CustomerViewModel.h"
#import "UIButton+touch.h"

@interface CashSalesViewController ()<UITextFieldDelegate>
{
    BOOL isHaveDian;
}
@property (nonatomic,strong) ZW_Label * paymentLabel; // --- 支付方

@property (nonatomic,strong) ZW_Label * payFigurelabel; // --- 付款金额

@property (nonatomic,strong) ZW_Label * BeneficiaryLabel; // --- 收款方

@property (nonatomic,strong) UIImageView *headerImage; // ---- 头像标志

@property (nonatomic,strong) UILabel *nameLabel; // ---- 名字

@property (nonatomic,strong) ZW_Label * pswLabel; // ---- 支付密码

@property (nonatomic,strong) UILabel * ZHlabel; // ---- 赠送多少ZH值

@property (nonatomic,strong) ZW_TextField *paymentTextField;  // ---- 支付方手机号

@property (nonatomic,strong) ZW_TextField *payFigureTextField; // ---- 支付金额

@property (nonatomic,strong) ZW_TextField *pswTextField; // ---- 支付密码

@property (nonatomic,strong) UIButton *submitButton; // ---- 提交按钮

@property (nonatomic,strong) CustomerModel *model; //   --- 数据模型

@property (nonatomic,copy) NSString *ZHRatio;

@end

@implementation CashSalesViewController


-(ZW_Label *)paymentLabel {
    if( _paymentLabel == nil ) {
        _paymentLabel = [[ZW_Label alloc]initWithStr:@"支 付 方：" addSubView:self.view];
    }
    return _paymentLabel;
}
-(ZW_TextField *)paymentTextField {
    if ( _paymentTextField == nil ) {
        _paymentTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入支付方手机号码" isType:isMobileType addSubView:self.view];
    }
    
    return _paymentTextField;
}
-(UIImageView *)headerImage {
    if ( _headerImage == nil ) {
        _headerImage = [[UIImageView alloc]init];
        _headerImage.image = [UIImage imageNamed:@"icon_name"];
        [self.view addSubview:_headerImage];
    }
    
    return _headerImage;
}

-(UILabel *)nameLabel {
    if (_nameLabel == nil ) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DefaultAPPColor;
        _nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

-(ZW_Label *)payFigurelabel {
    if ( _payFigurelabel == nil ) {
        _payFigurelabel = [[ZW_Label alloc]initWithStr:@"付款金额：" addSubView:self.view];
    }
    
    return _payFigurelabel;
}

-(ZW_TextField *)payFigureTextField {
    if ( _payFigureTextField == nil ) {
        _payFigureTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入付款数额" isType:isMoneyType addSubView:self.view];
        _payFigureTextField.delegate = self;
        
    }
    return _payFigureTextField;
}

-(UILabel *)ZHlabel {
    if ( _ZHlabel == nil ) {
        _ZHlabel = [[UILabel alloc]init];
        _ZHlabel.text = @"赠送0.00RY值";
        _ZHlabel.font  = [UIFont systemFontOfSize:12.0];
        _ZHlabel.textColor = [ManagerEngine getColor:@"999999"];
        [self.view addSubview:_ZHlabel];
        
    }
    
    return _ZHlabel;
}


-(ZW_Label *)BeneficiaryLabel {
    if ( _BeneficiaryLabel == nil ) {
        _BeneficiaryLabel = [[ZW_Label alloc]initWithStr:[NSString stringWithFormat:@"收 款 方：%@",[NameSingle shareInstance].name] addSubView:self.view];
    }
    
    
    return _BeneficiaryLabel;
}

-(ZW_Label *)pswLabel {
    if ( _pswLabel == nil ) {
        _pswLabel = [[ZW_Label alloc]initWithStr:@"交易密码：" addSubView:self.view];
    }
    
    return _pswLabel;
}
-(ZW_TextField *)pswTextField {
    if ( _pswTextField == nil ) {
        _pswTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入交易密码" isType:isPasswordType addSubView:self.view];
        
    }
    
    return _pswTextField;
}

-(UIButton *)submitButton {
    
    if ( _submitButton == nil ) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 5 ;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.timeInterval = 2.0;
        [self.view addSubview:_submitButton];
    }
    
    return _submitButton;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.zw_title = @"现金销售";

    [self intoRequst];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.zw_title = @"现金销售";

    
    self.view.backgroundColor = DefaultBackgroundColor;
    
    [self setViewFrame];
    
    [self signalSet];
}

#pragma mark --
#pragma mark ---  内容布局
-(void)setViewFrame {
    CGFloat labelWidth = [ManagerEngine setTextWidthStr:self.payFigurelabel.text andFont:[UIFont systemFontOfSize:17]];
    self.paymentLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,30 + kNAVHEIGHT + (44 - 17 )/2).heightIs(17).widthIs(labelWidth);
    
    self.paymentTextField.sd_layout.leftSpaceToView(self.paymentLabel,0).topSpaceToView(self.view,30 + kNAVHEIGHT).heightIs(44).widthIs(WIDTH - kEDGE * 2 - labelWidth);
    
    [self updateName];
    
    self.payFigurelabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.paymentTextField,30  + (44 - 17 )/2).heightIs(17).widthIs(labelWidth);
    
    self.payFigureTextField.sd_layout.leftSpaceToView(self.payFigurelabel,0).topSpaceToView(self.paymentTextField,30 ).heightIs(44).widthIs(WIDTH - kEDGE * 2 - labelWidth);
    
    [self updateZH];
    
    CGFloat BusinessWidth = [ManagerEngine setTextWidthStr:self.BeneficiaryLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    self.BeneficiaryLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.payFigureTextField,30).heightIs(17).widthIs(BusinessWidth);
    
    self.pswLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.BeneficiaryLabel,30  + (44 - 17 )/2).heightIs(17).widthIs(labelWidth);
    
    self.pswTextField.sd_layout.leftSpaceToView(self.pswLabel,0).topSpaceToView(self.BeneficiaryLabel,30 ).heightIs(44).widthIs(WIDTH - kEDGE * 2 - labelWidth);
    
    self.submitButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.pswTextField,40).heightIs(44).widthIs(WIDTH - kEDGE * 2);
    
    
    
}

#pragma mark --
#pragma mark --- 更新名字和图标布局
-(void)updateName {
    CGFloat nameWidth = [ManagerEngine setTextWidthStr:self.nameLabel.text andFont:[UIFont systemFontOfSize:12.0]];
    if (nameWidth == 0 ) {
        self.headerImage.sd_layout.leftSpaceToView(self.view,WIDTH - kEDGE - 18).topSpaceToView(self.paymentTextField,5).heightIs(18).widthIs(18);
        self.nameLabel.sd_layout.leftSpaceToView(self.headerImage,5).topSpaceToView(self.paymentTextField,5 + (18 - 12)/2).heightIs(12).widthIs(0);

    } else {
        
        self.headerImage.sd_layout.leftSpaceToView(self.view,WIDTH - kEDGE - 18 - 5 - nameWidth).topSpaceToView(self.paymentTextField,5).heightIs(18).widthIs(18);
        
        self.nameLabel.sd_layout.leftSpaceToView(self.headerImage,5).topSpaceToView(self.paymentTextField,5 + (18 - 12)/2).heightIs(12).widthIs(nameWidth);
    }
}

#pragma mark --
#pragma mark --- 更新 ZH 值数额 
-(void)updateZH {
    CGFloat ZHWidth = [ManagerEngine setTextWidthStr:self.ZHlabel.text andFont:[UIFont systemFontOfSize:12.0]];
    
    self.ZHlabel.sd_layout.leftSpaceToView(self.view,WIDTH - kEDGE - ZHWidth).topSpaceToView(self.payFigureTextField,10).heightIs(12).widthIs(ZHWidth);
    
}



#pragma mark --
#pragma mark --- 信号创建 
-(void)signalSet {
    
    RACSignal *validMobileSignal = [self.paymentTextField.rac_textSignal map:^id(id value) {
        if ([ManagerEngine valiMobile:value]) {
            [self customermobileRequst];
        } else {
            self.nameLabel.text = @"";
            [self updateName];
        }
    
        return @([ManagerEngine valiMobile:value]);
    }];
    RACSignal *validBounsSignal = [self.payFigureTextField.rac_textSignal map:^id(NSString *value) {
        
        if ([value isEqualToString:@""]) {
            self.ZHlabel.text = [NSString stringWithFormat:@"赠送0.00RY值"];
        } else {
            if (_ZHRatio) {
                self.ZHlabel.text = [NSString stringWithFormat:@"赠送%.5fRY值",[value doubleValue] / 2 * [_ZHRatio doubleValue]];

            } else{
                [SVProgressHUD showErrorWithStatus:@"RY比例获取失败"];
            }
        }
        [self updateZH];
        return @([self textFieldChanged:value]);
    }];
    RACSignal *validPswSignal = [self.pswTextField.rac_textSignal map:^id(id value) {
      
        return @([self isValidPsw:value]);
    }];
    
    RAC(self.ZHlabel,textColor) = [validBounsSignal map:^id(NSNumber *values) {
        return [values boolValue]?DefaultAPPColor:[ManagerEngine getColor:@"999999"];
    }];
  
    RACSignal *signUp = [RACSignal combineLatest:@[validMobileSignal,validBounsSignal,validPswSignal] reduce:^id(NSNumber *MobileValid,NSNumber *bounsValid,NSNumber *pswValid){
        return @([MobileValid boolValue]&&[bounsValid boolValue]&&[pswValid boolValue]);
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
        
        if ([self.payFigureTextField.text doubleValue] < 0 ) {
            [ManagerEngine dimssLoadView:self.submitButton andtitle:@"提交"];
            [SVProgressHUD showErrorWithStatus:@"付款金额要大于 0"];
        } else {
            [self submitRequst];
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
#pragma mark --
#pragma mark ---UITextFiled Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([self.payFigureTextField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
        
    {
        if ([self.payFigureTextField.text length]>7)
        {
            [ManagerEngine homeSvpStr:@"亲，输入超出限制了哟" andcenterView:self.view andStyle:promptViewDefault];
            
            return NO;
        }
        
        
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            
            
            if (single=='.')
            {
                if( !isHaveDian )//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [ManagerEngine homeSvpStr:@"亲，您已经输入过小数点了" andcenterView:self.view andStyle:promptViewDefault];
                    
                    [self.payFigureTextField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[self.payFigureTextField.text rangeOfString:@"."];
                    
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
            [self.payFigureTextField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
            
        }
        
    }
    
    else
    {
        return YES;
        
    }
    
}

#pragma mark --
#pragma mark --- 每次进入请求比例
-(void)intoRequst {
    
    [CustomerViewModel intoRequstZHRatio:^(id sender) {

        _ZHRatio = sender;
    
    }];
    
}


#pragma mark --
#pragma mark --- 输完手机号请求
-(void)customermobileRequst {
    [CustomerViewModel customerrequstNumer:self.paymentTextField.text andSender:^(id sender) {
        _model = sender;
        self.nameLabel.text = _model.realname;
        [self updateName];
    }];
}

#pragma mark --
#pragma mark --- 提交
-(void)submitRequst {
    
    NSString *ZHStr =  [NSString stringWithFormat:@"%.5f",[self.payFigureTextField.text doubleValue] / 2 * [_ZHRatio doubleValue]];
    [CustomerViewModel submitRequstCustomerid:_model.memberid andZH:ZHStr andPsw:self.pswTextField.text andAmount:self.payFigureTextField.text andReturn:^(id sender) {

        
        if ([sender isEqualToString:@"操作成功"]) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [ManagerEngine SVPAfter:@"提交成功" complete:^{
                [ManagerEngine dimssLoadView:self.submitButton andtitle:@"提交"];

                [self.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            [ManagerEngine dimssLoadView:self.submitButton andtitle:@"提交"];

            [SVProgressHUD showErrorWithStatus:sender];
        }
    }];
    
}

@end
