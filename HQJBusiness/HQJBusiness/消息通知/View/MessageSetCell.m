//
//  MessageSetCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/28.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageSetCell.h"

@interface MessageSetCell ()
@property (nonatomic, strong) UILabel *setTitleLabel;
@property (nonatomic, strong) UISwitch *setSwitch;
@end
@implementation MessageSetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.setTitleLabel];
        [self.contentView addSubview:self.setSwitch];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)switchChange:(UISwitch *)swi {
    if (self.delegate && [self.delegate respondsToSelector:@selector(returnTitle:switchState:)]) {
        [self.delegate returnTitle:self.setTitleLabel.text switchState:swi.on];
    }
}
- (void)titleContent:(NSString *)str switchState:(BOOL)state {
    self.setTitleLabel.text = str;
    [self.setSwitch setOn:state];
}
- (void)updateConstraints {
    [self.setTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(70.f));
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.setSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-NewProportion(70.f));
        make.centerY.mas_equalTo(self.contentView);
//        make.width.mas_equalTo(NewProportion(102.f));
//        make.height.mas_equalTo(NewProportion(62.f));
    }];
    [super updateConstraints];
}
- (UILabel *)setTitleLabel {
    if (!_setTitleLabel) {
        _setTitleLabel = [[UILabel alloc]init];
        _setTitleLabel.font = [UIFont systemFontOfSize:NewProportion(48.f)];
        _setTitleLabel.textColor = [UIColor colorWithHexString:@"000000"];
    }
    return _setTitleLabel;
}
- (UISwitch *)setSwitch {
    if (!_setSwitch) {
        _setSwitch = [[UISwitch alloc]init];
        [_setSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        _setSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);


    }
    return _setSwitch;
}
@end
