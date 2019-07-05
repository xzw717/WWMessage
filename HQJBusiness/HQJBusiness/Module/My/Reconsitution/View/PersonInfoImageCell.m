//
//  PersonInfoImageCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/5.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PersonInfoImageCell.h"


#define IconBigImageSize 36.f
#define IconImageSize 15.f

#define LeftSpace 70/3.f
#define RightSpace 16.f

#define IconSpace 40/3.f
@interface PersonInfoImageCell ()

@property (nonatomic, strong) UIImageView *rightImageView;

@end
@implementation PersonInfoImageCell

#pragma lazy-load

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"909399"];
    }
    return _titleLabel;
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
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
    [self addSubview:self.iconImageView];
    [self addSubview:self.rightImageView];
}

- (void)layoutTheSubviews{
    self.titleLabel.sd_layout.leftSpaceToView(self, LeftSpace).centerYEqualToView(self).heightIs(20.f).widthIs(WIDTH/2-30);
    self.rightImageView.sd_layout.rightSpaceToView(self, RightSpace).centerYEqualToView(self).heightIs(20.f).widthIs(15.f);
    if (_style == CellStyleImage) {
        self.iconImageView.sd_layout.rightSpaceToView(self.rightImageView, IconSpace).centerYEqualToView(self).heightIs(IconImageSize).widthIs(IconImageSize);
    } else {
        self.iconImageView.sd_layout.rightSpaceToView(self.rightImageView, IconSpace).centerYEqualToView(self).heightIs(IconBigImageSize).widthIs(IconBigImageSize);
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
