//
//  StoreADCollectionViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/8/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreADCollectionViewCell.h"

@interface StoreADCollectionViewCell ()

@property (nonatomic, strong) UIImageView *leftTitleImageView;
@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *rightTitleImageView;
@property (nonatomic, strong) UILabel *rightTitleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@end
@implementation StoreADCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = NewProportion(30);
        //        [self addSubview:self.earnPointsImageView];
        //        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        [self.contentView addSubview:self.leftTitleImageView];
        [self.contentView addSubview:self.leftTitleLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.rightTitleImageView];
        [self.contentView addSubview:self.rightTitleLabel];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.height.mas_equalTo(self.contentView.mas_width).multipliedBy(0.5);
        }];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.width.height.mas_equalTo(self.contentView.mas_width).multipliedBy(0.5);
        }];
        
        
        [self.leftTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(68));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(22);
        }];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftTitleImageView.mas_right).mas_offset(NewProportion(30));
            make.centerY.mas_equalTo(self.contentView);
            
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.width.mas_equalTo(NewProportion(1));
            make.top.mas_equalTo(NewProportion(34));
            make.bottom.mas_equalTo(-NewProportion(34));
        }];
        
        
       
        [self.rightTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lineView.mas_right).mas_offset(NewProportion(68));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(22);

        }];
        [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.rightTitleImageView.mas_right).mas_offset(NewProportion(30));
            make.centerY.mas_equalTo(self.contentView);
            
        }];
    }
    return self;
}
- (UIImageView *)leftTitleImageView {
    if (!_leftTitleImageView) {
        _leftTitleImageView = [[UIImageView alloc]init];
        _leftTitleImageView.image = [UIImage  imageNamed:@"store_promotionCenter"];
    }
    return _leftTitleImageView;
}
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc]init];
        _leftTitleLabel.textColor = [ManagerEngine getColor:@"606266"];
        _leftTitleLabel.font = [UIFont systemFontOfSize:38/3.f weight:UIFontWeightMedium];
        _leftTitleLabel.text = @"推广中心";
        
    }
    return _leftTitleLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
    }
    return _lineView;
}
- (UIImageView *)rightTitleImageView {
    if (!_rightTitleImageView) {
        _rightTitleImageView = [[UIImageView alloc]init];
        _rightTitleImageView.image = [UIImage imageNamed:@"store_financialManagement"];
    }
    return _rightTitleImageView;
}
- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc]init];
        _rightTitleLabel.textColor = [ManagerEngine getColor:@"606266"];
        _rightTitleLabel.font = [UIFont systemFontOfSize:38/3.f weight:UIFontWeightMedium];
        _rightTitleLabel.text = @"物物理财";
        
    }
    return _rightTitleLabel;
}
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
       
        @weakify(self);
        [[_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            !self.clickLeftButton ? :self.clickLeftButton();
        }];
    }
    return _leftButton;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            !self.clickRightButton ? :self.clickRightButton();
        }];
    }
    return _rightButton;
}
@end
