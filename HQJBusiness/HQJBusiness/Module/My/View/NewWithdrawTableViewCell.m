//
//  NewWithdrawTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/6/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NewWithdrawTableViewCell.h"
@interface NewWithdrawTableViewCell ()
@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UILabel *subTitLbale;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIButton *forgetButton;
@end
@implementation NewWithdrawTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setTitle:(NSString *)tit subTitle:(NSString *)subtit {
    self.titLabel.text = tit;
    self.subTitLbale.text = subtit;
    self.subTitTextField.placeholder = subtit;
    self.arrowImageView.hidden = [tit isEqualToString:@"商家账户"] ? NO : YES;
    self.forgetButton.hidden = [tit isEqualToString:@"交易密码"] ? NO : YES;
    self.subTitLbale.hidden = [tit isEqualToString:@"提现方"]|[tit isEqualToString:@"受理方"] ? NO : YES;
    self.subTitTextField.hidden = [tit isEqualToString:@"提现金额"] | [tit isEqualToString:@"商家账户"] |[tit isEqualToString:@"交易密码"] ? NO : YES;
//    self.subTitTextField.e
//    if ([tit isEqualToString:@"提现方"]) {
//
//    } else if ([tit isEqualToString:@"提现金额"]) {
//
//    }  else if ([tit isEqualToString:@"商家账户"]) {
//        self.subTitTextField.placeholder = subtit;
//
//    }  else if ([tit isEqualToString:@"受理方"]) {
//        self.subTitLbale.text = subtit;
//
//    }  else if ([tit isEqualToString:@"交易密码"]) {
//        self.subTitTextField.placeholder = subtit;
//
//    } else {
//
//    }
    
}

- (void)addViews {
    [self.contentView addSubview:self.titLabel];
    [self.contentView addSubview:self.subTitLbale];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.subTitTextField];
    [self.contentView addSubview:self.forgetButton];
    
}

- (void)updateConstraints {
    [self.titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(70 / 3);
        make.top.mas_equalTo(40 / 3);
    }];
    [self.subTitLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100 / 3);
        make.top.mas_equalTo(40 / 3);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50 / 3);
        make.top.mas_equalTo(40 / 3);
    }];
    [self.subTitTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100 / 3);
        make.top.mas_equalTo(40 / 3);
        make.width.mas_equalTo(WIDTH / 2);
    }];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100 / 3);
        make.top.mas_equalTo(self.subTitTextField.mas_bottom).mas_offset(5);
    }];
    
    [super updateConstraints];
}

- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc]init];
        _titLabel.font = [UIFont systemFontOfSize:48.f / 3 ];
        _titLabel.textColor = [UIColor blackColor];
        
    }
    return _titLabel;
}

- (UILabel *)subTitLbale {
    if (!_subTitLbale) {
        _subTitLbale = [[UILabel alloc]init];
        _subTitLbale.textColor = [UIColor blackColor];
        _subTitLbale.font = [UIFont systemFontOfSize:48.f / 3];
        _subTitLbale.hidden = YES;
    }
    return _subTitLbale;
}

- (UITextField *)subTitTextField {
    if (!_subTitTextField) {
        _subTitTextField = [[UITextField alloc]init];
        _subTitTextField.textColor = [UIColor blackColor];
        _subTitTextField.textAlignment = NSTextAlignmentRight;
        _subTitTextField.font = [UIFont systemFontOfSize:48.f / 3];
        _subTitTextField.hidden = YES;
    }
    return _subTitTextField;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"iocn_Select-right"];
        _arrowImageView.hidden = YES;
    }
    return _arrowImageView;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitleColor:[ManagerEngine getColor:@"20a0ff"] forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记交易密码?" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:36 / 3.f];
        _forgetButton.hidden = YES;
    }
    return _forgetButton;
}

@end
