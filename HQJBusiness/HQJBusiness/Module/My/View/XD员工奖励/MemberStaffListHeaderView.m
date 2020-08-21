//
//  MemberStaffListHeaderView.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MemberStaffListHeaderView.h"
@interface MemberStaffListHeaderView ()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *bossNameLabel;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UIView *bottomLinkView;
@end
@implementation MemberStaffListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headerImageView];
        [self addSubview:self.bossNameLabel];
        [self addSubview:self.shopNameLabel];
        [self addSubview:self.bottomLinkView];
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(50));
            make.top.mas_equalTo(NewProportion(53));
            make.width.height.mas_equalTo(NewProportion(165));
        }];
        [self.bossNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(NewProportion(30));
            make.top.mas_equalTo(NewProportion(85));
        }];
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bossNameLabel);
            make.top.mas_equalTo(self.bossNameLabel.mas_bottom).mas_offset(NewProportion(20));
        }];
        [self.bottomLinkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-3);
            make.right.mas_equalTo(-3);
            make.height.mas_equalTo(NewProportion(42));
            make.bottom.mas_equalTo(self);
        }];
    }
    return self;
}
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.image = [UIImage imageNamed:@"headportrait"];
        _headerImageView.layer.masksToBounds =  YES;
        _headerImageView.layer.cornerRadius = NewProportion(165)/2.f;
    }
    return _headerImageView;
}
- (UILabel *)bossNameLabel {
    if (!_bossNameLabel) {
        _bossNameLabel = [[UILabel alloc]init];
        _bossNameLabel.text = @"";
        _bossNameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:NewProportion(36)];
        _bossNameLabel.textColor = [ManagerEngine getColor:@"000000"];
    }
    return _bossNameLabel;
}
- (UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc]init];
        _shopNameLabel.text = [NameSingle shareInstance].name;
        _shopNameLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _shopNameLabel.textColor = [ManagerEngine getColor:@"555555"];
    }
    return _shopNameLabel;
}
- (UIView *)bottomLinkView {
    if (!_bottomLinkView) {
        _bottomLinkView = [[UIView alloc]init];
        _bottomLinkView.backgroundColor = [ManagerEngine getColor:@"f4f4f4"];
        _bottomLinkView.layer.borderColor = [[ManagerEngine getColor:@"d5d5d5"]CGColor];
        _bottomLinkView.layer.borderWidth = 0.5f;
    }
    return _bottomLinkView;
}
@end
