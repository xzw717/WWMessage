//
//  MineLogoutCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MineLogoutCell.h"

#define LeftSpace 17.f

@interface MineLogoutCell ()
@property (nonatomic, strong) UILabel *logoutLabel;
//@property (nonatomic, strong) UIButton *logoutButton;

@end
@implementation MineLogoutCell

#pragma lazy-load
- (UILabel *)logoutLabel{
    if (_logoutLabel == nil) {
        _logoutLabel = [[UILabel alloc]init];
        _logoutLabel.font = [UIFont systemFontOfSize:16.f];
        _logoutLabel.textAlignment = NSTextAlignmentCenter;
        _logoutLabel.text = @"退出登录";
        [self addSubview:_logoutLabel];
    }
    return _logoutLabel;
}

//- (UIButton *)logoutButton{
//    if (!_logoutButton) {
//        _logoutButton = [UIButton buttonWithType:0];
//        _logoutButton.userInteractionEnabled = NO;
//        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
//        _logoutButton.backgroundColor = DefaultAPPColor;
//        _logoutButton.layer.masksToBounds = YES;
//        _logoutButton.layer.cornerRadius = S_XRatioH(145/6);
//        _logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
//        [self addSubview:_logoutButton];
//    }
//    return _logoutButton;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self layoutTheSubviews];
    }
    return self;
}
- (void)addSubview:(UIView *)view
{
    if (![view isKindOfClass:[NSClassFromString(@"_UITableViewCellSeparatorView") class]] && view)
        [super addSubview:view];
}

- (void)layoutTheSubviews{
    self.logoutLabel.sd_layout.centerXEqualToView(self).centerYEqualToView(self).heightIs(20.f).widthIs(200.f);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
