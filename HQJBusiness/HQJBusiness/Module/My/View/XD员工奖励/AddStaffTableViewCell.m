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
#import "SelectTimeView.h"

@interface AddStaffTableViewCell ()
@property (nonatomic, strong) UILabel *addStafftitleLabel;
@property (nonatomic, strong) SelectTimeView *timerView;
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
    if (cellIndexPath.row == 4) {

    } else {

    }
}
- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    if (contentText) {
        if (self.cellIndexPath.row == 1 || self.cellIndexPath.row == 2 || self.cellIndexPath.row == 4) {
               self.contentTextField.enabled = NO;
            self.contentTextField.textColor = RedColor;
            self.contentTextField.text = contentText;
        } else {
            if (self.cellIndexPath.row == 3) {
                self.selectButton.roleTitleString = contentText;
            } else {
                self.contentTextField.enabled = YES;

            }
            

        }
    }
  
    
    self.contentTextField.text = contentText;
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
            make.width.mas_equalTo(WIDTH / 3);
        }];
    [super updateConstraints];
}
- (void)setIsClear:(BOOL)isClear {
    _isClear = isClear;
    if (isClear) {
        self.contentTextField.text = @"";
        self.selectButton.roleTitleString = @"请选择角色";
    }
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.addStafftitleLabel.text = title;
      self.contentTextField.hidden = [title isEqualToString:@"员工角色"] ? YES : NO;
      self.selectButton.hidden = !self.contentTextField.hidden;
    self.contentTextField.placeholder = [NSString stringWithFormat:@"请输入%@",title];

    if ([title containsString:@"时间"]) {
        self.contentTextField.text = [ManagerEngine currentDateStr];
        self.contentTextField.inputView = self.timerView;
        @weakify(self);
        [self.timerView setFinish:^(NSString * _Nonnull timer) {
            @strongify(self);
            self.contentTextField.text = timer;

        }];
    } else {
//        self.contentTextField.enabled = YES;
        self.contentTextField.inputView = nil;

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
//_contentTextField.inputView = self.timerView;

    }
    return _contentTextField;
}
- (RoleSelectView *)selectButton {
    if (!_selectButton) {
        _selectButton = [[RoleSelectView alloc]init];
        _selectButton.layer.masksToBounds = YES;
        _selectButton.layer.cornerRadius = 2.f;
        _selectButton.layer.borderColor = [[ManagerEngine getColor:@"20a0ff"]CGColor];
        _selectButton.layer.borderWidth = 1.f;
        _selectButton.roleLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
    }
    return _selectButton;
}
- (SelectTimeView *)timerView {
    if (!_timerView) {
        _timerView = [[SelectTimeView alloc]init];
    }
    return _timerView;
}
@end
