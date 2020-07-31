//
//  RecordsConsumptionCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/31.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RecordsConsumptionCell.h"
@interface RecordsConsumptionCell ()
@property (nonatomic, strong) UILabel *buyTypeLabel;
@property (nonatomic, strong) UILabel *timerlabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *currencyTypeLabel;

@end
@implementation RecordsConsumptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.buyTypeLabel];
        [self.contentView addSubview:self.timerlabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.currencyTypeLabel];
        
        [self.buyTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(50));
            make.top.mas_equalTo(NewProportion(50));
        }];
        [self.timerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buyTypeLabel);
            make.top.mas_equalTo(self.buyTypeLabel.mas_bottom).mas_offset(NewProportion(30));
        }];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(50));
            make.centerY.mas_equalTo(self.buyTypeLabel);
        }];
        [self.currencyTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.numberLabel);
            make.centerY.mas_equalTo(self.timerlabel);
        }];
    }
    return self;
}
- (UILabel *)buyTypeLabel {
    if (!_buyTypeLabel) {
        _buyTypeLabel = [[UILabel alloc]init];
        _buyTypeLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _buyTypeLabel.textColor = [ManagerEngine getColor:@"000000"];
        _buyTypeLabel.text = @"优惠买单";
    }
    return _buyTypeLabel;
}
- (UILabel *)timerlabel {
    if (!_timerlabel) {
        _timerlabel = [[UILabel alloc]init];
        _timerlabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _timerlabel.textColor = [ManagerEngine getColor:@"000000"];
        _timerlabel.text = @"2020-13-32";
    }
    return _timerlabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _numberLabel.textColor = [ManagerEngine getColor:@"000000"];
        _numberLabel.text = @"+15";
    }
    return _numberLabel;
}
- (UILabel *)currencyTypeLabel {
    if (!_currencyTypeLabel) {
        _currencyTypeLabel = [[UILabel alloc]init];
        _currencyTypeLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _currencyTypeLabel.textColor = [ManagerEngine getColor:@"000000"];
        _currencyTypeLabel.text = @"积分";
    }
    return _currencyTypeLabel;
}
@end
