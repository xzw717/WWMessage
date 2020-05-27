//
//  XDSSMTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/20.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDSSMTableViewCell.h"
#import "XDSSMModel.h"
#import "XDOrderDetailsViewController.h"

@interface XDSSMTableViewCell ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *stateTitleLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIButton *payButton;
@end
@implementation XDSSMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ManagerEngine getColor:@"f3f2f7"];
        [self addView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setModel:(XDSSMModel *)model {
    _model = model;
    if ([model.orderstate isEqualToString:@"5"]) {
        self.stateTitleLabel.text = @"支付方式";
        self.stateLabel.text = model.paywayname;
        self.payButton.hidden = YES;
    }
    if ([model.orderstate isEqualToString:@"1"]) {
        self.stateTitleLabel.text = @"支付状态";
        self.stateLabel.text = @"待支付";
        self.payButton.hidden = NO;

    }
    NSMutableAttributedString *arttirbu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",model.ordermoney]];
    [arttirbu setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} range:NSMakeRange(1, model.ordermoney.length)];
    self.priceLabel.attributedText = arttirbu;
 
    
}
- (void)clickPay {
    !self.payBlock ? : self.payBlock();
}
- (void)addView {
    [self.contentView addSubview:self.mainView];
    [self.mainView addSubview:self.logoImageView];
    [self.mainView addSubview:self.titleLabel];
    [self.mainView addSubview:self.priceTitleLabel];
    [self.mainView addSubview:self.priceLabel];
    [self.mainView addSubview:self.stateTitleLabel];
    [self.mainView addSubview:self.stateLabel];
    [self.mainView addSubview:self.payButton];

}


- (void)updateConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NewProportion(40));
        make.left.mas_equalTo(NewProportion(30));
        make.right.mas_equalTo(-NewProportion(30));
        make.bottom.mas_equalTo(0);
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NewProportion(57));
        make.left.mas_equalTo(NewProportion(40));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImageView);
        make.left.mas_equalTo(self.logoImageView.mas_right).mas_offset(NewProportion(17));
     
    }];
    [self.priceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(NewProportion(65));
        make.centerX.mas_equalTo(self.mainView);
     
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceTitleLabel.mas_bottom).mas_offset(NewProportion(49));
        make.centerX.mas_equalTo(self.mainView);

      
    }];
    [self.stateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(NewProportion(78));
        make.left.mas_equalTo(self.logoImageView);
        make.centerY.mas_equalTo(self.payButton);
      
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.stateTitleLabel);
        make.left.mas_equalTo(self.stateTitleLabel.mas_right).mas_offset(NewProportion(60));
      make.centerY.mas_equalTo(self.payButton);

    }];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-NewProportion(47));
        make.right.mas_equalTo(-NewProportion(40));
        make.width.mas_equalTo(NewProportion(254));
        make.height.mas_equalTo(NewProportion(86));
        
      }];
    [super updateConstraints];
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc]init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = NewProportion(20);
    }
    return _mainView;
}


- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"logowuwumap_little"];
    }
    return _logoImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [ManagerEngine getColor:@"000000"];
        _titleLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _titleLabel.text = @"第一时间科技投资股份有限公司";
    }
    return _titleLabel;
}
- (UILabel *)priceTitleLabel {
    if (!_priceTitleLabel) {
        _priceTitleLabel = [[UILabel alloc]init];
        _priceTitleLabel.textColor = [ManagerEngine getColor:@"969799"];
        _priceTitleLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
        _priceTitleLabel.text = @"支付金额";
    }
    return _priceTitleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [ManagerEngine getColor:@"ff4949"];
        _priceLabel.font = [UIFont systemFontOfSize:NewProportion(40) weight:UIFontWeightBold];
//        _priceLabel.text = @"￥2980.00";
    }
    return _priceLabel;
}
- (UILabel *)stateTitleLabel {
    if (!_stateTitleLabel) {
        _stateTitleLabel = [[UILabel alloc]init];
        _stateTitleLabel.textColor = [ManagerEngine getColor:@"333333"];
        _stateTitleLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
//        _stateTitleLabel.text = @"支付状态";
    }
    return _stateTitleLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = [ManagerEngine getColor:@"969799"];
        _stateLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
//        _stateLabel.text = @"待支付";
    }
    return _stateLabel;
}
- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.backgroundColor = [ManagerEngine getColor:@"21a0ff"];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.layer.masksToBounds = YES;
        _payButton.layer.cornerRadius = NewProportion(42);
        [_payButton setTitle:@"去支付" forState:UIControlStateNormal];
        _payButton.hidden = YES;
        [_payButton addTarget:self action:@selector(clickPay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}
@end
