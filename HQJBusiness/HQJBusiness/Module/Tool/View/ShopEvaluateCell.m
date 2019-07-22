//
//  ToolCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/1.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopEvaluateCell.h"

#define LeftSpace 20.f
#define TopSpace 44.f/3

#define NameLeftSpace 12.f


@interface ShopEvaluateCell ()
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@end



@implementation ShopEvaluateCell

#pragma mark lazy_load

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.image = [UIImage imageNamed:@"icon_name"];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 10.f;
        [self addSubview:_headImageView];
    }
    return _headImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:17.f];
        _nameLabel.textColor = [ManagerEngine getColor:@"464648"];
        _nameLabel.text = @"陈哈哈";
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:40.f/3];
        _timeLabel.textColor = [ManagerEngine getColor:@"909399"];
        _timeLabel.text = @"2019-7-22 3:35";
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:16.f];
        _contentLabel.textColor = [ManagerEngine getColor:@"464648"];
        _contentLabel.numberOfLines = 1;
        _contentLabel.text = @"这是一条精彩的评价";
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self updateConstraintsIfNeeded];
        [self layoutTheSubviews];
    }
    return self;
}

- (void)layoutTheSubviews{
    self.headImageView.sd_layout.leftSpaceToView(self, LeftSpace).topSpaceToView(self, TopSpace).heightIs(48.f).widthIs(48.f);
    self.nameLabel.sd_layout.leftSpaceToView(self.headImageView, NameLeftSpace).rightEqualToView(self).topSpaceToView(self, 58.f/3).heightIs(20.f);
    self.timeLabel.sd_layout.leftSpaceToView(self.headImageView, NameLeftSpace).rightEqualToView(self).topSpaceToView(self.nameLabel, 10.f).heightIs(20.f);
    self.contentLabel.sd_layout.leftSpaceToView(self, LeftSpace).rightSpaceToView(self, LeftSpace).topSpaceToView(self.timeLabel, 20.f).heightIs(20.f);
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
