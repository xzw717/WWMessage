//
//  AddStaffTableViewCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddStaffTableViewCell.h"
#import "SelectMenuView.h"
#import "UITextField+IndexPath.h"
#import "RoleSelectView.h"

@interface AddStaffTableViewCell ()
@property (nonatomic, strong) UILabel *addStafftitleLabel;

@end
@implementation AddStaffTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.addStafftitleLabel];
        [self.contentView addSubview:self.contentTextField];
        [self.contentView addSubview:self.selectButton];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setCellIndexPath:(NSIndexPath *)cellIndexPath {
    _cellIndexPath = cellIndexPath;
    self.contentTextField.indexPath = cellIndexPath;
}
- (void)updateConstraints {
    [self.addStafftitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(NewProportion(50));
        }];
        [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.addStafftitleLabel.mas_right).mas_offset(NewProportion(50));
            make.centerY.height.mas_equalTo(self.addStafftitleLabel);
            make.width.mas_equalTo(WIDTH / 2);
            
        }];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.addStafftitleLabel.mas_right).mas_offset(NewProportion(50));
            make.centerY.height.mas_equalTo(self.addStafftitleLabel);
            make.width.mas_equalTo(NewProportion(250));
        }];
    [super updateConstraints];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.addStafftitleLabel.text = title;
      self.contentTextField.hidden = [title isEqualToString:@"员工角色"] ? YES : NO;
      self.selectButton.hidden = !self.contentTextField.hidden;
    if ([title containsString:@"时间"]) {
        self.contentTextField.enabled = NO;
        self.contentTextField.text = [ManagerEngine currentDateStr];
    } else {
        self.contentTextField.enabled = YES;
        self.contentTextField.placeholder = [NSString stringWithFormat:@"请输入%@",title];
    }
}

- (UILabel *)addStafftitleLabel {
    if (!_addStafftitleLabel) {
        _addStafftitleLabel = [[UILabel alloc]init];
        _addStafftitleLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        _addStafftitleLabel.textColor = [ManagerEngine getColor:@"555555"];
        _addStafftitleLabel.text = @"员工编号";

    }
    return _addStafftitleLabel;
}
- (UITextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [[UITextField alloc]init];
        _contentTextField.placeholder = @"测试";
    }
    return _contentTextField;
}
- (RoleSelectView *)selectButton {
    if (!_selectButton) {
        _selectButton = [[RoleSelectView alloc]init];
//        [_selectButton setTitle:@"请选择角色" forState:UIControlStateNormal];
//        [_selectButton setImage:[UIImage imageNamed:@"chevron-down"] forState:UIControlStateNormal];
//        _selectButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(30)];
//        [_selectButton setTitleColor:[ManagerEngine getColor:@"555555"] forState:UIControlStateNormal];
//        [_selectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -22, 0, 0)];
//        [_selectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 40, 0, -70)];
        _selectButton.layer.masksToBounds = YES;
        _selectButton.layer.cornerRadius = 2.f;
        _selectButton.layer.borderColor = [[ManagerEngine getColor:@"20a0ff"]CGColor];
        _selectButton.layer.borderWidth = 1.f;
    }
    return _selectButton;
}

@end
