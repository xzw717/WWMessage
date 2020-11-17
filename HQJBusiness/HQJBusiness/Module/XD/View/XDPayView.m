//
//  XDPayView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDPayView.h"
@interface XDPayView ()
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,strong) UILabel *payTypeLabel;
@property (nonatomic,strong) UIImageView *zfbImageView;
@property (nonatomic,strong) UILabel *zfbLabel;


@end



@implementation XDPayView

- (UILabel *)priceLabel{
    if ( _priceLabel == nil ) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _priceLabel.backgroundColor = [UIColor whiteColor];
        _priceLabel.textColor =  [ManagerEngine getColor:@"333333"];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLabel];

    }
    return _priceLabel;
}
- (UIView *)maskView{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_maskView];
    }
    return _maskView;
}

- (UILabel *)payTypeLabel{
    if ( _payTypeLabel == nil ) {
        _payTypeLabel = [[UILabel alloc]init];
        _payTypeLabel.font = [UIFont boldSystemFontOfSize:40/3];
        _payTypeLabel.text = @"选择支付方式";
        _payTypeLabel.textColor =  [ManagerEngine getColor:@"333333"];
        [self.maskView addSubview:_payTypeLabel];

    }
    return _payTypeLabel;
}
- (UIImageView *)zfbImageView{
    if (_zfbImageView == nil){
        _zfbImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pay_alipay"]];
        [self.maskView addSubview:_zfbImageView];
    }
    return _zfbImageView;
}
- (UILabel *)zfbLabel{
    if ( _zfbLabel == nil ) {
        _zfbLabel = [[UILabel alloc]init];
        _zfbLabel.font = [UIFont boldSystemFontOfSize:16];
        _zfbLabel.text = @"支付宝";
        _zfbLabel.textColor = [UIColor blackColor];
        [self.maskView addSubview:_zfbLabel];

    }
    return _zfbLabel;
}
- (UIButton *)selectBtn{
    if ( _selectBtn == nil ) {
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_cart_unsel"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_select"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.maskView addSubview:_selectBtn];

    }
    return _selectBtn;
}
- (UIButton *)payButton{
    if ( _payButton == nil ) {
        _payButton = [[UIButton alloc]init];
        _payButton.backgroundColor = DefaultAPPColor;
        _payButton.layer.masksToBounds = YES;
        _payButton.layer.cornerRadius = 115/6;
        [_payButton setTitle:[NSString stringWithFormat:@"去支付%@",TrainingVersion] forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:48/3];
        [self addSubview:_payButton];

    }
    return _payButton;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutTheSubviews];

    }
    
    return self;
}
- (void)layoutTheSubviews{
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(214/3);
    }];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(40/3);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(289/3);
    }];
    [self.payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(50/3);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    [self.zfbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50/3);
        make.top.mas_equalTo(self.payTypeLabel.mas_bottom).offset(40/3);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.zfbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.zfbImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.zfbImageView);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.maskView.mas_right).offset(-50/3);
        make.centerY.mas_equalTo(self.zfbImageView);
        make.size.mas_equalTo(CGSizeMake(60/3, 60/3));
    }];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-271/3);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(812/3, 115/3));
    }];
}
- (void)selectBtnClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
