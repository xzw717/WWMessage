//
//  ShowMobileView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/23.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShowMobileView.h"
#import "UIView+RoundedCorners.h"
#import "AddUnionActivityViewModel.h"
@interface ShowMobileView ()
@property (nonatomic, strong) NSString *trueMobile;
@property (nonatomic, strong) NSString *trueId;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITextField *mobileTextFiled;
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UIImageView  *headImageView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancleButton;
@end
@implementation ShowMobileView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self addSubview:self.maskView];
        [self.maskView addSubview:self.mobileTextFiled];
        [self.maskView addSubview:self.headImageView];
        [self.maskView addSubview:self.nameLabel];
        [self.maskView addSubview:self.sureButton];
        [self.maskView addSubview:self.cancleButton];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (UIView *)maskView{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor groupTableViewBackgroundColor];;
        [_maskView hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0, WIDTH - 100, 150) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:10.f];
    }
    return _maskView;
}
- (UITextField *)mobileTextFiled {
    if (_mobileTextFiled == nil) {
        _mobileTextFiled = [[UITextField alloc]init];
        _mobileTextFiled.backgroundColor = [UIColor whiteColor];
        _mobileTextFiled.font = [UIFont systemFontOfSize:16];
        _mobileTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _mobileTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileTextFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        _mobileTextFiled.layer.masksToBounds = YES;
        _mobileTextFiled.layer.cornerRadius = 5;
        _mobileTextFiled.placeholder = @"请输入商家手机号";
        [_mobileTextFiled addTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _mobileTextFiled;
}
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc]init];
    }
    return _headImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = RedColor;
    }
    return _nameLabel;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = DefaultAPPColor;
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.backgroundColor = [UIColor whiteColor];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}
- (void)updateConstraints {
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 100, 150));
    }];
    [self.mobileTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.maskView);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 140, 40));
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileTextFiled.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mobileTextFiled.mas_left);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileTextFiled.mas_bottom);
        make.left.mas_equalTo(self.headImageView.mas_right);
        make.right.mas_equalTo(self.mobileTextFiled.mas_right);
        make.height.mas_equalTo(50);
    }];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.maskView);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 100)/2, 40));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.maskView);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 100)/2, 40));
    }];
    [super updateConstraints];
}
- (void)sureButtonClicked{
    if (_sureButtonBlock) {
        if (self.trueMobile) {
            _sureButtonBlock(self.trueMobile,self.trueId);
        }
    }
    [self removeFromSuperview];
}
- (void)cancleButtonClicked{
    [self removeFromSuperview];
}
- (void)show{
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
#pragma mark 监听textField的值改变事件
- (void)textFiledEdingChanged{
    if (self.mobileTextFiled.text.length == 11) {
        @weakify(self);
        [AddUnionActivityViewModel getMerchantByMobile:self.mobileTextFiled.text completion:^(NSDictionary * _Nonnull dic) {
            @strongify(self);
            if ([dic[@"code"] integerValue] == 49000) {
                self.nameLabel.text = dic[@"result"][@"realname"];
                self.trueMobile = dic[@"result"][@"mobile"];
                self.trueId = [NSString stringWithFormat:@"%@",dic[@"result"][@"memberid"]];
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
                self.nameLabel.text = dic[@"msg"];
                
            }
            
        }];
    }
    
    
}
- (void)dealloc {
    [self.mobileTextFiled removeTarget:self action:@selector(textFiledEdingChanged) forControlEvents:UIControlEventEditingChanged];
}
@end
