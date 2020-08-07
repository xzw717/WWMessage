//
//  RewardSetFootView.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/4.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RewardSetFootView.h"
@interface RewardSetFootView ()
@property (nonatomic, strong) UIView *linkView;
@property (nonatomic, strong) UILabel *remindLabel;
@end
@implementation RewardSetFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.linkView];
        [self addSubview:self.remindLabel];
        [self.linkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.linkView.mas_bottom).mas_offset(NewProportion(50));
            make.left.mas_equalTo(NewProportion(50));
            make.right.mas_equalTo(-NewProportion(50));
        }];
    }
    return self;
}
- (UIView *)linkView {
    if (!_linkView) {
        _linkView = [[UIView alloc]init];
        _linkView.backgroundColor = [ManagerEngine getColor:@"d5d5d5"];
    }
    return _linkView;
}

- (UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc]init];
        _remindLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
        _remindLabel.textColor = [ManagerEngine getColor:@"666666"];
        _remindLabel.numberOfLines = 0;
        _remindLabel.textAlignment = NSTextAlignmentLeft;
        _remindLabel.text = @"注意：\n1.员工奖励来源与平台奖励；\n2.员工奖励最大设置100%，不足100%的，剩余部分归商家所有；\n3.当员工注册的会员消费时才可获取奖励；\n4。奖励金额与会员消费商家直接相关，不同商家消费奖励不同";
    }
    return _remindLabel;
}
@end
