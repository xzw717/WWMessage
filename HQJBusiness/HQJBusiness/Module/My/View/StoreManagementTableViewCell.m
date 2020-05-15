//
//  StoreManagementTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/13.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreManagementTableViewCell.h"
@interface StoreManagementTableViewCell ()
//@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UILabel *subTitLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
@implementation StoreManagementTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView addSubview:self.titleImageView];
        [self.contentView addSubview:self.titLabel];
        [self.contentView addSubview:self.subTitLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self updateConstraintsIfNeeded];

    }
    return self;
}
- (void)updateConstraints {
//    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make
//    }];
//    [super updateConstraints];
}
//- (UIImageView *)titleImageView {
//    if (!_titleImageView) {
//        _titleImageView = [[UIImageView alloc]init];
//        
//    }
//    return _titleImageView;
//}
- (UILabel *)titLabel {
    if (!_titLabel) {
        _titLabel = [[UILabel alloc]init];
        _titLabel.textColor = [ManagerEngine getColor:@"666666"];
        _titLabel.font = [UIFont systemFontOfSize:48.f];
        
    }
    return _titLabel;
}
- (UILabel *)subTitLabel {
    if (!_subTitLabel) {
        _subTitLabel = [[UILabel alloc]init];
        _subTitLabel.textColor = [ManagerEngine getColor:@"000000"];
        _subTitLabel.font = [UIFont systemFontOfSize:48.f];
    }
    return _subTitLabel;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"iocn_Select-right"];
    }
    return _arrowImageView;
}
@end
