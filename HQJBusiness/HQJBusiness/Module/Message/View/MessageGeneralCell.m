//
//  MessageGeneralCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/1.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageGeneralCell.h"
#import "NewMessageImageView.h"
@interface MessageGeneralCell ()
@property (nonatomic, strong) NewMessageImageView *messageDefultImage;
@property (nonatomic, strong) UILabel *messageTitle;
@property (nonatomic, strong) UILabel *messageContent;
@property (nonatomic, strong) UILabel *messageTime;
@property (nonatomic, strong) UIView *messageLineView;
@end
@implementation MessageGeneralCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = DefaultBackgroundColor;
        [self messageCell_addSubView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)unreadMessage {
    [self.messageDefultImage setNumbaer:0];
}
- (void)readMessage {
    [self.messageDefultImage hiddeRedView];
}
- (void)messageCell_addSubView {
    [self.contentView addSubview:self.messageDefultImage];
    [self.contentView addSubview:self.messageTitle];
    [self.contentView addSubview:self.messageContent];
    [self.contentView addSubview:self.messageTime];
    [self.contentView addSubview:self.messageLineView];
}

- (void)updateConstraints {
    [self.messageDefultImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30/3.f);
        make.top.mas_equalTo(42/3.f);
        make.width.height.mas_equalTo(144/3.f);
    }];
    [self.messageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(57/3.f);
        make.left.mas_equalTo(self.messageDefultImage.mas_right).mas_offset(37/3.f);
    }];
    [self.messageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.messageTitle.mas_bottom).mas_offset(26/3.f);
        make.left.mas_equalTo(self.messageTitle);
        make.right.mas_equalTo(-30/3.f);
    }];
    [self.messageTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.messageTitle);
        make.right.mas_equalTo(-30/3.f);
    }];
    [self.messageLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(30/3.f);
        make.right.mas_equalTo(-30/3.f);
        make.height.mas_equalTo(.5f);
    }];
    [super updateConstraints];
}

- (NewMessageImageView *)messageDefultImage {
    if (!_messageDefultImage) {
        _messageDefultImage = [[NewMessageImageView alloc]initWithHintStyle:redViewStyleDefault];
        _messageDefultImage.image = [UIImage imageNamed:@"news-list-icon"];
    }
    return _messageDefultImage;
}

- (UILabel *)messageTitle {
    if (!_messageTitle) {
        _messageTitle = [[UILabel alloc]init];
        _messageTitle.textColor = [ManagerEngine getColor:@"464648"];
        _messageTitle.font = [UIFont systemFontOfSize:54 / 3.f];
        _messageTitle.text = @"新订单";
    }
    return _messageTitle;
}
- (UILabel *)messageContent {
    if (!_messageContent) {
        _messageContent = [[UILabel alloc]init];
        _messageContent.textColor = [ManagerEngine getColor:@"909399"];
        _messageContent.font = [UIFont systemFontOfSize:40 / 3.f];
        _messageContent.text = @"您有新的【物物地图订单】，请及时处理";

    }
    return _messageContent;
}
- (UILabel *)messageTime {
    if (!_messageTime) {
        _messageTime = [[UILabel alloc]init];
        _messageTime.textColor = [ManagerEngine getColor:@"909399"];
        _messageTime.font = [UIFont systemFontOfSize:36 / 3.f];
        _messageTime.text = @"10:49";

    }
    return _messageTime;
}
- (UIView *)messageLineView {
    if (!_messageLineView) {
        _messageLineView = [[UIView alloc]init];
        _messageLineView.backgroundColor = [ManagerEngine getColor:@"d2d1d1"];
    }
    return _messageLineView;
}
@end
