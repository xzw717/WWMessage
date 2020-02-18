//
//  PersonInfoCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopInfoSetCell.h"




#define LeftSpace 70/3.f
#define RightSpace 16.f
#define IconSpace 70/3.f

@interface ShopInfoSetCell ()
@property (nonatomic, strong) UILabel *tintLabel;
@end
@implementation ShopInfoSetCell


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"909399"];
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addTheSubviews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)addTheSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.setSwitch];
}

- (void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16.f);
        make.left.mas_offset(LeftSpace);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [self.setSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        
    }];
    [super updateConstraints];
}

- (UISwitch *)setSwitch {
    if (!_setSwitch) {
        _setSwitch = [[UISwitch alloc]init];
        [_setSwitch addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _setSwitch;
}
- (void)swChange:(UISwitch*) sw{
    !self.clickSwitchBlock ? : self.clickSwitchBlock(sw.on);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
