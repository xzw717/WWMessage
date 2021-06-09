//
//  ShopNumberCollectionViewCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopNumberCollectionViewCell.h"
#import "ShopModel.h"
@interface ShopNumberCollectionViewCell ()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ShopNumberCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
        [self layoutView];
    }
    return self;
}
- (void)addView {
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.titleLabel];
    
}
- (void)setSpn_model:(ShopModel *)spn_model {
    _spn_model = spn_model;
    self.numberLabel.text = spn_model.sp_number;
    self.titleLabel.text = spn_model.sp_title;

}
- (void)layoutView {
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(48.f/3);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_bottom).mas_equalTo(53.f/3);
        make.centerX.mas_equalTo(self.contentView);
    }];
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:54.f/3 weight:UIFontWeightBold];
        _numberLabel.textColor = [ManagerEngine getColor:@"1b1b1b"];
        _numberLabel.text = @"+998.00";
        
    }
    return _numberLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:38.f/3 weight:UIFontWeightMedium];
        _titleLabel.textColor = [ManagerEngine getColor:@"626262"];
        _titleLabel.text = @"当日积分";
    }
    return _titleLabel;
}
@end
