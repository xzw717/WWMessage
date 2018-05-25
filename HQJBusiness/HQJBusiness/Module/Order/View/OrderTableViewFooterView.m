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
@property (nonatomic, assign) BOOL isUseDate;
@end
@implementation OrderTableViewFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.contentView addSubview:self.timerLabel];
    [self.contentView addSubview:self.countPriceLabel];
    [self.contentView addSubview:self.contactBuyerButton];
    [self.contentView addSubview:self.userDateLabel];
    self.contentView.backgroundColor = [UIColor whiteColor];
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

    self.countPriceLabel.text = count  ? [NSString stringWithFormat:@"数量：%ld  合计：¥%.2f",(long)count,model.price] : [NSString stringWithFormat:@"合计：¥%.2f",model.price];
}


- (void)contactBuyer {
    !self.contactBuyerBlock ? : self.contactBuyerBlock();
}

- (void)setLayout {
//    [self.timerLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
    [self.countPriceLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
    self.timerLabel.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contactBuyerButton, kEDGE).topSpaceToView(self.contentView, 5).heightIs(15);
    
    if (self.isUseDate) {
//        [self.userDateLabel setSingleLineAutoResizeWithMaxWidth:WIDTH /2];
   
        self.userDateLabel.sd_layout.leftEqualToView(self.timerLabel).rightSpaceToView(self.contactBuyerButton, kEDGE).topSpaceToView(self.timerLabel, 5).heightIs(15);
        
        self.countPriceLabel.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.userDateLabel, 5).heightIs(15);
    } else {
         self.countPriceLabel.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.timerLabel, 5).heightIs(15);
    }
    
 
    self.contactBuyerButton.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView).widthIs(60).heightIs(30);
}

- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.font = [UIFont systemFontOfSize:11.f];
        _timerLabel.textColor = [ManagerEngine getColor:@"999999"];
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
        _countPriceLabel.font = [UIFont systemFontOfSize:11.f];
        _countPriceLabel.textColor = [ManagerEngine getColor:@"999999"];

    }
    return _countPriceLabel;
}

- (UIButton *)contactBuyerButton {
    if (!_contactBuyerButton) {
        _contactBuyerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactBuyerButton.layer.masksToBounds = YES;
        _contactBuyerButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        _contactBuyerButton.layer.cornerRadius = 5.f;
        _contactBuyerButton.layer.borderColor = DefaultAPPColor.CGColor;
        _contactBuyerButton.layer.borderWidth = 0.5f;
        [_contactBuyerButton setTitle:@"联系买家" forState:UIControlStateNormal];
        [_contactBuyerButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        [_contactBuyerButton addTarget:self action:@selector(contactBuyer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBuyerButton;
}
@end
