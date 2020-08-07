//
//  RewardSetHeaderView.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/3.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RewardSetHeaderView.h"
@interface RewardSetHeaderView ()
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation RewardSetHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.editButton];
        [self addSubview:self.titleLabel];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.editButton);
            make.left.mas_equalTo(15);
        }];
    }
    return self;
}

- (void)editAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEdit)]) {
        [self.delegate clickEdit];
    }
}
- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setImage:[UIImage imageNamed:@"icon_edit_2"] forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"员工邀请奖励(%)";
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _titleLabel;
}
@end
