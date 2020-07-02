//
//  UpgradeManagementTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/6/16.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UpgradeManagementTableViewCell.h"
@interface UpgradeManagementTableViewCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation UpgradeManagementTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(70/3);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setCellType:(UpgradeManagementCellType)type contentText:(NSString *)content {
    switch (type) {
        case nameTitleCellType:{
            self.contentLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
            self.contentLabel.font = [UIFont systemFontOfSize:50/3.f];
           self.contentLabel.text = content;
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(70/3);
                make.centerX.mas_equalTo(self.contentView);
                make.bottom.mas_equalTo(0);
            }];
        }
            break;
        case roleTitleCellType:{
            self.contentLabel.textColor = [ManagerEngine getColor:@"ff494b"];
            self.contentLabel.font = [UIFont systemFontOfSize:50/3.f];
            self.contentLabel.text = [NSString stringWithFormat:@"当前角色：%@",content];
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(40/3);
                        make.centerX.mas_equalTo(self.contentView);
                        make.bottom.mas_equalTo(0);
                    
            }];
        }
            break;
        case upgradeTitleCellType: {
            self.contentLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
            self.contentLabel.font = [UIFont systemFontOfSize:60/3.f];
            self.contentLabel.text = [NSString stringWithFormat:@"您可升级为%@",content];
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(40/3);
                make.centerX.mas_equalTo(self.contentView);
                make.bottom.mas_equalTo(0);
            }];
        }
            break;
        case rulesCellType: {
            self.contentLabel.textColor = [ManagerEngine getColor:@"000000"];
            self.contentLabel.font = [UIFont systemFontOfSize:36/3.f];
            self.contentLabel.text = [NSString stringWithFormat:@"%@",content];
            self.contentLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(70/3);
                make.left.mas_equalTo(100/3);
                make.right.mas_equalTo(-100/3);
                make.bottom.mas_equalTo(0);
                    
            }];
        }
            break;
        default:
            break;
    }
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor blueColor];
        _contentLabel.font = [UIFont systemFontOfSize:50/3.f];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
