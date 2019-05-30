//
//  OrderDetailsTwoCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsTwoCell.h"
@interface OrderDetailsTwoCell ()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UILabel *contactLabel;
@end
@implementation OrderDetailsTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _addView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setNumber:(NSString *)number {
    self.numberLabel.text = number;
}

- (void)click{
    !self.cilckPhone?:self.cilckPhone();
}

- (void)_addView {
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.phoneImageView];
    [self.contentView addSubview:self.contactLabel];

    
}
- (void)updateConstraints {
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.5f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(6);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10.f);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contactLabel.mas_left).mas_offset(-6);
    }];
    
    
    [super updateConstraints];
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.text = @"";
        _numberLabel.font = [UIFont systemFontOfSize:14.f];
        _numberLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _numberLabel;
}
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.image = [UIImage imageNamed:@"order_user"];
    }
    return _headerImageView;
}
- (UIImageView *)phoneImageView {
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc]init];
        _phoneImageView.image = [UIImage imageNamed:@"order_contactBuyer"];

    }
    return _phoneImageView;
}
- (UILabel *)contactLabel {
    if (!_contactLabel) {
        _contactLabel = [[UILabel alloc]init];
        _contactLabel.text = @"联系买家";
        _contactLabel.font = [UIFont systemFontOfSize:14.f];
        _contactLabel.textColor = DefaultAPPColor;
        _contactLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
        [_contactLabel addGestureRecognizer:tap];
    }
    return _contactLabel;
}
@end
