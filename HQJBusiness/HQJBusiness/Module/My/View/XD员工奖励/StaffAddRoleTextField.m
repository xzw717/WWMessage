//
//  StaffAddRoleTextField.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/31.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StaffAddRoleTextField.h"
@interface StaffAddRoleTextField()
@property (nonatomic, strong) UITextField *roleTextField;
@property (nonatomic, strong) UIButton *saveButton;
@end
@implementation StaffAddRoleTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.roleTextField];
        [self addSubview:self.saveButton];
        [self.roleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(50));
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(self.saveButton.mas_left).mas_offset(-NewProportion(50));
        }];
        [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-NewProportion(50));
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
    }
    return self;
}
- (void)addRole {
    if (self.roleTextField.text.length > 15) {
        [SVProgressHUD showErrorWithStatus:@"不能超过15个字符"];
    } else {
        if (self.roleTextField.text.length > 0) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(addRoleWithTile:)]){
                [self.delegate addRoleWithTile:self.roleTextField.text];
                self.roleTextField.text = @"";

            }
        }
    }
}
- (UITextField *)roleTextField {
    if (!_roleTextField) {
        _roleTextField = [[UITextField alloc]init];
        _roleTextField.placeholder = @"请输入员工角色";
        _roleTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _roleTextField;
}
- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"添加" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setBackgroundColor:DefaultAPPColor];
        _saveButton.layer.masksToBounds = YES;
        _saveButton.layer.cornerRadius = 15.f;
        [_saveButton addTarget:self action:@selector(addRole) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}
@end
