//
//  XDTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDTableViewCell.h"
#import "XDModel.h"
@interface XDTableViewCell ()
@property (nonatomic, strong) UIImageView *titImageView;
@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UILabel *subTitLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end
@implementation XDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titImageView];
        [self.contentView addSubview:self.titLabel];
        [self.contentView addSubview:self.subTitLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.arrowImageView];

        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setModel:(XDModel *)model {
    _model = model;
//    self.lineView.hidden = [model.businessName isEqualToString:@"生态企业"] ? YES : NO;
    [self.titImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,model.icon]]];
    self.titLabel.text = model.businessName;
    self.subTitLabel.text = model.platService;
}
- (void)updateConstraints {
    [self.titImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(50));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(NewProportion(84));

    }];
   
    [self.titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titImageView.mas_right).mas_offset(NewProportion(27));
        make.top.mas_equalTo(NewProportion(42));
    }];
  
    [self.subTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titLabel);
        make.right.mas_equalTo(-NewProportion(50));
        make.top.mas_equalTo(self.titLabel.mas_bottom).mas_offset(NewProportion(25));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5f);
        make.bottom.mas_equalTo(self.contentView);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-NewProportion(68));
        make.centerY.mas_equalTo(self.contentView);
      }];
    [super updateConstraints];
}

- (UIImageView *)titImageView {
    if (!_titImageView) {
        _titImageView = [[UIImageView alloc]init];
    }
    return _titImageView;
}
- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc]init];
        _titLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _titLabel.textColor = [ManagerEngine getColor:@"333333"];
    }
    return _titLabel;
}

- (UILabel *)subTitLabel {
    if (!_subTitLabel) {
          _subTitLabel = [[UILabel alloc]init];
          _subTitLabel.font = [UIFont systemFontOfSize:NewProportion(36)];
          _subTitLabel.textColor = [ManagerEngine getColor:@"b3b2b2"];
      }
      return _subTitLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
    }
    return _lineView;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"enter"];
    }
    return _arrowImageView;
}
@end