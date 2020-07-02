//
//  XDShopTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ContactManagerCell.h"
@interface ContactManagerCell ()
@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
@implementation ContactManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    self.titLabel.text = title;
}

- (void)updateConstraints {
    [self.titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(NewProportion(68));
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(-NewProportion(50));
           make.centerY.mas_equalTo(self.contentView);
    }];
    
    [super updateConstraints];
}

- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc]init];
        _titLabel.textColor = [ManagerEngine getColor:@"666666"];
        _titLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
    }
    return _titLabel;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"enter"];
    }
    return _arrowImageView;
}
@end
