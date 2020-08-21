//
//  RoleSelectVIew.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RoleSelectView.h"
#define Spacing (5.f)




@interface RoleSelectView ()


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
        
//        self.roleLabel.frame = CGRectMake(Spacing, (self.mj_h - self.roleLabel.font.pointSize) / 2, self.mj_h - [self imageSizeMAX].width - Spacing *3, self.roleLabel.font.pointSize);
//
//
//        self.arrowImage.frame = CGRectMake(self.roleLabel.mj_x + self.roleLabel.mj_w + Spacing, (self.mj_h - [self imageSizeMAX].height) / 2,  [self imageSizeMAX].width, [self imageSizeMAX].height);

        
        
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(13);
        }];
    }
    return self;
}
- (CGSize)imageSizeMAX {
    if (self.arrowImage.size.width > self.mj_w || self.arrowImage.size.height > self.mj_h) {
        return CGSizeMake(13, 13);
    } else {
        return self.arrowImage.size;

    }
    
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
