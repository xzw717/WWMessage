//
//  SetZHViewControllers.m
//  HQJBusiness
//   ZH 值 设定
//  Created by mymac on 2016/12/18.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetZHViewController.h"
#import "SetZHView.h"
#import "SetZHModel.h"
#import "SetZHViewModel.h"
#import "UIButton+touch.h"


@interface SetZHViewController () <UITextFieldDelegate>
@property (nonatomic,strong)UITableView *setZHTableView;
@property (nonatomic,strong) UIButton *submitButton ;  // ---- 提交按钮


@property (nonatomic,strong)ZW_ChangeFigureColorLabel * cashDetaileLabel;


@property (nonatomic,strong)ZW_ChangeFigureColorLabel * bonusDetaileLabel;


@property (nonatomic,assign)CGFloat oneCellHeight;

@property (nonatomic,assign)CGFloat twoCellHeight;

@property (nonatomic,strong) SetZHView *cashView;

@property (nonatomic,strong) SetZHView *bonusView;

@property (nonatomic,strong) SetZHModel *model;


@property (nonatomic,strong) SetZHViewModel *viewModel;

@end




@implementation SetZHViewController
-(SetZHView *)cashView {
    if(!_cashView ){
        _cashView =[[SetZHView alloc]init];
        [self.view addSubview:_cashView];
    }
    
    return _cashView;
}

-(SetZHView *)bonusView {
    
    if(!_bonusView ){
        _bonusView =[[SetZHView alloc]init];
        [self.view addSubview:_bonusView];
    }
    
    return _bonusView;
    
}
-(UIButton *)submitButton {
    
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = DefaultAPPColor;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 5 ;
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.timeInterval = 2.0;
            
        [self.view addSubview:_submitButton];
    }
    
    return _submitButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"ZH值设定";
    _model = [[SetZHModel alloc]init];
    
    
    self.cashView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,kNAVHEIGHT+kEDGE).heightIs(120).widthIs(WIDTH);
    [self.cashView setTitleStr:@"现金消费时：" andplaceholderStr:@"例如：20"];
    self.cashView.proportionTextField.delegate = self;
    
    
    if([[NameSingle shareInstance].role isEqualToString:@"股份商家"]){
        self.bonusView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.cashView,15).heightIs(120).widthIs(WIDTH);
        [self.bonusView setTitleStr:@"积分消费时：" andplaceholderStr:@"例如：15"];
        self.bonusView.proportionTextField.delegate = self;
    }

    [self setSignal];
    
    [self getBonusCash];
}

#pragma mark --
#pragma mark --- 信号创建
-(void)setSignal {
    
    RACSignal *validCashSignal = [self.cashView.proportionTextField.rac_textSignal map:^id(NSString *value) {
        
        [self updateCashDetaile:value];
        
        return @([self textFieldChanged:value]);
    }];
    RAC(self.cashView.proportionTextField,textColor) = [validCashSignal map:^id(NSNumber *values) {
        return [values boolValue]?[ManagerEngine getColor:@"323232"]:[ManagerEngine getColor:@"999999"];
    }];
    
    if([[NameSingle shareInstance].role isEqualToString:@"股份商家"]){
   
        RACSignal *validBounsSignal = [self.bonusView.proportionTextField.rac_textSignal map:^id(NSString *value) {
            
            [self updateBonusDetaile:value];
            return @([self textFieldChanged:value]);
        }];
        RAC(self.bonusView.proportionTextField,textColor) = [validBounsSignal map:^id(NSNumber *values) {
            return [values boolValue]?[ManagerEngine getColor:@"323232"]:[ManagerEngine getColor:@"999999"];
        }];
    
    }
    

    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if ([_model.ZHSet integerValue] == 1) {

                    [SVProgressHUD showInfoWithStatus:@"ZH值比率调整申请，还在审核中，请耐心等候处理"];
        } else {
            
            if([[NameSingle shareInstance].role isEqualToString:@"股份商家"]){

                HQJLog(@"---111-");

                
                [SetZHViewModel setBonusZH:self.bonusView.proportionTextField.text andCashZH:self.cashView.proportionTextField.text andViewController:self];

            } else {
                [ManagerEngine loadDateView:self.submitButton andPoint:CGPointMake(self.submitButton.mj_w/2, self.submitButton.mj_h/2)];

                HQJLog(@"--222--");

                
                [SetZHViewModel setBonusZH:@"0" andCashZH:self.cashView.proportionTextField.text andViewController:self];

                
            }
        }
       
    } ];
    

    
}


#pragma mark ----条件
-(BOOL)textFieldChanged:(NSString *)text
{
    if ([text floatValue]==0) {
        return  NO;
    }  else{
        return  YES;
    }
}


-(void)updateCashDetaile:(id)value {
    
    
    
    if ([value integerValue] > 0 ) {
        NSString *str;
        [str floatValue];
            self.cashView.detaileLabelStr  = [NSString stringWithFormat:@"消费100元，赠送%.2f个ZH值。",[value floatValue] *0.01 * 100 * 0.5 ];
            self.cashView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,kNAVHEIGHT+kEDGE).heightIs(165).widthIs(WIDTH);


        
    } else {
        
            self.cashView.detaileLabelStr= @"";

        self.cashView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,kNAVHEIGHT+kEDGE).heightIs(120).widthIs(WIDTH);

    }
    if([[NameSingle shareInstance].role isEqualToString:@"股份商家"]) {
        self.submitButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.bonusView,30).heightIs(44).widthIs(WIDTH - kEDGE * 2);

    } else {
        self.submitButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.cashView,30).heightIs(44).widthIs(WIDTH - kEDGE * 2);

    }
    
}

-(void)updateBonusDetaile:(id)value  {
    
    
    
    if ([value integerValue] > 0 ) {
            self.bonusView.detaileLabelStr = [NSString stringWithFormat:@"消费200积分，赠送%.2f个ZH值。",[value floatValue] *0.01 * 200  * 0.25 ];
            self.bonusView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.cashView,15).heightIs(165).widthIs(WIDTH);
            
            
        
    } else {
        
        self.bonusView.detaileLabelStr = @"";
        
        self.bonusView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.cashView,15).heightIs(120).widthIs(WIDTH);
        
    }
    
    self.submitButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.bonusView,30).heightIs(44).widthIs(WIDTH - kEDGE * 2);

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.cashView.proportionTextField) {
        if ([textField.text isEqualToString:@""]) {
            if ([string isEqualToString:@"0"]) {
                return NO;
            } else {
                return YES;
            }
        } else {
            
            return YES;
        }
    } else {
        
        if ([textField.text isEqualToString:@""]) {
            if ([string isEqualToString:@"0"]) {
                return NO;
            } else {
                return YES;
            }
        } else {
            
            return YES;
        }
        
        
        
    }
    
    
    
    
}

#pragma mark --
#pragma mark --- 进入时请求原始比例
-(void)getBonusCash {
    [SetZHViewModel getBonusZHCashZHWithBlock:^(id sender) {
       
        _model = sender;
        self.cashView.proportionTextField.text = [NSString stringWithFormat:@"%.0f",[_model.cashZH floatValue] *100];
        
        if([[NameSingle shareInstance].role isEqualToString:@"股份商家"]){
            
            self.bonusView.proportionTextField.text = [NSString stringWithFormat:@"%.0f",[_model.bonusZH floatValue] *100];


        }
        
    }];
    
    
    
}
@end
