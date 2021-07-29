//
//  MessageBubbleView.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/29.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@interface MessageLabel : UILabel

@end

@implementation MessageLabel

- (void)setText:(NSString *)text {
    [super setText:text];
    if ([text integerValue] <= 0) {
        self.hidden = YES;
    } else {
       self.hidden = NO;
    }
}

@end
#import "MessageBubbleView.h"
@interface MessageBubbleView ()
@property (nonatomic, strong) MessageLabel *messageLabel;
@property (nonatomic, strong) UIImageView *messageImageView;

@end
@implementation MessageBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.messageImageView];
        [self addSubview:self.messageLabel];
        [self bringSubviewToFront:self.messageLabel];
        self.userInteractionEnabled = YES;
        [self updateConstraintsIfNeeded];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)updateConstraints {
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];

    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.messageImageView.mas_right);
        make.top.mas_equalTo(self.messageImageView.mas_top).mas_offset(-5);
        make.height.mas_equalTo(NewProportion(50));
    }];
    [super updateConstraints];
}

- (void)setMessageImage:(UIImage *)messageImage {
    _messageImage = messageImage;
    self.messageImageView.image = messageImage;
}

- (void)setMessageNumerString:(NSString *)messageNumerString {
    _messageNumerString = messageNumerString;
    self.messageLabel.hidden =  [messageNumerString integerValue] > 0 ? NO : YES;
    if ([messageNumerString integerValue] > 99) {
        messageNumerString = @"99+";
//        self.messageLabel.font = [UIFont systemFontOfSize:7.0f];

    }
//    if ([messageNumerString integerValue] >= 10) {
//        self.messageLabel.font = [UIFont systemFontOfSize:8.0f];
//
//    } else {
//        self.messageLabel.font = [UIFont systemFontOfSize:9.0f];
//
//    }
    CGSize frame = [messageNumerString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NewProportion(36)]}];
    CGFloat width  = frame.width;
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width + 11);
    }];
    self.messageLabel.text = [NSString stringWithFormat:@"%@",messageNumerString];
}



- (MessageLabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[MessageLabel alloc]init];
        _messageLabel.hidden = YES;
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.backgroundColor = [UIColor colorWithHexString:@"ff4949"];
        _messageLabel.layer.masksToBounds = YES;
        _messageLabel.font = [UIFont systemFontOfSize:NewProportion(36)];
        _messageLabel.layer.borderWidth = NewProportion(4); // 给图层添加背景色
        _messageLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _messageLabel.layer.cornerRadius = NewProportion(25); // 将图层的边框设置为圆脚
        _messageLabel.layer.masksToBounds = YES; // 隐藏边界
    }
    return _messageLabel;
}


- (UIImageView *)messageImageView {
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc]init];
    }
    return _messageImageView;
}



@end
