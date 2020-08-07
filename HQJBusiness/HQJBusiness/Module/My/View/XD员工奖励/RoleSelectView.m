//
//  RoleSelectVIew.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RoleSelectView.h"
@interface RoleSelectView ()
@property (nonatomic, strong) UILabel *roleLabel;
@property (nonatomic, strong) UIImageView *arrowImage;

@end
@implementation RoleSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRole:)];
        [self addGestureRecognizer:tap];
        [self addSubview:self.roleLabel];
        [self addSubview:self.arrowImage];
        [self.roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.arrowImage.mas_left).mas_offset(-5);

        }];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(13);
        }];
    }
    return self;
}
- (void)clickRole:(UITapGestureRecognizer *)recong {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickRoleView:)]) {
        [self.delegate clickRoleView:self];
    }
}
- (void)setRoleTitleString:(NSString *)roleTitleString {
    _roleTitleString = roleTitleString;
    self.roleLabel.text = roleTitleString;
}
- (UILabel *)roleLabel {
    if (!_roleLabel) {
        _roleLabel = [[UILabel alloc]init];
        _roleLabel.font = [UIFont systemFontOfSize:NewProportion(30)];
        _roleLabel.textColor = [ManagerEngine getColor:@"555555"];
        _roleLabel.text = @"请选择角色";
    }
    return _roleLabel;
}
- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc]init];
        _arrowImage.image = [UIImage imageNamed:@"chevron-down"];
    }
    return _arrowImage;
}

@end
