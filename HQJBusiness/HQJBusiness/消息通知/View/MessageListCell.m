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
@end
@implementation MessageListCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (MessageBubbleView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[MessageBubbleView alloc]init];
        _titleImageView.messageImage = [UIImage imageNamed:@"news-list-icon"];
    }
    return _titleImageView;
}

@end
