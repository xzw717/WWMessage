//
//  OkBuyViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OkBuyViewController.h"
#import "ModeOfPaymentView.h"
#import "LrdPasswordAlertView.h"
#import "PayEngine.h"

@interface OkBuyViewController ()

@property (nonatomic,strong) ZW_Label *needPayLabel; // --- 需要付多少

@property (nonatomic,strong) ZW_Label *payModeLabel; // --- 支付方式

@property (nonatomic,strong) UIButton *selectButton; // --- 选择支付方式

@property (nonatomic,strong) ModeOfPaymentView *payModeView; // --- 选择支付方式视图

@property (nonatomic,strong) LrdPasswordAlertView *pswView;  //  --- 积分支付交易密码

@property (nonatomic,strong) NSString *orderID;
@end
@implementation OkBuyViewController

-(ZW_Label *)needPayLabel {
    if (!_needPayLabel) {
        _needPayLabel = [[ZW_Label alloc]initWithStr:[NSString stringWithFormat:@"需付金额：%.2f元(%.2f积分)",[_numerStr doubleValue] * 2,[_numerStr doubleValue] * 4] addSubView:self.view];
        [ManagerEngine setTextColor:_needPayLabel FontNumber:[UIFont systemFontOfSize:17.0] AndRange:[NSString stringWithFormat:@"(%.2f积分)",[_numerStr doubleValue] * 4] AndColor:[ManagerEngine getColor:@"999999"]];
    }
    
    return _needPayLabel;
}

-(ZW_Label *)payModeLabel {
    if (!_payModeLabel) {
        _payModeLabel = [[ZW_Label alloc]initWithStr:@"积分支付，" addSubView:self.view];
        _payModeLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _payModeLabel;
}
-(ModeOfPaymentView *)payModeView {
    if (!_payModeView) {
        _payModeView = [[ModeOfPaymentView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    }
    
    return _payModeView;
}
-(UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setTitle:@"其他支付方式" forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"icon_arrow_pay_down"] forState:UIControlStateNormal];
       [_selectButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _selectButton.imageEdgeInsets =  UIEdgeInsetsMake(0, 85, 0, 0);
        _selectButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);

        [_selectButton bk_addEventHandler:^(id  _Nonnull sender) {
            
            
            [self.payModeView showView];

        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_selectButton];
    }
    
    return _selectButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.model = [[BonusExchangeModel alloc]init];
    
    [BuyZHViewModel buyZH:^(id sender) {
        
        self.model = sender;
        if ([_numerStr doubleValue] * 4 > self.model.score.score) {
            
//            HQJLog(@"%f\n%f",[_numerStr doubleValue] * 4,[self.model.bonus doubleValue]);
            /**
             *
             * 积分余额不足
             *
             *
             */
            self.payModeView.isArrearage = YES;
            
        } else {
            
            self.payModeView.isArrearage = NO;
            
            
        }
         self.nextButton.enabled = YES;
    }];
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.payModeView.payModeStr = @"积分支付";
    @WeakObj(self);

    
    [self.payModeView setCellSelectBlock:^(id title) {
        
        
        selfWeak.payModeView.payModeStr = title;
        
        if ([title isEqualToString:@"支付宝支付"]) {
            [BuyZHViewModel generateTradeidRequstAmount:[NSString stringWithFormat:@"%.2f",[selfWeak.numerStr floatValue] *2] andBlock:^(id Tradeid) {
                
                selfWeak.orderID = Tradeid;
                
                
            }];
        }
     selfWeak.payModeLabel.text = [NSString stringWithFormat:@"%@，",title];
     [selfWeak  setPayModel];

 }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayResults:) name:kNoticationPayResults object:nil];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark --
#pragma mark --- 支付宝支付结果 
-(void)alipayResults:(NSNotification *)infos {
    NSString *stateStr = infos.userInfo[@"strMsg"];
    if ([stateStr isEqualToString:@"支付成功"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showSuccessWithStatus:stateStr];
        [ManagerEngine SVPAfter:stateStr complete:^{
            self.viewControllerName = @"DealViewController";
            [self popViews];
        }];
    } else {

        [SVProgressHUD showErrorWithStatus:stateStr];
    }
    
    
    
}

-(void)setViewframe {
    self.BonusNumerLabel.text = [NSString stringWithFormat:@"购买数量：%@个",_numerStr];
   
    [self.BonusNumerTextField removeFromSuperview];
    
    self.nextButton.backgroundColor = DefaultAPPColor;
    
    [self.nextButton setTitle:@"确认支付" forState:UIControlStateNormal];
    
//    self.nextButton.enabled = NO;
    
   
    
    CGFloat payLabelWith = [ManagerEngine setTextWidthStr:self.payerLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.payerLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.view,75 + NavigationControllerHeight).heightIs(17).widthIs(payLabelWith);
    
    CGFloat bonusWidth = [ManagerEngine setTextWidthStr:self.BonusNumerLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.BonusNumerLabel.sd_layout.leftEqualToView(self.payerLabel).topSpaceToView(self.payerLabel,30).heightIs(17).widthIs(bonusWidth);
    
    
    CGFloat collectionWidth = [ManagerEngine setTextWidthStr:self.collectionLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.collectionLabel.sd_layout.leftEqualToView(self.BonusNumerLabel).topSpaceToView(self.BonusNumerLabel,30).heightIs(17).widthIs(collectionWidth);
    
    CGFloat needpayWidth = [ManagerEngine setTextWidthStr:self.needPayLabel.text andFont:[UIFont systemFontOfSize:17.0]];
    self.needPayLabel.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.collectionLabel,30).heightIs(17).widthIs(needpayWidth);
    
    self.nextButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.needPayLabel,40).heightIs(44).widthIs(WIDTH - kEDGE * 2);
    
    [self setPayModel];
    
    
}

-(void)nextBtn {
    @WeakObj(self);

    [ManagerEngine dimssLoadView:self.nextButton andtitle:@"确认支付"];
    if([self.payModeLabel.text isEqualToString:@"积分支付，"]){
        if([[NameSingle shareInstance].role isEqualToString:@"股份商家"]||[[NameSingle shareInstance].role isEqualToString:@"命运共同体"]) {
            if ([_numerStr doubleValue] * 4 > self.model.score.score) {
                [SVProgressHUD showErrorWithStatus:@"你的积分好像不够了"];
            } else {
                _pswView = [[LrdPasswordAlertView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
                
                [_pswView pop];
                [_pswView setBlock:^(NSString *str) {
                    if (str.length == 6) {
                        [BuyZHViewModel payRequstWithAmount:[NSString stringWithFormat:@"%f",[_numerStr doubleValue] * 4] andPassword:str andPopViewController:selfWeak];

                    }
                }];
                
            }
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"积分购买仅限股份商家"];
        }
       
    } else if([self.payModeLabel.text isEqualToString:@"微信支付，"]) {
        [PayEngine jumpToBizPayOrderidStr:self.orderID andUseridStr:MmberidStr];
//        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
        
    } else if([self.payModeLabel.text isEqualToString:@"支付宝支付，"]) {
//
       [PayEngine payActionOutTradeNOStr:self.orderID andSubjectStr:[NSString stringWithFormat:@"%@@%@",self.model.parentName,[NameSingle shareInstance].name] andNameStr:@"商品一批" andTotalFeeSt:[NSString stringWithFormat:@"%.2f",[_numerStr doubleValue] * 2] andNotifyUrl:[NSString stringWithFormat:@"%@alipayCallback",HQJBBonusDomainName]];
      
    } else {
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];

    }
   

}

#pragma mark --
#pragma mark --- 支付方式变后跟着变
-(void)setPayModel {
    CGFloat modeWidth = [ManagerEngine setTextWidthStr:self.payModeLabel.text andFont:[UIFont systemFontOfSize:15.0]];
    CGFloat selectWidth = [ManagerEngine setTextWidthStr:self.selectButton.titleLabel.text andFont:[UIFont systemFontOfSize:15.0]];
    self.payModeLabel.sd_layout.leftSpaceToView(self.view,(WIDTH - modeWidth - selectWidth)/2).topSpaceToView(self.view,HEIGHT - (44 - 15) / 2 - 30).heightIs(15).widthIs(modeWidth);
    
    self.selectButton.sd_layout.leftSpaceToView(self.payModeLabel,0).topSpaceToView(self.view,HEIGHT -  30 - 44 + 15).heightIs(44).widthIs(selectWidth);
    
    
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
