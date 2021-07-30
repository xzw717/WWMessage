//
//  MessageNotDataView.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageNotDataView.h"
#define  Message_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define  Message_HEIGHT  [[UIScreen mainScreen] bounds].size.height
@interface MessageNotDataView ()

@property (nonatomic, strong) UIImageView *notDataImageView;
@property (nonatomic, strong) UILabel *notDataLabel;

@end
@implementation MessageNotDataView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        [self addSubview:self.notDataImageView];
        [self addSubview:self.notDataLabel];
        [self updateConstraintsIfNeeded];
        
    }
    return self;
}
- (void)updateConstraints {
    [self.notDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Message_HEIGHT / 6.36f);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(Message_WIDTH / 2.13f);
        make.height.mas_equalTo(Message_WIDTH / 2.89f);
    }];
    [self.notDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.notDataImageView.mas_bottom).mas_offset(NewProportion(142));
        make.centerX.mas_equalTo(self);
    }];
    [super updateConstraints];
}
- (UIImageView *)notDataImageView {
    if (!_notDataImageView) {
        _notDataImageView = [[UIImageView alloc]init];
        _notDataImageView.image = [UIImage imageNamed:@"news-nullstate"];
        
    }
    return _notDataImageView;
}
- (UILabel *)notDataLabel {
    if (!_notDataLabel) {
        _notDataLabel = [[UILabel alloc]init];
        _notDataLabel.text = @"亲，暂时没有数据呦";
        _notDataLabel.font = [UIFont systemFontOfSize:NewProportion(48.f)];
        _notDataLabel.textColor = [UIColor colorWithHexString:@"939191"];
    }
    return _notDataLabel;
}
@end
