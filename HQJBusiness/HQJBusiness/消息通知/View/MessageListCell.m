//
//  MessageListCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageListCell.h"
#import "MessageBubbleView.h"

@interface MessageListCell ()


@property (nonatomic, strong) MessageBubbleView *titleImageView;
@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation MessageListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self messageListCell_addSubView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setMessageListCellModel:(MessageListModel *)messageListCellModel {
    _messageListCellModel = messageListCellModel;
    self.subTitleLabel.text = messageListCellModel.subTitle;
    self.mainTitleLabel.text= messageListCellModel.mainTitle;
    [self.titleImageView setMessageNumerString:messageListCellModel.messageCount];
}
- (void)messageListCell_addSubView {
    [self.contentView addSubview:self.titleImageView];
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.lineView];

}
- (void)updateConstraints {
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(30));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(NewProportion(144));
    }];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImageView.mas_top).mas_offset(3);
        make.left.mas_equalTo(self.titleImageView.mas_right).mas_offset(NewProportion(44));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.titleImageView.mas_bottom).mas_offset(-3);
        make.left.mas_equalTo(self.mainTitleLabel);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainTitleLabel);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(.5f);
    }];
    
    [super updateConstraints];
}
- (MessageBubbleView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[MessageBubbleView alloc]init];
        _titleImageView.messageImage = [UIImage imageNamed:@"news-list-icon"];
    }
    return _titleImageView;
}
- (UILabel *)mainTitleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc]init];
        _mainTitleLabel.textColor = [UIColor colorWithHexString:@"464648"];
        _mainTitleLabel.font = [UIFont systemFontOfSize:NewProportion(48) weight:UIFontWeightBold];
    }
    return _mainTitleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.textColor = [UIColor colorWithHexString:@"909399"];
        _subTitleLabel.font = [UIFont systemFontOfSize:NewProportion(38)];
    }
    return _subTitleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"d2d1d1"];
    }
    return _lineView;
}


@end
