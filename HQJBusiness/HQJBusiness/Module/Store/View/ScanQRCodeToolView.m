//
//  ScanQRCodeToolView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/2.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ScanQRCodeToolView.h"

#define ButtonHeight (70.f)

@interface ScanQRCodeToolView ()
{
//    UIButton *f_btn;
}
@property (nonatomic, strong) UIButton *flashLightButton;
@property (nonatomic, strong) UIButton *manualVerificationButton;
@end
@implementation ScanQRCodeToolView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self scanQRCodeToolView_addSubView];
        [self scanQRCodeToolView_LayoutView];
    }
    return self;
}

- (void)fl_Btn:(UIButton *)btn {
    NSLog(@"%d",btn.selected);
    btn.selected = !btn.selected;
    [[NSNotificationCenter defaultCenter]postNotificationName:FlashLight object:nil userInfo:@{@"selected":btn.selected ? @"开":@"关"}];
    [btn setTitleColor:btn.selected ? DefaultAPPColor : [UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:btn.selected ? DefaultAPPColor : [UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:btn.selected ? [UIImage imageNamed:@"scan_icon_flashlight_on"]:[UIImage imageNamed:@"scan_icon_flashlight"] forState:UIControlStateNormal];


}
- (void)mv_Btn:(UIButton *)btn {
//    !self.mv_block ? :self.mv_block();
    [[NSNotificationCenter defaultCenter]postNotificationName:Validation object:nil];

}

- (void)scanQRCodeToolView_LayoutView {
    
    [self.flashLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0); // WIDTH / 2 - ButtonHeight)/2
        make.top.mas_equalTo(kEDGE);
        make.size.mas_equalTo(CGSizeMake(WIDTH / 2, ButtonHeight));
    }];
    [self.manualVerificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0); // -(WIDTH / 2 - ButtonHeight)/2
        make.top.mas_equalTo(kEDGE);
        make.size.mas_equalTo(CGSizeMake(WIDTH / 2, ButtonHeight));
    }];
    
}
- (void)scanQRCodeToolView_addSubView {
    [self addSubview:self.flashLightButton];
    [self addSubview:self.manualVerificationButton];
}
- (UIButton *)flashLightButton {
    if (!_flashLightButton) {
        _flashLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashLightButton setImage:[UIImage imageNamed:@"scan_icon_flashlight"] forState:UIControlStateNormal];
        [_flashLightButton setTitle:@"打开手电筒" forState:UIControlStateNormal];
        [_flashLightButton addTarget:self action:@selector(fl_Btn:) forControlEvents:UIControlEventTouchUpInside];
        _flashLightButton.imageEdgeInsets = UIEdgeInsetsMake(-30, 87, 0, 0);
        _flashLightButton.titleEdgeInsets = UIEdgeInsetsMake(40, 0, 0, 0);
//        f_btn = _flashLightButton;
    }
    return _flashLightButton;
}
- (UIButton *)manualVerificationButton {
    if (!_manualVerificationButton) {
        _manualVerificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_manualVerificationButton setImage:[UIImage imageNamed:@"scan_icon_manual"] forState:UIControlStateNormal];
        [_manualVerificationButton setTitle:@"手动核销" forState:UIControlStateNormal];
        [_manualVerificationButton addTarget:self action:@selector(mv_Btn:) forControlEvents:UIControlEventTouchUpInside];
        _manualVerificationButton.imageEdgeInsets = UIEdgeInsetsMake(-30, 87, 0, 0);
        _manualVerificationButton.titleEdgeInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    }
    return _manualVerificationButton;
}
@end
