//
//  UnionActivityCell.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/1/26.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UnionActivityCell.h"

#define LeftMargin 10
@interface UnionActivityCell ()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UIButton  *stateButton;
@property (nonatomic, strong) UIImageView *coverImageView;
@end

@implementation UnionActivityCell

- (UIView *)maskView{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor whiteColor];;
        _maskView.layer.masksToBounds = YES;
        _maskView.layer.cornerRadius = 10;
    }
    return _maskView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:NewProportion(48)];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [ManagerEngine getColor:@"777777"];
        _timeLabel.font = [UIFont systemFontOfSize:NewProportion(36)];
    }
    return _timeLabel;
}
- (UILabel *)endTimeLabel {
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc]init];
        _endTimeLabel.textColor = [ManagerEngine getColor:@"777777"];
        _endTimeLabel.font = [UIFont systemFontOfSize:NewProportion(36)];
    }
    return _endTimeLabel;
}

- (UIButton *)stateButton {
    if (!_stateButton) {
        _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stateButton.backgroundColor = [ManagerEngine getColor:@"ffc82d"];
        _stateButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
        [_stateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _stateButton.layer.masksToBounds = YES;
        _stateButton.layer.cornerRadius = 5;
    }
    return _stateButton;
}
- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.hidden = YES;
        [_editButton setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    }
    return _editButton;
}
- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc]init];
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.layer.cornerRadius = 5;
    }
    return _coverImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.maskView];
        [self.maskView addSubview:self.nameLabel];
        [self.maskView addSubview:self.timeLabel];
        [self.maskView addSubview:self.endTimeLabel];
        [self.maskView addSubview:self.editButton];
        [self.maskView addSubview:self.stateButton];
        [self.maskView addSubview:self.coverImageView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40/3);
        make.left.mas_equalTo(LeftMargin);
        make.right.mas_equalTo(-LeftMargin);
        make.bottom.mas_equalTo(self);
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LeftMargin);
        make.right.mas_equalTo(-LeftMargin);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20.0f);
        make.left.mas_equalTo(LeftMargin);
        make.size.mas_equalTo(CGSizeMake(WIDTH-100, 20));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LeftMargin);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(15.0f);
    }];
    [self.stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom);
        make.right.mas_equalTo(self.maskView.mas_right).mas_offset(-LeftMargin);
        make.size.mas_equalTo(CGSizeMake(55, 20));
    }];

    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.stateButton.mas_left).mas_offset(-5);
        make.height.mas_equalTo(15.0f);
    }];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LeftMargin);
        make.right.mas_equalTo(-LeftMargin);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-LeftMargin);
        make.top.mas_equalTo(self.endTimeLabel.mas_bottom).mas_offset(LeftMargin);
    }];
    [super updateConstraints];
}


- (void)setModel:(UnionActivityListModel *)model{
    self.nameLabel.text = model.activityName;
    self.timeLabel.text = model.duration;
    self.endTimeLabel.text = model.endTime;
    [self.stateButton setTitle:model.curstate forState:UIControlStateNormal];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.banner]];
}

@end
