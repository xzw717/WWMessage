//
//  StaffRoleItem.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/31.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@interface UIButton (pointRect)

@end
@implementation UIButton (pointRect)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44.0 - bounds.size.width , 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
#import "StaffRoleItem.h"
@interface StaffRoleItem ()
@property (nonatomic, strong) UILabel *roleTitleLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@end
@implementation StaffRoleItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.roleTitleLabel];
        [self.contentView addSubview:self.deleteButton];

        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 22.f;
        [self.roleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NewProportion(50));
            make.right.mas_equalTo(-NewProportion(50));
            make.centerY.mas_equalTo(self.contentView);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-3.f);
            make.top.mas_equalTo(3.f);
            make.width.height.mas_equalTo(15);
        }];
    }
    return self;
}
- (void)deleteAction {
    !self.clickDelete ? :self.clickDelete(self.roleTitle);
}

- (void)setRoleTitle:(NSString *)roleTitle {
    _roleTitle = roleTitle;
    self.roleTitleLabel.text = roleTitle;
}
- (UILabel *)roleTitleLabel {
    if (!_roleTitleLabel) {
        _roleTitleLabel = [[UILabel alloc]init];
        _roleTitleLabel.textAlignment = NSTextAlignmentCenter;
        _roleTitleLabel.font = [UIFont systemFontOfSize:13.f];
        _roleTitleLabel.textColor = [UIColor blackColor];
    }
    return _roleTitleLabel;
    
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_minus-circle-2"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
