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
@property (nonatomic,strong) UILabel *couponLabel;

@end
@implementation OrderDetailsFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.couponLabel];

        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setPriceStr:(CGFloat)priceStr {
    self.priceLabel.text =  [NSString stringWithFormat:@"¥%.2f",priceStr];
}
- (void)setCouponString:(NSString *)couponString {
    self.couponLabel.text = couponString;
//    [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-10);
//    }];
    
//    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.priceLabel);
//    }];

 
}
- (void)updateConstraints {
    
    [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.couponLabel.mas_bottom).mas_offset(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.priceLabel.mas_left).mas_offset(-22);
        make.centerY.mas_equalTo(self.priceLabel);
    }];

    [super updateConstraints];
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"实收";
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
-(UILabel *)couponLabel {
    if ( _couponLabel == nil ) {
        _couponLabel = [[UILabel alloc]init];
        _couponLabel.font = [UIFont systemFontOfSize:12.0];
        _couponLabel.textColor = [ManagerEngine getColor:@"ff4949"];
        _couponLabel.textAlignment = NSTextAlignmentRight;
    }
    return _couponLabel;
}
@end
