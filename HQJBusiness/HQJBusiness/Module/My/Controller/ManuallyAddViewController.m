//
//  ManuallyAddViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/19.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ManuallyAddViewController.h"
#import "ConsumerCodeViewModel.h"

@interface ManuallyAddViewController ()
@property (nonatomic,strong)ZW_TextField *consumerCodeTextField;
@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,strong)UIButton *okButton;
@end

@implementation ManuallyAddViewController
-(ZW_TextField *)consumerCodeTextField {
    if (!_consumerCodeTextField) {
        _consumerCodeTextField = [[ZW_TextField alloc]initWithPlaceholder:@"请输入消费码" isType:isMobileType addSubView:self.backgroundView];
        _consumerCodeTextField.borderStyle = UITextBorderStyleNone;
    }
    
    
    return _consumerCodeTextField;
}
-(UIView *)backgroundView {
    if (!_backgroundView ) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kEDGE + NavigationControllerHeight, WIDTH, 45)];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}

-(UIButton *)okButton {
    
    if (!_okButton) {
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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"手动添加";
    
    
    [self.view addSubview:self.backgroundView];
    
    self.consumerCodeTextField.sd_layout.leftSpaceToView(self.backgroundView,10).topSpaceToView(self.backgroundView,0).heightIs(45).widthIs(WIDTH - 10 * 2);

    self.okButton.sd_layout.leftSpaceToView(self.view,kEDGE).topSpaceToView(self.backgroundView,30).heightIs(44).widthIs(WIDTH - kEDGE * 2 );
    
    [self setSignal];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavType:HQJNavigationBarWhite];
    
}
#pragma mark --
#pragma mark --- 信号创建
-(void)setSignal {
    
    RACSignal *textSignal = [self.consumerCodeTextField.rac_textSignal map:^id(id value) {
        return @([self textFieldConditions:value]);
    }];
    [textSignal subscribeNext:^(NSNumber *numer) {
        self.okButton.enabled = [numer boolValue];
        if ([numer boolValue]) {
            self.okButton.backgroundColor = DefaultAPPColor;
            
        } else {
            self.okButton.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
            
        }
    }];
    
    [[self.okButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ManagerEngine loadDateView:self.okButton andPoint:CGPointMake(self.okButton.frame.size.width/2, self.okButton.frame.size.height/2)];
        [ConsumerCodeViewModel QrCodeRequst:self.consumerCodeTextField.text andBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    

}

#pragma mark --
#pragma mark --- 输入框条件
-(BOOL)textFieldConditions:(NSString *)text {
    
    if(text.length >0) {
        return YES;
    } else {
        return NO;
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
