//
//  OrderDetailsFourCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsFourCell.h"

@interface OrderDetailsFourCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end
@implementation OrderDetailsFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setPriceStr:(CGFloat)priceStr {
    self.priceLabel.text =  [NSString stringWithFormat:@"¥%.2f",priceStr];
}

- (void)updateConstraints {
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.priceLabel.mas_left).mas_offset(-22);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [super updateConstraints];
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"实付";
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"￥293";
        _priceLabel.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightBold];
        _priceLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _priceLabel;
}
@end
