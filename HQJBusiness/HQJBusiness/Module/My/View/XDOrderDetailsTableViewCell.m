//
//  XDOrderDetailsTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDOrderDetailsTableViewCell.h"
@interface XDOrderDetailsTableViewCell ()
@property (nonatomic, strong) UILabel *titLbale;
@property (nonatomic, strong) UILabel *subTitLabel;

@end
@implementation XDOrderDetailsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self.contentView addSubview:self.titLbale];
        [self.contentView addSubview:self.subTitLabel];
        [self updateConstraintsIfNeeded];
    }
    
    return self;
}
- (void)setTitLabel:(NSString *)tit subTitle:(NSString *)subTit {
    self.titLbale.text = tit;
    self.subTitLabel.text = subTit;
}
- (void)updateConstraints {
    [self.titLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(70));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.subTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.titLbale.mas_right).mas_offset(NewProportion(62));
          make.centerY.mas_equalTo(self.contentView);
    }];
    
    [super updateConstraints];
}

- (UILabel *)titLbale {
    if (!_titLbale) {
        _titLbale = [[UILabel alloc]init];
        _titLbale.font = [UIFont systemFontOfSize:NewProportion(40)];
        _titLbale.textColor = [ManagerEngine getColor:@"333333"];
    }
    return _titLbale;
}
- (UILabel *)subTitLabel {
    if (!_subTitLabel) {
        _subTitLabel = [[UILabel alloc]init];
        _subTitLabel.textColor = [ManagerEngine getColor:@"969799"];
        _subTitLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
    }
    return _subTitLabel;
}
@end
