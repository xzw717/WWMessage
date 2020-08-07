//
//  RewardSetCell.m
//  HQJBusiness
//
//  Created by mymac on 2020/8/3.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RewardSetCell.h"
#import "UITextField+IndexPath.h"
#import "ZGRelayoutButton.h"
#import "RewardSetModel.h"
@interface RewardSetCell ()
@property (nonatomic, strong) UIView    *bgView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *minusButton;

@end
@implementation RewardSetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.roleButton];
        [self.bgView addSubview:self.numberTextField];
        [self addSubview:self.addButton];
        [self addSubview:self.minusButton];
        [self updateConstraintsIfNeeded];
        [self setIsEnabled:NO];
    }
    return self;
}

- (void)selectRole:(ZGRelayoutButton *)btn {
    !self.selectRoleAction?:self.selectRoleAction(btn);
  
    
}
- (void)setCellModel:(RewardSetModel *)cellModel {
    _cellModel = cellModel;
    [self.roleButton setTitle:cellModel.roleTitle forState:UIControlStateNormal];
    self.numberTextField.text = cellModel.number;
}
- (void)setIsEnabled:(BOOL)isEnabled {
    _isEnabled = isEnabled;
    self.roleButton.userInteractionEnabled = isEnabled;
    self.numberTextField.userInteractionEnabled = isEnabled;
    self.addButton.hidden = !isEnabled;
    self.minusButton.hidden = YES;

}
- (void)setCellIndexPath:(NSIndexPath *)cellIndexPath {
    _cellIndexPath = cellIndexPath;
    self.numberTextField.indexPath = cellIndexPath;
    if (self.isEnabled ) {
        if (cellIndexPath.row == 0) {
            self.roleButton.enabled = NO;
            [self.numberTextField becomeFirstResponder];
            self.addButton.hidden = NO;
            self.minusButton.hidden = YES;
        } else {
            self.roleButton.enabled = YES;
            [self.numberTextField becomeFirstResponder];
            self.addButton.hidden = YES;
            self.minusButton.hidden = NO;
        }
        
    } else {
         self.roleButton.enabled = YES;
        [self.numberTextField resignFirstResponder];
        self.addButton.hidden = YES;
        self.minusButton.hidden = YES;

    }
    
}

- (void)addRoleLink {
    !self.addAction? :self.addAction();
}
- (void)removeRoleLink {
    !self.removeAction?:self.removeAction();
}



- (void)updateConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(self.addButton.mas_left).mas_offset(-15);
    }];
    [self.roleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.bgView);
        make.width.mas_equalTo(80);
    }];
    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.roleButton.mas_right);
        make.right.bottom.top.mas_equalTo(self.bgView);
       }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(self.bgView);
        make.width.mas_equalTo(20);
       }];
    [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(self.bgView);
        make.width.mas_equalTo(20);
       }];
    [super updateConstraints];
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds =  YES;
        _bgView.layer.cornerRadius = 2.f;
        _bgView.layer.borderColor = [[ManagerEngine getColor:@"cccccc"]CGColor];
        _bgView.layer.borderWidth = 1.f;
    }
    return _bgView;
}
- (ZGRelayoutButton *)roleButton {
    if (!_roleButton) {
        _roleButton = [ZGRelayoutButton buttonWithType:UIButtonTypeCustom];
        _roleButton.type = ZGRelayoutButtonTypeLeft;
        [_roleButton setImage:[UIImage imageNamed:@"chevron-down"] forState:UIControlStateNormal];
        _roleButton.layer.masksToBounds =  YES;
         _roleButton.layer.cornerRadius = 2.f;
         _roleButton.layer.borderColor = [[ManagerEngine getColor:@"cccccc"]CGColor];
         _roleButton.layer.borderWidth = 1.f;
        [_roleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _roleButton.imageSize = CGSizeMake(17, 17);
        _roleButton.offset = 5.f;
        _roleButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(48)];
        [_roleButton addTarget:self action:@selector(selectRole:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _roleButton;
}
- (UITextField *)numberTextField {
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc]init];
        _numberTextField.font = [UIFont systemFontOfSize:13.f];
        _numberTextField.placeholder = @"设置奖励比例%";
        _numberTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _numberTextField;
}
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"icon_plus-circle+"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addRoleLink) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addButton;
}
- (UIButton *)minusButton {
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusButton setImage:[UIImage imageNamed:@"icon_minus-circle-"] forState:UIControlStateNormal];
        [_minusButton addTarget:self action:@selector(removeRoleLink) forControlEvents:UIControlEventTouchUpInside];

    }
    return _minusButton;
}
@end
