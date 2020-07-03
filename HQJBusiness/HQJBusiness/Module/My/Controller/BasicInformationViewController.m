//
//  BasicInformationViewController.m
//  HQJBusiness
//  基本信息和发布商品 通用界面
//  Created by mymac on 2020/5/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "BasicInformationViewController.h"

@interface BasicInformationViewController ()
@property (nonatomic, strong) UILabel *titLabel;

@property (nonatomic, strong) UILabel *urlLabel;

@property (nonatomic, strong) UIButton *ncopyButton;

@property (nonatomic, strong) NSString *titleStr;
@end

@implementation BasicInformationViewController
- (instancetype)initWithTitle:(NSString *)tit {
    self = [super init];
    if (self) {
        self.titleStr = tit;
        if ([tit isEqualToString:@"基本信息"]) {
            self.urlLabel.text = @"http://shop.wuwuditu.com";

            self.titLabel.text = @"登录电脑端商家管理系统完善信息";

        }else if ([tit isEqualToString:@"发布商品"]) {
            self.titLabel.text = @"登录电脑端商家管理系统发布商品";
            self.urlLabel.text = @"http://shop.wuwuditu.com";

        } else {
            self.titLabel.text = @"登录电脑端商家管理系统进行详细操作";
            self.urlLabel.text = @"http://shop.wuwuditu.com";

        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = self.titleStr;
    [self.view addSubview:self.titLabel];
    [self.view addSubview:self.urlLabel];
    [self.view addSubview:self.ncopyButton];
    [self.titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationControllerHeight + 50);
        make.centerX.mas_equalTo(self.view);
    }];
    [self.urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.titLabel.mas_bottom).mas_offset(10);
           make.centerX.mas_equalTo(self.view);
    }];
    [self.ncopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.mas_equalTo(self.urlLabel);
              make.left.mas_equalTo(self.urlLabel.mas_right).mas_offset(10);
    }];

}
- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc]init];
        
    }
    return _titLabel;
}
- (UILabel *)urlLabel {
    if (!_urlLabel) {
        _urlLabel = [[UILabel alloc]init];
        
    }
    return _urlLabel;
}
- (UIButton *)ncopyButton {
    if (!_ncopyButton) {
        _ncopyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ncopyButton setTitle:@"复制" forState:UIControlStateNormal];
        _ncopyButton.backgroundColor = DefaultAPPColor;
        @weakify(self);
            [[_ncopyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @strongify(self);
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = self.urlLabel.text;
                [SVProgressHUD showSuccessWithStatus:@"复制成功"];
            }];
    }
    return _ncopyButton;
}
@end
