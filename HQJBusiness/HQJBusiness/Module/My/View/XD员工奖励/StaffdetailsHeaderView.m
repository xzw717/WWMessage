//
//  StaffdetailsHeaderView.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StaffdetailsHeaderView.h"
@interface StaffdetailsHeaderView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *companyLabel;

@end
@implementation StaffdetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.companyLabel];
        [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(70));
            make.bottom.mas_equalTo(-NewProportion(80));
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.companyLabel);
            make.bottom.mas_equalTo(self.companyLabel.mas_top).mas_offset(-NewProportion(30));
        }];
    }
    return self;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:NewProportion(86)];
        _nameLabel.textColor = [ManagerEngine getColor:@"ffffff"];
        _nameLabel.text = @"刘玄德";
    }
    return _nameLabel;
}
- (UILabel *)companyLabel {
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc]init];
        _companyLabel.font = [UIFont systemFontOfSize:NewProportion(46)];
        _companyLabel.textColor = [ManagerEngine getColor:@"ffffff"];
        _companyLabel.text = @"三国时期蜀国国主";
        
    }
    return _companyLabel;
}
@end
