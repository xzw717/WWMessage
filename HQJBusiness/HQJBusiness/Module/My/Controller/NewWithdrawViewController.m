//
//  NewWithdrawViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/6/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NewWithdrawViewController.h"
#import "NewWithdrawTableViewCell.h"
#import "SelectBankViewController.h"
#import "BonusExchangeViewModel.h"
#import "BonusExchangeModel.h"
@interface NewWithdrawViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView  *withdrawTableView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSMutableArray *titArray;
@property (nonatomic, strong) UITextField *BonusNumerTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField  *selectBankTextField;
@property (nonatomic, strong) NSString *cardIDStr;
@property (nonatomic,strong) BonusExchangeModel *model;
@property (nonatomic, strong) id *name;
@end

@implementation NewWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"现金提现";
    self.view.backgroundColor = [ManagerEngine getColor:@"f7f7f7"];
    [self.view addSubview:self.withdrawTableView];
    [self.view addSubview:self.submitBtn];
    
    [self BonusExchangeRequst];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectInfo:) name:kActionBank object:nil];
//    self.titArray = [NSMutableDictionary dictionaryWithDictionary:@{@"提现方":@"好得意积分店",
//                                                                   @"提现金额":@"请输入现金提现数额",
//                                                                   @"商家账户":@"请选择商家账户",
//                                                                   @"受理方":@"上海嘉定子公司",
//                                                                   @"交易密码":@"请输入交易密码",}];
    self.titArray = [NSMutableArray arrayWithArray:@[@[@"提现方",@"好得意积分店"],@[@"提现金额",@"请输入现金提现数额"], @[@"商家账户",@"请选择商家账户"], @[@"受理方",@"上海嘉定子公司"],@[@"交易密码",@"请输入交易密码"]]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.titArray.count;
    } else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            return 82;
        } else {
            return 44;
        }
    } else {
           return 100;
       
       }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionSeaderView = [UIView new];
    return sectionSeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50 / 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NewWithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewWithdrawTableViewCell class]) forIndexPath:indexPath];
        cell.subTitTextField.delegate = self;
        [cell setTitle:[self.titArray[indexPath.row] firstObject] subTitle:[self.titArray[indexPath.row] lastObject]];
        return cell;
    }else  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = @"【物联商家】提现说明：\n1.提现服务费18%；\n2.服务费从提现金额中扣除";
        return cell;
        
    }  
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}


#pragma mark --
#pragma mark --- 积分及名称请求
-(void)BonusExchangeRequst {
    
    [BonusExchangeViewModel bonusExchaneViewmodelRequstandViewControllerTitle:self.zw_title AndBack:^(id sender) {
        _model = sender;
     
        [self.titleView setTitleStr:[NSString stringWithFormat:@"当前商家账户有%@元现金",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",_model.score.cash] afterPoint:2]] andisNav:NO andColor:[ManagerEngine getColor:@"fff2b2"]];
      
        [self setViewframe];

    }];
  
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark --
#pragma mark --- 信号创建
-(void)signalSet {
    
   
    RACSignal *validBounsSignal = [self.BonusNumerTextField.rac_textSignal map:^id(NSString *value) {
//
//        if ([value isEqualToString:@""]) {
//            self.canExchangeLabel.text = [NSString stringWithFormat:@"可兑现0.00元"];
//        } else {
//            self.canExchangeLabel.text =[NSString stringWithFormat:@"可兑现%@元",[ManagerEngine retainScale:[NSString stringWithFormat:@"%f",[value doubleValue] / 2] afterPoint:2] ];
//
//        }
        [self updateCash];
        return @([self textFieldChanged:value]);
    }];
    RACSignal *validPswSignal = [self.passwordTextField.rac_textSignal map:^id(id value) {
        
        return @([self isValidPsw:value]);
    }];
    
//    RAC(self.canExchangeLabel,textColor) = [validBounsSignal map:^id(NSNumber *values) {
//        return [values boolValue]?DefaultAPPColor:[ManagerEngine getColor:@"999999"];
//    }];
    
    RACSignal *signUp = [RACSignal combineLatest:@[validBounsSignal,validPswSignal] reduce:^id(NSNumber *bounsValid,NSNumber *pswValid){
        return @([bounsValid boolValue]&&[pswValid boolValue]);
    }];
    [signUp subscribeNext:^(NSNumber * signUpActive) {
        self.submitBtn.enabled = [signUpActive boolValue];
        if ([signUpActive boolValue]) {
            self.submitBtn.backgroundColor = DefaultAPPColor;
            
        } else {
            self.submitBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
            
        }
        
    }];
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ManagerEngine loadDateView:self.submitBtn andPoint:CGPointMake(self.submitBtn.frame.size.width/2, self.submitBtn.frame.size.height/2)];
        
        if ([self.BonusNumerTextField.text doubleValue] < 0 ) {
            [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"提交"];
            [SVProgressHUD showErrorWithStatus:@"数额要大于 0"];
        } else {
            if ([self.selectBankTextField.text isEqualToString:@""]) {
                 [SVProgressHUD showErrorWithStatus:@"还没选择银行卡"];
                [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"提交"];

            } else {
                [BonusExchangeViewModel bonusExchangSubmitRequstWithAmount:self.BonusNumerTextField.text andPassword:self.passwordTextField.text andViewControllerTitle:self.zw_title andcardId:self.cardIDStr andbonusBlock:^(NSDictionary * dic) {
                    
                    if ([dic[@"code"]integerValue] == 49000) {
                        
                        [SVProgressHUD showSuccessWithStatus:@"提交成功，请等待审核"];
                        
                        //                    [SVProgressHUD dismissWithCompletion:^{
                        //
                        //                    }];
                        [ManagerEngine SVPAfter:@"提交成功，请等待审核" complete:^{
                            [self.navigationController popViewControllerAnimated:YES];
                            
                            
                        }];
                    } else {
                        [ManagerEngine dimssLoadView:self.submitBtn andtitle:@"提交"];
                        //SVProgressHUD
                        [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
                    }
                    
                }];
            }
          
          
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
    
    self.payerLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,75 + NavigationControllerHeight).heightIs(17).widthIs(payLabelWith);
    

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



-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.passwordTextField resignFirstResponder];
    [self.BonusNumerTextField resignFirstResponder];
    
}

-(void)selectInfo:(NSNotification *)info {
    
    HQJLog(@"我的选择是：%@",info.userInfo);
    
    if (info.userInfo[@"deleted"]) {
        if ( self.cardIDStr && [info.userInfo[@"deleted"] isEqualToString:self.cardIDStr] ) {
            self.selectBankTextField.text = @"";
            [self.selectBankTextField setLeftViewWithimageName:nil];

        }

    } else {
        NSString *texts = [NSString stringWithFormat:@"%@(尾号%@)",info.userInfo[@"payName"],info.userInfo[@"payAccount"]];
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:texts];
        
        NSRange range = [texts rangeOfString:[NSString stringWithFormat:@"(尾号%@)",info.userInfo[@"payAccount"]]];
        
        [attributeString setAttributes:@{NSForegroundColorAttributeName:[ManagerEngine getColor:@"999999"],NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:range];
        self.cardIDStr = info.userInfo[@"id"];
        self.selectBankTextField.attributedText = attributeString;
        [self.selectBankTextField setLeftViewWithimageName:info.userInfo[@"icon"]];
    }
    

    
}



@end

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 65 / 3.f;
        _submitBtn.frame = CGRectMake(70 / 3, HEIGHT - 240 / 3, WIDTH - 70 * 2 / 3, 130 / 3);
        _submitBtn.backgroundColor = [ManagerEngine getColor:@"20a0ff"];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:55 / 3.f];
    }
    return _submitBtn;
}
- (UITableView *)withdrawTableView {
    if (!_withdrawTableView) {
        _withdrawTableView = [[UITableView alloc]init];
        _withdrawTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight - 240 / 3 - 50 / 3);
        _withdrawTableView.backgroundColor = [ManagerEngine getColor:@"f7f7f7"];
        _withdrawTableView.delegate = self;
        _withdrawTableView.dataSource = self;
        [_withdrawTableView registerClass:[NewWithdrawTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NewWithdrawTableViewCell class])];
        [_withdrawTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 400 / 3)];
        view.backgroundColor = [ManagerEngine getColor:@"f7f7f7"];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30 / 3, 30 / 3, WIDTH - 30 * 2 / 3, 340 /3)];
        label.backgroundColor = [ManagerEngine getColor:@"ffc82d"];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 30 / 3.f;
        [view addSubview:label];
        _withdrawTableView.tableHeaderView = view;
        _withdrawTableView.tableFooterView = [UIView new];
        
    }
    return _withdrawTableView;
}


@end
