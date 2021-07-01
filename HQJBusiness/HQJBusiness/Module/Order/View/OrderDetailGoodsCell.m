//
//  OrderDetailGoodsCell.m
//  WuWuMap
//
//  Created by Ethan on 2021/6/23.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailGoodsCell.h"
#import "GoodsModel.h"
@interface OrderDetailGoodsCell()
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UILabel *goodsSpecificationLabel;
@property (nonatomic, strong) UILabel *qutLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end
@implementation OrderDetailGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)addView {
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.goodsNameLabel];
    [self.contentView addSubview:self.goodsSpecificationLabel];
    [self.contentView addSubview:self.qutLabel];
    [self.contentView addSubview:self.priceLabel];
    
}
- (void)setOrderGoodsModel:(GoodsModel *)orderGoodsModel {
    _orderGoodsModel = orderGoodsModel;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,orderGoodsModel.mainpicture]]];
    self.goodsNameLabel.text = orderGoodsModel.goodsname;
//    self.goodsSpecificationLabel.text = orderGoodsModel.goodsname;
    self.qutLabel.text = [NSString stringWithFormat:@"x%ld",orderGoodsModel.goodscount];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",orderGoodsModel.goodsprice];
}

- (void)updateConstraints {
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(60.f));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(NewProportion(210.f));
    }];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(NewProportion(40));
        make.top.mas_equalTo(self.goodsImageView);
        make.width.mas_equalTo(WIDTH/3.f);
    }];
    [self.goodsSpecificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.goodsNameLabel);
        make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).mas_offset(NewProportion(50));
    }];
    [self.qutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.priceLabel.mas_left).mas_offset(-NewProportion(120));
        make.centerY.mas_equalTo(self.goodsNameLabel);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-NewProportion(60));
        make.centerY.mas_equalTo(self.goodsNameLabel);
    }];
    [super updateConstraints];
}
- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc]init];
        _goodsImageView.layer.masksToBounds = YES;
        _goodsImageView.layer.cornerRadius = 5.f;
    }
    return _goodsImageView;
}
- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc]init];
        _goodsNameLabel.textColor = [ManagerEngine getColor:@"333333"];
        _goodsNameLabel.font = [UIFont systemFontOfSize:NewProportion(40.f)];
   
    }
    return _goodsNameLabel;
}
- (UILabel *)goodsSpecificationLabel {
    if (!_goodsSpecificationLabel) {
        _goodsSpecificationLabel = [[UILabel alloc]init];
        _goodsSpecificationLabel.textColor = [ManagerEngine getColor:@"999999"];
        _goodsSpecificationLabel.font = [UIFont systemFontOfSize:NewProportion(40.f)];
    }
    return _goodsSpecificationLabel;
}
- (UILabel *)qutLabel {
    if (!_qutLabel) {
        _qutLabel = [[UILabel alloc]init];
        _qutLabel.textColor = [ManagerEngine getColor:@"888888"];
        _qutLabel.font = [UIFont systemFontOfSize:NewProportion(36.f)];
    }
    return _qutLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [ManagerEngine getColor:@"333333"];
        _priceLabel.font = [UIFont systemFontOfSize:NewProportion(40.f) weight:UIFontWeightBold];
    }
    return _priceLabel;
}
@end
