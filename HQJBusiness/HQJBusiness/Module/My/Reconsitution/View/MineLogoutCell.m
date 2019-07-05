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
@property (nonatomic, strong) UIButton *logoutButton;

@end
@implementation MineLogoutCell

#pragma lazy-load
- (UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:0];
        _logoutButton.userInteractionEnabled = NO;
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        _logoutButton.backgroundColor = DefaultAPPColor;
        _logoutButton.layer.masksToBounds = YES;
        _logoutButton.layer.cornerRadius = S_XRatioH(145/6);
        _logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [self addSubview:_logoutButton];
    }
    return _logoutButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = DefaultBackgroundColor;
        
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
    self.logoutButton.sd_layout.leftSpaceToView(self, LeftSpace).centerXEqualToView(self).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-34);
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
