//
//  OrderCompleteFootView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/8.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//



#import "OrderCompleteFootView.h"
#import "OrderModel.h"
@interface OrderCompleteFootView ()
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *countPriceLabel;
@property (nonatomic, strong) UIButton *contactBuyerButton;
@property (nonatomic, strong) UILabel *userDateLabel;
@property (nonatomic, strong) UIView *rectCornerBackgroundView;
@property (nonatomic, assign) BOOL isUseDate;
@property (nonatomic, strong) UIView *firstLine;
@property (nonatomic, strong) UIView *lastLine;
@property (nonatomic, strong) UILabel *realityCashLabel;
@property (nonatomic, strong) UILabel *realityRYLabel;
@property (nonatomic, strong) OrderModel *c_mdoel;
@end
@implementation OrderCompleteFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    //    self.contentView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.rectCornerBackgroundView];
    [self.rectCornerBackgroundView addSubview:self.timerLabel];
    [self.rectCornerBackgroundView addSubview:self.countPriceLabel];
    [self.rectCornerBackgroundView addSubview:self.contactBuyerButton];
    [self.rectCornerBackgroundView addSubview:self.userDateLabel];
    [self.rectCornerBackgroundView addSubview:self.firstLine];
    [self.rectCornerBackgroundView addSubview:self.lastLine];
    [self.rectCornerBackgroundView addSubview:self.realityCashLabel];
    [self.rectCornerBackgroundView addSubview:self.realityRYLabel];

    [self setLayout];
    
    return self;
}

- (void)setfootOrderModel:(OrderModel *)model
                    count:(NSInteger)count
                isUseDate:(BOOL)isUseDate {
    self.c_mdoel = model;
    self.isUseDate = isUseDate;
    [self sd_clearViewFrameCache];
    [self setLayout];
    self.timerLabel.text = [NSString stringWithFormat:@"下单时间：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",model.date]]];
//    if (model.type == 1) {
        if ([model.state isEqualToString:@"待评价"]) {
            self.timerLabel.hidden = NO;
            self.userDateLabel.hidden = NO;
            [self.contactBuyerButton setTitle:@"订单详情" forState:UIControlStateNormal];
            self.timerLabel.text = [NSString stringWithFormat:@"下单时间：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",model.date]]];
            self.userDateLabel.text = [NSString stringWithFormat:@"核销时间：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",model.usedate]]];

        } else {
//            self.timerLabel.hidden = YES;
            self.userDateLabel.hidden = YES;
            [self.contactBuyerButton setTitle:@"联系买家" forState:UIControlStateNormal];
            self.timerLabel.text = [NSString stringWithFormat:@"支付时间：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",model.date]]];

        }
//    } else {
//        self.contactBuyerButton.hidden = YES;
//
//    }
    
//    if (model.usedate) {
//        self.userDateLabel.hidden = NO;
//        self.userDateLabel.text = [NSString stringWithFormat:@"核销时间：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",model.usedate]]];
//
//    } else {
//        self.userDateLabel.hidden = YES;
//    }
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc]initWithString:count  ? [NSString stringWithFormat:@"共计%ld件商品  合计：¥%.2f",(long)count,model.price] : [NSString stringWithFormat:@"合计：¥%.2f",model.price]];
    NSRange bigRange = NSMakeRange([[contentStr string] rangeOfString:[NSString stringWithFormat:@"¥%.2f",model.price]].location, [[contentStr string] rangeOfString:[NSString stringWithFormat:@"¥%.2f",model.price]].length);
    [contentStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:54/3.f] range:bigRange];
    self.countPriceLabel.attributedText = contentStr;
}


- (void)contactBuyer {
    !self.contactBuyerBlock ? : self.contactBuyerBlock();
}

- (void)setLayout {
    
    self.countPriceLabel.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).leftSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.rectCornerBackgroundView, 0).heightIs(15);
    self.firstLine.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, 0).rightSpaceToView(self.rectCornerBackgroundView, 0).topSpaceToView(self.countPriceLabel, 10).heightIs(.5f);
    self.realityCashLabel.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).leftSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.firstLine, 10).heightIs(15);
    self.realityRYLabel.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.realityCashLabel, 10).heightIs(15).leftSpaceToView(self.rectCornerBackgroundView, kEDGE);
    self.lastLine.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, 0).rightSpaceToView(self.rectCornerBackgroundView, 0).topSpaceToView(self.realityRYLabel, 10).heightIs(.5f);

    [self.timerLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
    [self.userDateLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
    self.rectCornerBackgroundView.frame = CGRectMake(0, 0, WIDTH - 20, CompleteFootHeight);
    if ([self.c_mdoel.state isEqualToString:@"待评价"]) {
        self.timerLabel.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.lastLine, 56/3.f).heightIs(15);

    } else {
        self.timerLabel.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, kEDGE).centerYEqualToView(self.contactBuyerButton).heightIs(15);

    }
    self.userDateLabel.sd_layout.leftEqualToView(self.timerLabel).topSpaceToView(self.timerLabel, 5).heightIs(15);
    self.contactBuyerButton.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.lastLine, 68/3.f) .widthIs(224/3.f).heightIs(83/3.f);

//    if (self.isUseDate) {
    
//        self.userDateLabel.sd_layout.leftEqualToView(self.timerLabel).rightSpaceToView(self.contactBuyerButton, kEDGE).topSpaceToView(self.timerLabel, 5).heightIs(15);
    
//        self.countPriceLabel.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, kEDGE).leftSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.userDateLabel, 5).heightIs(15);
//    } else {
//        self.countPriceLabel.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).leftSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.rectCornerBackgroundView, 46/3.f).heightIs(15);
//    }
    
    
    [self.rectCornerBackgroundView cornerRadiusWithType:UIRectCornerBottomLeft | UIRectCornerBottomRight radiusCount:TableViewCellCornerRadius];
}

- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.font = [UIFont systemFontOfSize:38/3.f];
        _timerLabel.textColor = [ManagerEngine getColor:@"333333"];
    }
    return _timerLabel;
}

- (UILabel *)userDateLabel {
    if (!_userDateLabel) {
        _userDateLabel = [[UILabel alloc]init];
        _userDateLabel.font = [UIFont systemFontOfSize:38/3.f];
        _userDateLabel.textColor = [ManagerEngine getColor:@"333333"];
    }
    return _userDateLabel;
}

- (UILabel *)countPriceLabel {
    if (!_countPriceLabel) {
        _countPriceLabel = [[UILabel alloc]init];
        _countPriceLabel.font = [UIFont systemFontOfSize:38/3.f];
        _countPriceLabel.textColor = [ManagerEngine getColor:@"333333"];
        _countPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countPriceLabel;
}

- (UIButton *)contactBuyerButton {
    if (!_contactBuyerButton) {
        _contactBuyerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactBuyerButton.layer.masksToBounds = YES;
        _contactBuyerButton.titleLabel.font = [UIFont systemFontOfSize:38/3.f];
        _contactBuyerButton.layer.cornerRadius = 83/3/2.f;
        _contactBuyerButton.layer.borderColor = [UIColor blackColor].CGColor;
        _contactBuyerButton.layer.borderWidth = 0.5f;
        [_contactBuyerButton setTitle:@"联系买家" forState:UIControlStateNormal];
        [_contactBuyerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_contactBuyerButton addTarget:self action:@selector(contactBuyer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBuyerButton;
}
- (UIView *)rectCornerBackgroundView {
    if (!_rectCornerBackgroundView) {
        _rectCornerBackgroundView = [[UIView alloc]init];
        _rectCornerBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    return _rectCornerBackgroundView;
}
- (UIView *)firstLine {
    if (!_firstLine) {
        _firstLine = [[UIView alloc]init];
        _firstLine.backgroundColor = DefaultBackgroundColor;
        
    }
    return _firstLine;
}
- (UIView *)lastLine {
    if (!_lastLine) {
        _lastLine = [[UIView alloc]init];
        _lastLine.backgroundColor = DefaultBackgroundColor;
        
    }
    return _lastLine;
}
- (UILabel *)realityCashLabel {
    if (!_realityCashLabel) {
        _realityCashLabel = [[UILabel alloc]init];
        _realityCashLabel.backgroundColor = [UIColor whiteColor];
        _realityCashLabel.text = @"实收：￥67.00";
        _realityCashLabel.textAlignment = NSTextAlignmentRight;
        _realityCashLabel.font = [UIFont systemFontOfSize:38/3.f];

    }
    return _realityCashLabel;
}

- (UILabel *)realityRYLabel {
    if (!_realityRYLabel) {
        _realityRYLabel = [[UILabel alloc]init];
        _realityRYLabel.backgroundColor = [UIColor whiteColor];
        _realityRYLabel.font = [UIFont systemFontOfSize:38/3.f];
        _realityRYLabel.text = @"RY值：50个(￥100)";
        _realityRYLabel.textAlignment = NSTextAlignmentRight;

    }
    return _realityRYLabel;
}


@end
