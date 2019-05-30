//
//  OrderDetailsSixCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsSixCell.h"

@interface OrderDetailsSixCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timerLabel;
@end
@implementation OrderDetailsSixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timerLabel];
        
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setTimerStr:(NSInteger)timerStr {
    self.timerLabel.text = [ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",timerStr]];
}
- (void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
    }];

    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];

    
    [super updateConstraints];
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"下单时间";
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _titleLabel;
}
- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.text = @"2019-05-17 10:19";
        _timerLabel.font = [UIFont systemFontOfSize:14.f];
        _timerLabel.textColor = [ManagerEngine getColor:@"323232"];
    }
    return _timerLabel;
}
@end
