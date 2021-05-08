//
//  RewardsRecordChildCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/3.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RewardsRecordChildCell.h"
#import "RewardsRecordModel.h"
@interface RewardsRecordChildCell ()
@property (nonatomic, strong) UILabel *recordTitleLabel;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *currencyLabel;

@end
@implementation RewardsRecordChildCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.recordTitleLabel];
        [self.contentView addSubview:self.timerLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.currencyLabel];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setModelWithModel:(RewardsRecordModel *)cellModel type:(NSString *)type {
    if ([type isEqualToString:@"奖励记录"] ) {
        self.recordTitleLabel.text = @"XD商企活动积分";
        self.numberLabel.text = [NSString stringWithFormat:@"+%.5f",cellModel.score];
                  self.timerLabel.text = [ManagerEngine zzReverseSwitchTimer:cellModel.createTime dateFormat:@"YYYY-MM-dd HH:mm:ss"];
    } else if ([type isEqualToString:@"赠送记录"]) {
        self.recordTitleLabel.text = cellModel.uname;
        self.timerLabel.text = cellModel.mobile;
        self.currencyLabel.text = [ManagerEngine zzReverseSwitchTimer:cellModel.createTime dateFormat:@"YYYY-MM-dd HH:mm:ss"];
        self.numberLabel.text = [NSString stringWithFormat:@"-%.5f",cellModel.score];

    } else {
        self.numberLabel.text = [NSString stringWithFormat:@"+%.5f",cellModel.score];
           self.timerLabel.text = [ManagerEngine zzReverseSwitchTimer:cellModel.createTime dateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
}
//- (void)setCellModel:(RewardsRecordModel *)cellModel {
//    _cellModel = cellModel;
//    self.numberLabel.text = [NSString stringWithFormat:@"+%.5f",cellModel.score];
//    self.timerLabel.text = [ManagerEngine zzReverseSwitchTimer:cellModel.createTime dateFormat:@"YYYY-MM-dd HH:mm:ss"];
//}
- (void)updateConstraints {
    [self.recordTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.recordTitleLabel);
                make.top.mas_equalTo(self.recordTitleLabel.mas_bottom).mas_offset(5);
      }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.recordTitleLabel);
      }];
    [self.currencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(self.numberLabel);
            
        make.centerY.mas_equalTo(self.timerLabel);
      }];
    [super updateConstraints];
}

- (UILabel *)recordTitleLabel {
    if (!_recordTitleLabel) {
        _recordTitleLabel = [[UILabel alloc]init];
        _recordTitleLabel.textColor = [UIColor blackColor];
        _recordTitleLabel.font = [UIFont systemFontOfSize:14.f];
        _recordTitleLabel.text = @"消费奖励";
    }
    return _recordTitleLabel;
}
- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.textColor = [UIColor blackColor];
        _timerLabel.font = [UIFont systemFontOfSize:13.f];
        _timerLabel.text = @"2020-02-03";
    }
    return _timerLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = DefaultAPPColor;
        _numberLabel.font = [UIFont systemFontOfSize:15.f];
        _numberLabel.text = @"+15";
    }
    return _numberLabel;
}
- (UILabel *)currencyLabel {
    if (!_currencyLabel) {
        _currencyLabel = [[UILabel alloc]init];
        _currencyLabel.textColor = [ManagerEngine getColor:@"cccccc"];
        _currencyLabel.font = [UIFont systemFontOfSize:13.f];
        _currencyLabel.text = @"积分";
    }
    return _currencyLabel;
}


@end
