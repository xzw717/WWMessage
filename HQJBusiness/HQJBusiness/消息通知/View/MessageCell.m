//
//  MessageCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageCell.h"
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
    }
    return self;
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
@end
