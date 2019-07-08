//
//  OrderTableViewFooterView.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/26.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderTableViewFooterView.h"
#import "OrderModel.h"
@interface OrderTableViewFooterView ()
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *countPriceLabel;
@property (nonatomic, strong) UIButton *contactBuyerButton;
@property (nonatomic, strong) UILabel *userDateLabel;
@property (nonatomic, strong) UIView *rectCornerBackgroundView;
@property (nonatomic, assign) BOOL isUseDate;
@end
@implementation OrderTableViewFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (!self) return nil;
//    self.contentView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.rectCornerBackgroundView];
    [self.rectCornerBackgroundView addSubview:self.timerLabel];
    [self.rectCornerBackgroundView addSubview:self.countPriceLabel];
    [self.rectCornerBackgroundView addSubview:self.contactBuyerButton];
    [self.rectCornerBackgroundView addSubview:self.userDateLabel];
    
    [self setLayout];

    return self;
}

- (void)setfootOrderModel:(OrderModel *)model
                    count:(NSInteger)count
                isUseDate:(BOOL)isUseDate {
    self.isUseDate = isUseDate;
    [self sd_clearViewFrameCache];
    [self setLayout];
    self.timerLabel.text = [NSString stringWithFormat:@"下单时间：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",model.date]]];
    if (model.type == 1) {
        if ([model.state isEqualToString:@"待使用"]) {
            self.contactBuyerButton.hidden = NO;
        } else {
            self.contactBuyerButton.hidden = YES;
        }
    } else {
        self.contactBuyerButton.hidden = YES;

    }
    
    if (model.usedate) {
        self.userDateLabel.hidden = NO;
        self.userDateLabel.text = [NSString stringWithFormat:@"核销时间：%@",[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",model.usedate]]];

    } else {
        self.userDateLabel.hidden = YES;
    }
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc]initWithString:count  ? [NSString stringWithFormat:@"共计%ld 件商品 合计：¥%.2f",(long)count,model.price] : [NSString stringWithFormat:@"合计：¥%.2f",model.price]];
    NSRange bigRange = NSMakeRange([[contentStr string] rangeOfString:[NSString stringWithFormat:@"¥%.2f",model.price]].location, [[contentStr string] rangeOfString:[NSString stringWithFormat:@"¥%.2f",model.price]].length);
    [contentStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:54/3.f] range:bigRange];
    self.countPriceLabel.attributedText = contentStr;
}


- (void)contactBuyer {
    !self.contactBuyerBlock ? : self.contactBuyerBlock();
}

- (void)setLayout {
//    @weakify(self);
//    [self setDidFinishAutoLayoutBlock:^(CGRect frame) {
//        @strongify(self);
//
//    }];
  

//    [self.timerLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
//    self.rectCornerBackgroundView.sd_layout.rightSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
    self.rectCornerBackgroundView.frame = CGRectMake(0, 0, WIDTH - 20, 88);
    [self.countPriceLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
    
    if (self.isUseDate) {
//        [self.userDateLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
   
        self.userDateLabel.sd_layout.leftEqualToView(self.timerLabel).rightSpaceToView(self.contactBuyerButton, kEDGE).topSpaceToView(self.timerLabel, 5).heightIs(15);
        
        self.countPriceLabel.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.userDateLabel, 5).heightIs(15);
    } else {
         self.countPriceLabel.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).topSpaceToView(self.rectCornerBackgroundView, 46/3.f).heightIs(15);
    }
    self.timerLabel.sd_layout.leftSpaceToView(self.rectCornerBackgroundView, kEDGE).rightSpaceToView(self.contactBuyerButton, kEDGE).topSpaceToView(self.countPriceLabel, 69/3.f).heightIs(15);

    self.contactBuyerButton.sd_layout.rightSpaceToView(self.rectCornerBackgroundView, kEDGE).centerYEqualToView(self.timerLabel).widthIs(224/3.f).heightIs(83/3.f);

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
        _userDateLabel.font = [UIFont systemFontOfSize:11.f];
        _userDateLabel.textColor = [ManagerEngine getColor:@"999999"];
    }
    return _userDateLabel;
}

- (UILabel *)countPriceLabel {
    if (!_countPriceLabel) {
        _countPriceLabel = [[UILabel alloc]init];
        _countPriceLabel.font = [UIFont systemFontOfSize:38/3.f];
        _countPriceLabel.textColor = [ManagerEngine getColor:@"333333"];

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
@end
