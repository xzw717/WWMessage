//
//  XDShopTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDShopTableViewCell.h"
@interface XDShopTableViewCell ()
@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UILabel *subTitLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
@implementation XDShopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titLabel];
        [self.contentView addSubview:self.subTitLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setTitle:(NSString *)tit {
    self.titLabel.text = tit;
}

- (void)setSubTitle:(NSInteger)state {
    /// state  1去完善  2查看信息  3修改信息  4审核中
    
    
    self.subTitLabel.hidden = [self.titLabel.text isEqualToString:@"企业基础信息"] ? NO : YES;
    switch (state) {
        case 1:
             self.subTitLabel.text = @"去完善";
            break;
            case 2:

            self.subTitLabel.text = @"审核成功";
            break;
            case 3:
 
            self.subTitLabel.text = @"审核失败";
            break;
            case 4:

            self.subTitLabel.text = @"审核中";
            break;
        default:
            break;
    }
   
    
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
    
    [self.subTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(self.contentView);
           make.right.mas_equalTo(self.arrowImageView.mas_left).mas_offset(-NewProportion(22));
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
- (UILabel *)subTitLabel {
    if (!_subTitLabel) {
        _subTitLabel = [[UILabel alloc]init];
        _subTitLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
        _subTitLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
    }
    return _subTitLabel;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"enter"];
    }
    return _arrowImageView;
}
@end
