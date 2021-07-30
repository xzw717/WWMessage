//
//  MessageCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
@interface MessageCell ()
@property (nonatomic, strong) UIView *timeBgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *messageBgView;
@property (nonatomic, strong) UILabel*messageTitleLabel;
@property (nonatomic, strong) UILabel *messageContentLabel;
@end
@implementation MessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        [self messageAddViews];
        [self updateConstraintsIfNeeded];
        
    }
    return self;
}
- (void)setModel:(MessageModel *)model {
    _model = model;
    self.timeLabel.text = model.messageTime;
    self.messageTitleLabel.text = model.messageTitle;
    self.messageContentLabel.text = model.messageContent;
}
- (void)messageAddViews {
    [self.contentView addSubview:self.timeBgView];
    [self.timeBgView addSubview:self.timeLabel];
    [self.contentView addSubview:self.messageBgView];
    [self.messageBgView addSubview:self.messageTitleLabel];
    [self.messageBgView addSubview:self.messageContentLabel];

}
- (void)updateConstraints {
    [self.timeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NewProportion(40.f));
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(NewProportion(56.f));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeBgView);
        make.left.mas_equalTo(NewProportion(29.f));
        make.right.mas_equalTo(-NewProportion(29.f));
    }];
    [self.messageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(30.f));
        make.top.mas_equalTo(self.timeBgView.mas_bottom).mas_offset(NewProportion(40.f));
        make.right.mas_equalTo(-NewProportion(30.f));
        make.height.mas_equalTo(NewProportion(347.f));
    }];
    [self.messageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NewProportion(65.f));
        make.left.mas_equalTo(NewProportion(33.f));
    }];
    [self.messageContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.messageTitleLabel);
        make.top.mas_equalTo(self.messageTitleLabel.mas_bottom).mas_offset(NewProportion(58.f));
        make.right.mas_equalTo(-NewProportion(33.f));
    }];
    [super updateConstraints];
}

- (UIView *)timeBgView {
    if (!_timeBgView) {
        _timeBgView = [[UIView alloc]init];
        _timeBgView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        _timeBgView.layer.cornerRadius = NewProportion(28.f);
        _timeBgView.layer.masksToBounds = YES;
    }
    return _timeBgView;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"7d7d7d"];
        _timeLabel.font = [UIFont systemFontOfSize:NewProportion(36.f)];
    }
    return _timeLabel;
}
- (UIView *)messageBgView {
    if (!_messageBgView) {
        _messageBgView = [[UIView alloc]init];
        _messageBgView.backgroundColor = [UIColor whiteColor];
        _messageBgView.layer.cornerRadius = NewProportion(20.f);
        _messageBgView.layer.masksToBounds = YES;
    }
    return _messageBgView;
}
- (UILabel *)messageTitleLabel {
    if (!_messageTitleLabel) {
        _messageTitleLabel = [[UILabel alloc]init];
        _messageTitleLabel.font = [UIFont systemFontOfSize:NewProportion(48.f)];
        _messageTitleLabel.textColor = [UIColor colorWithHexString:@"1b1b1b"];
    }
    return _messageTitleLabel;
}
- (UILabel *)messageContentLabel {
    if (!_messageContentLabel) {
        _messageContentLabel = [[UILabel alloc]init];
        _messageContentLabel.font = [UIFont systemFontOfSize:NewProportion(40.f)];
        _messageContentLabel.textColor = [UIColor colorWithHexString:@"626262"];
        _messageContentLabel.numberOfLines = 2;
    }
    return _messageContentLabel;
}
@end
