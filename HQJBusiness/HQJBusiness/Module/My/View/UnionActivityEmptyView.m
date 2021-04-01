//
//  ShowMobileView.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/23.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UnionActivityEmptyView.h"
@interface UnionActivityEmptyView ()
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UIImageView  *headImageView;
@property (nonatomic, strong) UIButton *sureButton;
@end
@implementation UnionActivityEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.headImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.sureButton];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.image = [UIImage imageNamed:@"commoditymanagement_emptypages"];
    }
    return _headImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [ManagerEngine getColor:@"939191"];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"亲，暂时没有数据哦！";
    }
    return _nameLabel;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = DefaultAPPColor;
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton setTitle:@"发起联盟券" forState:UIControlStateNormal];
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = 25;
        [_sureButton addTarget:self action:@selector(sureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
- (void)updateConstraints {
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, NewProportion(504)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(NewProportion(564), 50));
    }];
    [super updateConstraints];
}
- (void)sureButtonClicked{
    if (_sureButtonBlock) {
        _sureButtonBlock();
    }
}


@end
