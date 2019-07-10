//
//  PersonInfoCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopManagerCell.h"




#define LeftSpace 70/3.f
#define RightSpace 16.f

#define IconSpace 70/3.f

@interface ShopManagerCell ()
@property (nonatomic, strong) UIImageView *rightImageView;
@end
@implementation ShopManagerCell


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"909399"];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:16.f];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.textColor = [ManagerEngine getColor:@"000000"];
    }
    return _detailLabel;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.image = [UIImage imageNamed:@"my_button_enter_black"];
    }
    return _rightImageView;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addTheSubviews];
        [self layoutTheSubviews];
    }
    return self;
}
- (void)addTheSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.rightImageView];
}

- (void)layoutTheSubviews{
    self.titleLabel.sd_layout.leftSpaceToView(self, LeftSpace).centerYEqualToView(self).heightIs(20.f).widthIs(WIDTH/2-30);
    self.detailLabel.sd_layout.rightSpaceToView(self, 110.f/3).centerYEqualToView(self).heightIs(20.f).widthIs(WIDTH/2-70);
    self.rightImageView.sd_layout.rightSpaceToView(self, RightSpace).centerYEqualToView(self).heightIs(20.f).widthIs(15.f);
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
