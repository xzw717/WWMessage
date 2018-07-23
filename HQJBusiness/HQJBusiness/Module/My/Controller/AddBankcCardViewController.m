//
//  AddBankcCardViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/28.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddBankcCardViewController.h"
#import "pickerView.h"
#import "NSString+RegexCategory.h"
#import "JKCountDownButton.h"

@interface AddBankcCardViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *topBackgroundView;

@property (nonatomic,strong) UIView *bottomBackgroundView;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIView *lineViews;

@property (nonatomic,strong) ZW_Label *selectBankLabel;

@property (nonatomic,strong) ZW_Label *nameLable;

@property (nonatomic,strong) ZW_Label *cardLabel;

@property (nonatomic,strong) ZW_Label *branchLabel;

@property (nonatomic,strong) ZW_TextField *nameTextField;

@property (nonatomic,strong) ZW_TextField *selectBankTextField;

@property (nonatomic,strong) ZW_TextField *cardTextField;

@property (nonatomic,strong) ZW_TextField * branchTextField;

@property (nonatomic,strong) pickerView *pickView;

@property (nonatomic,strong) NSMutableArray *bankNameListArray ;

@property (nonatomic,strong) NSMutableArray *bankidListArray ;

@property (nonatomic,strong) NSString *bankIdStr;

@property (nonatomic,strong) UIButton *okButton ;  // ---- 下一步按钮
/// 验证码背景
@property (nonatomic, strong) UIView *verificationCodeBgView;
/// 验证码
@property (nonatomic,strong) ZW_TextField *verificationCodeTextField;
/// 获取验证码
@property (nonatomic,strong) JKCountDownButton *getCodeButton;


@end

@implementation AddBankcCardViewController


- (UIView *)topBackgroundView {
    if (_topBackgroundView == nil) {
        _topBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVHEIGHT + kEDGE , WIDTH, 44)];
        _topBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _topBackgroundView;
}
- (UIView *)bottomBackgroundView {
    if (_bottomBackgroundView == nil ) {
        _bottomBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kNAVHEIGHT + kEDGE * 2 + 44 , WIDTH, 44 * 3)];
        _bottomBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomBackgroundView;
}

- (UIView *)verificationCodeBgView {
    if (_verificationCodeBgView == nil ) {
        _verificationCodeBgView = [[UIView alloc]init];
        _verificationCodeBgView.backgroundColor = [UIColor whiteColor];
    }
    return _verificationCodeBgView;
}
- (ZW_TextField *)verificationCodeTextField {
    
    if ( _verificationCodeTextField == nil ) {
        _verificationCodeTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入验证码" isType:isMobileType addSubView:_bottomBackgroundView];
        _verificationCodeTextField.borderStyle = UITextBorderStyleNone;
        
    }
    
    return _verificationCodeTextField;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(kEDGE, 44 , WIDTH - kEDGE, 0.5)];
        _lineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _lineView;
}

- (UIView *)lineViews {
    if (_lineViews == nil) {
        _lineViews = [[UIView alloc]initWithFrame:CGRectMake(kEDGE, 44 * 2 , WIDTH - kEDGE, 0.5)];
        _lineViews.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _lineViews;
}


- (ZW_Label *)selectBankLabel {
    if ( _selectBankLabel == nil) {
        _selectBankLabel = [[ZW_Label alloc]initWithStr:@"选择银行：" addSubView:_topBackgroundView];
    }
    
    
    return _selectBankLabel;
}

- (ZW_Label *)nameLable {
    if ( _nameLable == nil) {
        _nameLable = [[ZW_Label alloc]initWithStr:@"持卡人：" addSubView:_bottomBackgroundView];
    }
    
    return _nameLable;
}

- (ZW_Label *)cardLabel {
    if ( _cardLabel == nil) {
        _cardLabel = [[ZW_Label alloc]initWithStr:@"银行卡号：" addSubView:_bottomBackgroundView];
    }
    return _cardLabel;
}

- (ZW_Label *)branchLabel {
    if (_branchLabel == nil) {
        _branchLabel = [[ZW_Label alloc]initWithStr:@"支行：" addSubView:_bottomBackgroundView];
    }
    return _branchLabel;
}


- (ZW_TextField *)selectBankTextField {
    if ( _selectBankTextField == nil ) {
        _selectBankTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请选择银行类型" isType:isMobileType addSubView:_topBackgroundView];
        _selectBankTextField.borderStyle = UITextBorderStyleNone;
        [_selectBankTextField setRightViewWithimageName:@"icon_drop_down"];

    }
    
    return _selectBankTextField;
}

- (ZW_TextField *)nameTextField {
    
    if ( _nameTextField == nil ) {
        _nameTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入持卡人姓名" isType:isMobileType addSubView:_bottomBackgroundView];
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.borderStyle = UITextBorderStyleNone;

    }
    
    return _nameTextField;
}

- (ZW_TextField *)cardTextField {
    
    if ( _cardTextField == nil ) {
        _cardTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入银行卡号" isType:isMobileType addSubView:_bottomBackgroundView];
        _cardTextField.borderStyle = UITextBorderStyleNone;

    }
    
    return _cardTextField;
}

- (ZW_TextField *)branchTextField {
    if (_branchTextField == nil) {
        _branchTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入支行" isType:isMobileType addSubView:_bottomBackgroundView];
        _branchTextField.keyboardType = UIKeyboardTypeDefault;
        _branchTextField.borderStyle = UITextBorderStyleNone;
    }
    return _branchTextField;
}

- (UIButton *)okButton {
    
    if ( _okButton == nil) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
        _okButton.layer.masksToBounds = YES;
        _okButton.layer.cornerRadius = 5 ;
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [self.view addSubview:_okButton];
    }
    
    return _okButton;
}

- (JKCountDownButton *)getCodeButton {
    if ( _getCodeButton == nil ) {
        _getCodeButton =[JKCountDownButton buttonWithType: UIButtonTypeCustom];
        _getCodeButton.backgroundColor = [UIColor whiteColor];
        _getCodeButton.layer.masksToBounds = YES;
        _getCodeButton.layer.cornerRadius = 5.f;
        _getCodeButton.layer.borderColor = DefaultAPPColor.CGColor;
        _getCodeButton.layer.borderWidth = 0.5f;
        _getCodeButton.titleLabel.font = [UIFont systemFontOfSize:13.5f];
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        [_getCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            self.getCodeButton.enabled = NO;
            [self getcodeRequst];
            
        }];
    }
    
    return _getCodeButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.zw_title = @"添加银行卡";

    self.bankNameListArray = [NSMutableArray array];
    
    self.bankidListArray = [NSMutableArray array];
    
    
    [self bankNameRequst];
}

-(void)setView {
    
    
    [self.view addSubview:self.topBackgroundView];
    
    [self.view addSubview:self.bottomBackgroundView];
    
    [self.view addSubview:self.verificationCodeBgView];
    
    [self.verificationCodeBgView addSubview:self.verificationCodeTextField];
    
    [self.verificationCodeBgView addSubview:self.getCodeButton];
    
    [self.bottomBackgroundView addSubview:self.lineView];
    
    [self.bottomBackgroundView addSubview:self.lineViews];
    
    CGFloat bankWidth = [ManagerEngine setTextWidthStr:self.selectBankLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    
    self.selectBankLabel.sd_layout.leftSpaceToView(self.topBackgroundView,kEDGE).topSpaceToView(self.topBackgroundView,(44 - 17) / 2 ).heightIs(17).widthIs(bankWidth);
    
    self.selectBankTextField.sd_layout.leftSpaceToView(self.selectBankLabel,0).topSpaceToView(self.topBackgroundView,0).heightIs(44).widthIs(WIDTH - bankWidth - kEDGE);
    
    @WeakObj(self);
    [self.selectBankTextField isMaskBtn:^{
        
        [self lostTheFirstResponse];
        
        _pickView = [[pickerView alloc]initWithFrame:CGRectMake(self.selectBankTextField.mj_x, self.selectBankTextField.mj_y+self.selectBankTextField.mj_h + kNAVHEIGHT + kEDGE, self.selectBankTextField.mj_w - kEDGE * 2 , _bankNameListArray.count * 45 > HEIGHT/2 ?HEIGHT/2 : _bankNameListArray.count * 45) andTitleAry:_bankNameListArray];
        
        [_pickView showView];
        
        [_pickView setSenderBlock:^(id sender) {
            selfWeak.selectBankTextField.text =  selfWeak.bankNameListArray[[sender integerValue]];
            selfWeak.bankIdStr = selfWeak.bankidListArray[[sender integerValue]];
            
        }];
        
    }];
    
    CGFloat nameWidth = [ManagerEngine setTextWidthStr:self.nameLable.text andFont:[UIFont systemFontOfSize:17.0]];
    CGFloat cardWidth = [ManagerEngine setTextWidthStr:self.cardLabel.text andFont:[UIFont systemFontOfSize:17.0]];

    self.branchLabel.sd_layout.leftSpaceToView(self.bottomBackgroundView,kEDGE).topSpaceToView(self.bottomBackgroundView,(44 - 17 )/ 2).heightIs(17).widthIs(self.branchLabel.text.length * 17.5f);
    
    self.branchTextField.sd_layout.leftSpaceToView(self.branchLabel,0).topSpaceToView(self.bottomBackgroundView,0).heightIs(44).widthIs(WIDTH - self.branchLabel.text.length * 17.5f - kEDGE);
    
    
    self.nameLable.sd_layout.leftSpaceToView(self.bottomBackgroundView,kEDGE).topSpaceToView(self.branchTextField,(44 - 17 )/ 2).heightIs(17).widthIs(nameWidth);
    
    self.nameTextField.sd_layout.leftSpaceToView(self.nameLable,0).topSpaceToView(self.lineView,0).heightIs(44).widthIs(WIDTH - nameWidth - kEDGE);
    
    
    
    self.cardLabel.sd_layout.leftSpaceToView(self.bottomBackgroundView,kEDGE).topSpaceToView(self.lineViews,(44 - 17) / 2).heightIs(17).widthIs(cardWidth);
    
    
    self.cardTextField.sd_layout.leftSpaceToView(self.cardLabel,0).topSpaceToView(self.lineViews,0).heightIs(44).widthIs(WIDTH - cardWidth - kEDGE);
    
    self.verificationCodeBgView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.bottomBackgroundView, kEDGE).heightIs(44);
    
    self.verificationCodeTextField.sd_layout.leftSpaceToView(self.verificationCodeBgView, kEDGE).topSpaceToView(self.verificationCodeBgView, 0).rightSpaceToView(self.getCodeButton, kEDGE).heightIs(44);
    
    self.getCodeButton.sd_layout.rightSpaceToView(self.verificationCodeBgView, kEDGE).centerYIs(self.verificationCodeBgView.centerY_sd).heightIs(30).widthIs(90);
    
    self.okButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.verificationCodeBgView,30).heightIs(44).widthIs(WIDTH - kEDGE * 2);

    
    [self initSignal];

}


-(void)bankNameRequst {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBBankAccountInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlString complete:^(NSDictionary *dic) {
        
        
        NSArray *resultAry = dic[@"result"];
        for (NSDictionary *dicOne in resultAry) {
            
            [self.bankidListArray addObject:dicOne[@"id"]];
            [self.bankNameListArray addObject:dicOne[@"bankName"]];
            
            
        }
        
        
        
        
        [self setView];

    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
    
}

-(void)initSignal {
    
    RACSignal *branchSignal = [self.branchTextField.rac_textSignal map:^id(id value) {
        return self.branchTextField.text.length > 0 ? @(YES) : @(NO);
    }];
    
    
    
    
    RACSignal *signalNameValue = [self.nameTextField.rac_textSignal map:^id(id value) {
        return @([self isNameValid:value]);
    }];

    
    
    RACSignal *signalCardValue = [self.cardTextField.rac_textSignal map:^id(id value) {

        return self.cardTextField.text.length >=16 && self.cardTextField.text.length <= 19 ? @(1) : @(0);
    }];
    
    RACSignal *verificationCodeValue = [self.verificationCodeTextField.rac_textSignal map:^id(id value) {
        
        return self.verificationCodeTextField.text.length > 0 && self.verificationCodeTextField.text.length <= 6 ? @(1) : @(0);
    }];
    
    
    RACSignal *upSignal = [RACSignal combineLatest:@[branchSignal,signalNameValue,signalCardValue,verificationCodeValue] reduce:^id(NSNumber *brabchNumber,NSNumber *nameNumer,NSNumber *cardNumer,NSNumber *verificationCodeNumer){
        return @([brabchNumber boolValue] && [nameNumer boolValue] && [cardNumer boolValue] && [verificationCodeNumer boolValue]);
        
    }];
    
    [upSignal subscribeNext:^(NSNumber *ups) {
        if ([ups boolValue]) {
            self.okButton.backgroundColor = DefaultAPPColor;
        } else {
            self.okButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];

        }
    }];
    [[self.okButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {

        if (![self.selectBankTextField.text isEqualToString:@""]) {
            if ([self isNameValid:self.nameTextField.text]) {
               
                
                
                if(self.cardTextField.text.length >=16 && self.cardTextField.text.length <=19) {
                    if (self.verificationCodeTextField.text.length > 0) {
                            [self addBankCardRequst];

                    } else {
                        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];

                    }

                    } else {
                        
                    [ManagerEngine dimssLoadView:self.okButton andtitle:@"确定"];
                    [SVProgressHUD showErrorWithStatus:@"请输入正确的卡号"];
                }
                
                
            } else {
              
                    if(self.cardTextField.text.length >=16 && self.cardTextField.text.length <=19) {
                        
                        [ManagerEngine dimssLoadView:self.okButton andtitle:@"确定"];
                        
                        [SVProgressHUD showErrorWithStatus:@"请输入正确的名字"];
                    
                  
                    
                } else {
                    [ManagerEngine dimssLoadView:self.okButton andtitle:@"确定"];
                    
                    [SVProgressHUD showErrorWithStatus:@"请输入正确的名字和卡号"];
                    
                }
            }
            

        } else {
            [ManagerEngine dimssLoadView:self.okButton andtitle:@"确定"];

            [SVProgressHUD showErrorWithStatus:@"请选择银行卡类型"];

        }
      
    }];
    
}


#pragma mark --- 获取验证码
- (void)getcodeRequst {
    
    
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@?mobile=%@&membertype=1&realname=%@",HQJBBonusDomainName,@"/merchant/getSMS",[NameSingle shareInstance].mobile,[NameSingle shareInstance].name];
    NSDictionary *dict = @{@"mobile":[NameSingle shareInstance].mobile,@"membertype":@1,@"realname":[NameSingle shareInstance].name};
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetSMSInterface];
//    HQJLog(@"------%@",dict[@"realname"]);
    @weakify(self);
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        @strongify(self);
        if([dic[@"code"]integerValue] != 49000) {
            
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            
            [self.getCodeButton startCountDownWithSecond:180];
            
            [self.getCodeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            
            [self.getCodeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                return @"重新获取";
            }];
        }
    } andError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    } ShowHUD:NO];
    
    
  

    
}

#pragma mark ---
-(void)addBankCardRequst {

//    NSString *urlString = [NSString stringWithFormat:@"%@index.php?m=HQJ&c=AppSel2&a=bankAccountAction&sellerid=%@&id=customer&validatecode=%@&mobile=%@&payBankId=%@&payAccount=%@&payName=%@&bankBranch=%@",AppSel_URL,MmberidStr,self.verificationCodeTextField.text,[NameSingle shareInstance].mobile,_bankIdStr,self.cardTextField.text,self.nameTextField.text,self.branchTextField.text];
    NSDictionary *dict = @{@"sellerid":MmberidStr,
                           @"validatecode":self.verificationCodeTextField.text,
                           @"mobile":[NameSingle shareInstance].mobile,
                           @"paybankid":_bankIdStr,
                           @"payaccount":self.cardTextField.text,
                           @"payname":self.nameTextField.text,
                           @"bankbranch":self.branchTextField.text};
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBAddBankCardInterface];

//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HQJLog(@"------%@",urlString);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlString parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"code"]integerValue] == 49000) {
            [ManagerEngine dimssLoadView:self.okButton andtitle:@"确定"];
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [ManagerEngine SVPAfter:@"添加成功" complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"result"][@"errmsg"]];
        }
        
        
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    

    
}


#pragma mark --
#pragma mark --- 取消输入第一响应
-(void)lostTheFirstResponse {
    
    [self.nameTextField resignFirstResponder];
    [self.cardTextField resignFirstResponder];
    [self.branchTextField resignFirstResponder];
    
}

#pragma mark --
#pragma mark --- 姓名判断
-(BOOL)isNameValid:(NSString *)name
{
    BOOL isValid = NO;
    
    if (name.length > 0)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = YES;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = YES;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = NO;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = YES;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            
            if (!isValid)
            {
                break;
            }
        }
    }
    
    return isValid;
}


#pragma mark --
#pragma mark --- 银行卡判断
- (BOOL)checkBankCardNumber:(NSString *)cardNumber
{
    int oddSum = 0;     // 奇数和
    int evenSum = 0;    // 偶数和
    int allSum = 0;     // 总和
    
    // 循环加和
    for (NSInteger i = 1; i <= cardNumber.length; i++)
    {
        NSString *theNumber = [cardNumber substringWithRange:NSMakeRange(cardNumber.length-i, 1)];
        int lastNumber = [theNumber intValue];
        if (i%2 == 0)
        {
            // 偶数位
            lastNumber *= 2;
            if (lastNumber > 9)
            {
                lastNumber -=9;
            }
            evenSum += lastNumber;
        }
        else
        {
            // 奇数位
            oddSum += lastNumber;
        }
    }
    allSum = oddSum + evenSum;
    // 是否合法
    if (allSum%10 == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
