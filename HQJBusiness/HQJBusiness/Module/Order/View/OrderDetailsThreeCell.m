//
//  OrderDetailsThreeCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsThreeCell.h"
@interface OrderDetailsThreeCell ()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end
@implementation OrderDetailsThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _addView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)goodsImage:(NSString *)image
         goodsName:(NSString *)name
        goodsCount:(NSInteger)count
        goodsPrice:(CGFloat)price {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,image]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    self.nameLabel.text = name;
    self.numberLabel.text = [NSString stringWithFormat:@"x%ld",(long)count];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",price] ;
}


- (void)_addView {
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    
    
}
- (void)updateConstraints {
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(41, 41));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(56.5f);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-10);
    }];
    
    
    [super updateConstraints];
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.text = @"x3";
        _numberLabel.font = [UIFont systemFontOfSize:10.f];
        _numberLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _numberLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"￥223";
        _priceLabel.font = [UIFont systemFontOfSize:14.f];
        _priceLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _priceLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"213asdasdasd下次主线程";
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
        _nameLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _nameLabel;
}
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
   
    }
    return _headerImageView;
}

@end
