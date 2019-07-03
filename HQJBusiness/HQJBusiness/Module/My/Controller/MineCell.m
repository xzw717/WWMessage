//
//  MineCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MineCell.h"

#define IconImageSize 30.f
#define IconLeftSpace 17.f

@interface MineCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end
@implementation MineCell


#pragma lazy-load
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"606266"];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.image = [UIImage imageNamed:@"my_button_enter_black"];
        [self addSubview:_rightImageView];
    }
    return _rightImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layoutTheSubviews];
    }
    return self;
}
- (void)layoutTheSubviews{
    
    self.iconImageView.sd_layout.leftSpaceToView(self,IconLeftSpace).topSpaceToView(self, 10).heightIs(IconImageSize).widthIs(IconImageSize);
    self.titleLabel.sd_layout.leftSpaceToView(self.iconImageView,IconLeftSpace).centerYEqualToView(self.iconImageView).heightIs(30.f).widthIs(200.f);
    self.rightImageView.sd_layout.rightSpaceToView(self, IconLeftSpace).centerYEqualToView(self.iconImageView).heightIs(20.f).widthIs(20.f);
    
}

- (void)setItemArray:(NSMutableArray *)itemArray{
    
    self.titleLabel.text = itemArray[0];
    self.iconImageView.image = [UIImage imageNamed:itemArray[1]];
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
