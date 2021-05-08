//
//  AddUnionImageCell.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionSubCell.h"
#define LeftMargin 10
@interface AddUnionSubCell ()

@property (nonatomic, strong) UIButton *addButton;
@end
@implementation AddUnionSubCell
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"icon_minus"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(minusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.addButton];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)updateConstraints {
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-LeftMargin);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [super updateConstraints];
}
- (void)minusButtonClicked{
    if (_minusButtonBlock) {
        _minusButtonBlock();
    }
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
