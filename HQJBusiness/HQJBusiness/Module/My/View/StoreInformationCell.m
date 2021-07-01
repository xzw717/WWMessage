//
//  StoreInformationCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/10.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreInformationCell.h"
@interface StoreInformationCell ()
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *valueLabel;

@end
@implementation StoreInformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:48/3.f];
        self.textLabel.textColor = [ManagerEngine getColor:@"555555"];
        [self.contentView addSubview:self.logoImageView];
        [self.contentView addSubview:self.valueLabel];
 
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-50/3.f);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(110.f/3);
        }];
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.mas_equalTo(self.logoImageView);
        }];
    }
    return self;
}
- (void)setInformationDataDict:(NSDictionary *)informationDataDict {
    _informationDataDict = informationDataDict;
    self.logoImageView.hidden = [informationDataDict.allKeys[0] isEqualToString:@"店铺logo"] ? NO : YES;
    self.valueLabel.hidden =  !self.logoImageView.hidden ;
    self.textLabel.text = informationDataDict.allKeys[0];
    self.valueLabel.text = informationDataDict.allValues[0];
    self.logoImageView.image = [UIImage imageNamed:informationDataDict.allValues[0]];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.layer.cornerRadius = 5.f;
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.backgroundColor = [UIColor redColor];
    }
    return _logoImageView;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.font = [UIFont systemFontOfSize:48/3.f];
        _valueLabel.textColor = [ManagerEngine getColor:@"000000"];
        _valueLabel.text = @"粮满仓物物地图店";
    }
    return _valueLabel;
}
@end
