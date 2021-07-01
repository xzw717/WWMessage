//
//  WaitingEvaluationTableViewFootView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "OrderListTableViewFootView.h"
//#import "ClassificationModel.h"
#import "UIView+RoundedCorners.h"
@interface OrderListTableViewFootView ()
@property (nonatomic, strong) UIView *maskView;
//@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *numerLabl;
@property (nonatomic, strong) UILabel *allPriceLabel;
///
//@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UIButton *allStateButton;
//@property (nonatomic, strong) UIButton *cancelOrdearButton;
@end

@implementation OrderListTableViewFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.maskView hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,  WIDTH - NewProportion(30) * 2, 64) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:NewProportion(30)];
        [self addSubViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)addSubViews {
    [self.contentView addSubview:self.maskView];
//    [self.contentView addSubview:self.lineView];
//    [self.maskView addSubview:self.timerLabel];
    [self.maskView addSubview:self.numerLabl];
    [self.maskView addSubview:self.allPriceLabel];
//    [self.maskView addSubview:self.allStateButton];
//    [self.maskView addSubview:self.cancelOrdearButton];
}

- (void)updateConstraints {

    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(NewProportion(30));
        make.right.mas_equalTo(self.contentView.mas_right).offset(- NewProportion(30));
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(64.f);
    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(NewProportion(30));
//        make.left.right.mas_equalTo(self.maskView);
//        make.height.mas_equalTo(0.5f);
//    }];
    [self.allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.maskView.mas_right).offset(-15);
        make.top.mas_equalTo(NewProportion(45));
    }];
    
    [self.numerLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.allPriceLabel.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.allPriceLabel.mas_centerY);
    }];

//    [self.allStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.maskView.mas_right).offset(-50/3);
//        make.top.mas_equalTo(self.allPriceLabel.mas_bottom).offset(20);
//        make.size.mas_equalTo(CGSizeMake(75, 30));
//    }];
    
//    [self.cancelOrdearButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.allStateButton.mas_left).offset(-12);
//        make.centerY.mas_equalTo(self.allStateButton);
//        make.size.mas_equalTo(self.allStateButton);
//
//    }];
//    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//         make.centerY.mas_equalTo(self.allStateButton);
//    }];
    [super updateConstraints];
}

//- (void)evaluation:(UIButton *)btn {
//    if ([btn.titleLabel.text isEqualToString:@"立即评价"]) {
//        !self.evaluationBlcok ? : self.evaluationBlcok();
//    } else if ([btn.titleLabel.text isEqualToString:@"去支付"]) {
//        !self.payBlock ? : self.payBlock();
//    } else if ([btn.titleLabel.text isEqualToString:@"立即使用"]) {
//        !self.useBlock ? : self.useBlock(btn);
//    }
//    
//}
//
//- (void)cancelOrdear {
//    !self.cancelBlock ?: self.cancelBlock();
//}
/////////
- (void)setModel:(OrderModel *)model {
    _model = model;
//    double changeTime = model.time.doubleValue / 1000;
//
//    self.timerLabel.text = [ToolManager switchTimer:changeTime];
    
    
//    if (model.goodslist.count != 0) {
        self.numerLabl.text = @"实收金额：";
//    }
    double ryValue = model.zhValue *  2.f ;

    self.allPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.actualpayment && model.actualpayment > 0 ? model.actualpayment -  ryValue   : model.price];
    
//    self.cancelOrdearButton.hidden = ![model.state isEqualToString:@"待付款"] ? YES : NO;
//    if ([model.state isEqualToString:@"待付款"]) {
//        /// 待付款
//        [self.allStateButton setTitle:@"去支付" forState:UIControlStateNormal];
//    } else if ([model.state isEqualToString:@"待评价"]) {
//        /// 待评价
//        [self.allStateButton setTitle:@"立即评价" forState:UIControlStateNormal];
//    } else if ([model.state isEqualToString:@"待使用"]) {
//        /// 待使用
//        [self.allStateButton setTitle:@"立即使用" forState:UIControlStateNormal];
//    } else if ([model.state isEqualToString:@"订单取消"]) {
//        /// 已取消
//        self.allStateButton.hidden = YES;
//    } else {
//        /// 已完成
//        [self.allStateButton setTitle:@"已完成" forState:UIControlStateNormal];
//    }
}
//- (UIView *)lineView {
//    if (!_lineView) {
//        _lineView = [[UIView alloc]init];
//        _lineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
//    }
//    return _lineView;
//}
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        [_maskView setBackgroundColor:[UIColor whiteColor]];
    }
    return _maskView;
}
//- (UILabel *)timerLabel {
//    if (!_timerLabel) {
//        _timerLabel = [[UILabel alloc]init];
//        _timerLabel.font = [UIFont systemFontOfSize:12.0f];
//        _timerLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    }
//    return _timerLabel;
//}

- (UILabel *)numerLabl {
    if (!_numerLabl) {
        _numerLabl = [[UILabel alloc]init];
        _numerLabl.font = [UIFont systemFontOfSize:12.0f];
        _numerLabl.textColor = [ManagerEngine getColor:@"666666"];
    }
    return _numerLabl;
}


- (UILabel *)allPriceLabel {
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc]init];
        _allPriceLabel.font = [UIFont systemFontOfSize:18.0f];
        _allPriceLabel.textColor = MoneyDefaultColor;
    }
    return _allPriceLabel;
}
//- (UIButton *)allStateButton {
//    if (!_allStateButton) {
//        _allStateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_allStateButton.layer setBorderWidth:1.0f];
//        [_allStateButton setTitleColor:RedColor forState:UIControlStateNormal];
//        [_allStateButton.layer setBorderColor:RedColor.CGColor];
//        [_allStateButton.layer setMasksToBounds:YES];
//        _allStateButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//        [_allStateButton.layer setCornerRadius:15.0f];
//        _allStateButton.titleLabel.font = [UIFont systemFontOfSize:38.f/3];
//        [_allStateButton addTarget:self action:@selector(evaluation:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _allStateButton;
//}
//
//- (UIButton *)cancelOrdearButton {
//    if (!_cancelOrdearButton) {
//        _cancelOrdearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_cancelOrdearButton.layer setBorderWidth:1.0f];
//        [_cancelOrdearButton setTitle:@"取消" forState:UIControlStateNormal];
//        [_cancelOrdearButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
//        [_cancelOrdearButton.layer setBorderColor:[UIColor colorWithHexString:@"919191"].CGColor];
//        [_cancelOrdearButton.layer setMasksToBounds:YES];
//        [_cancelOrdearButton.layer setCornerRadius:15.0f];
//        _cancelOrdearButton.titleLabel.font = [UIFont systemFontOfSize:38.f/3];
//        [_cancelOrdearButton addTarget:self action:@selector(cancelOrdear) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _cancelOrdearButton;
//}

@end
