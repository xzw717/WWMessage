//
//  ShopCollectionViewCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopCollectionViewCell.h"
#import "ShopModel.h"
@interface ShopCollectionViewCell ()
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ShopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
        [self layoutView];
    }
    return self;
}
- (void)addView {
    [self.contentView addSubview:self.titleImageView];
    [self.contentView addSubview:self.titleLabel];
    
}
- (void)setSp_model:(ShopModel *)sp_model {
    _sp_model = sp_model;
    self.titleLabel.text = sp_model.sp_title;
    self.titleImageView.image = [UIImage imageNamed:sp_model.sp_image];
}
- (void)layoutView {
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(42.f/3);
        make.height.width.mas_equalTo(90.f/3);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView.mas_bottom).mas_equalTo(30.f/3);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self);
    }];
}
- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
    }
    return _titleImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:38.f/3 weight:UIFontWeightMedium];
        _titleLabel.textColor = [ManagerEngine getColor:@"626262"];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
