//
//  ScoreGiftViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ScoreGiftViewController.h"
#import "ScoreGiftView.h"
#import "ScoreGiftViewModel.h"
@interface ScoreGiftViewController ()
@property (nonatomic,strong) ScoreGiftView *contentView;
@property (nonatomic,strong) ScoreGiftViewModel * viewModel;
@end

@implementation ScoreGiftViewController
- (ScoreGiftView *)contentView {
    if (_contentView == nil) {
        _contentView = [[ScoreGiftView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT)];
    }
    return _contentView;
}
- (ScoreGiftViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[ScoreGiftViewModel alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zwNavView.backgroundColor = [UIColor whiteColor];
    self.zw_title = @"积分赠送";
    [self.view addSubview:self.contentView];
    [self processingSignal];
    // Do any additional setup after loading the view.
}    



- (void)processingSignal {
    @weakify(self);
    RAC(self.viewModel, phoneNumer) = self.contentView.userNameTextfield.rac_textSignal;
    RAC(self.viewModel, authCode) = self.contentView.authCodeTextfield.rac_textSignal;
    RAC(self.viewModel, score) = self.contentView.scoreNumTextfield.rac_textSignal;

    
    self.contentView.submitButton.rac_command = self.viewModel.summitBtnCommand;
    self.contentView.getCodeBtn.rac_command = self.viewModel.codeBtnCommand;
    
    RAC(self.contentView.submitButton,backgroundColor) = [self.viewModel.summitBtnEnable map:^id(NSNumber *value) {
        return [value boolValue] ? DefaultAPPColor:GrayColor;
    }];
    RAC(self.contentView.getCodeBtn,backgroundColor) = [self.viewModel.codeBtnEnable map:^id(NSNumber *value) {
        return [value boolValue] ? DefaultAPPColor:GrayColor;
    }];

    [self.viewModel.codeBtnEnable subscribeNext:^(NSNumber *value) {
        self.contentView.getCodeBtn.enabled = [value boolValue];
    }];
    
    [self.viewModel.summitBtnEnable subscribeNext:^(NSNumber *value) {
        self.contentView.submitButton.enabled = [value boolValue];
    }];
    
    
    [[self.viewModel.codeBtnCommand executionSignals]subscribeNext:^(id x) {
        @strongify(self);
        [x subscribeNext:^(NSDictionary *value) {
            if ([value[@"code"] integerValue] == 49000) {
                [self openCountdown];
            }
        }];
    }];

    
    [[self.viewModel.summitBtnCommand executionSignals]subscribeNext:^(id x) {
        @strongify(self);
        [x subscribeNext:^(NSDictionary *value) {
            if ([value[@"code"] integerValue] == 49000) {
                [SVProgressHUD showSuccessWithStatus:value[@"msg"]];
            }else{
                [SVProgressHUD showErrorWithStatus:value[@"msg"]];
            }
        }];
    }];

}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                self.contentView.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
                [self.contentView.getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                
                [self codeButtonState:YES];
            });
            
        }else{
            
            int seconds = time % 180;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                self.contentView.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
                [self.contentView.getCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self codeButtonState:NO];
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)codeButtonState:(BOOL)enabled {
    self.contentView.getCodeBtn.enabled = enabled;
    
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
