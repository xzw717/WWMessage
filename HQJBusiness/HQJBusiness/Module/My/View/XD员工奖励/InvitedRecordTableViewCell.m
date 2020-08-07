//
//  InvitedRecordTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InvitedRecordTableViewCell.h"
#import "InvitedRecordModel.h"
@interface InvitedRecordTableViewCell ()
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UILabel *timerlabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@end
@implementation InvitedRecordTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.namelabel];
        [self.contentView addSubview:self.timerlabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(50));
            make.top.mas_equalTo(NewProportion(50));
        }];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.namelabel);
            make.top.mas_equalTo(self.namelabel.mas_bottom).mas_offset(NewProportion(30));
        }];
        [self.timerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(50));
            make.top.mas_equalTo(self.namelabel);
        }];
    }
    return self;
}
- (void)setModel:(InvitedRecordModel *)model {
    _model = model;
    self.namelabel.text = model.nickname;
    self.timerlabel.text = [ManagerEngine zzReverseSwitchTimer:model.registerTime dateFormat:@"YYYY-MM-DD"];
    self.phoneLabel.text = model.mobile;
}
- (UILabel *)namelabel {
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _namelabel.textColor = [ManagerEngine getColor:@"000000"];
        _namelabel.text = @"赵子龙";
    }
    return _namelabel;
}
- (UILabel *)timerlabel {
    if (!_timerlabel) {
        _timerlabel = [[UILabel alloc]init];
        _timerlabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _timerlabel.textColor = [ManagerEngine getColor:@"000000"];
        _timerlabel.text = @"2020-13-32";
    }
    return _timerlabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _phoneLabel.textColor = [ManagerEngine getColor:@"000000"];
        _phoneLabel.text = @"18888866666";
    }
    return _phoneLabel;
}

@end
