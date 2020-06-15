//
//  CircleView.m
//  IDLFaceSDKDemoOC
//
//  Created by Tong,Shasha on 2017/8/31.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "ZZImageContainer.h"

@interface ZZImageContainer ()
@property (nonatomic, strong) UIView *maskBgView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation ZZImageContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self maskViewAddSubviews];
        [self layoutTheSubViews];
        
    }
    return self;
}

- (void)maskViewAddSubviews {
    [self addSubview:self.maskBgView];
    [self addSubview:self.imageView];
    [self.maskBgView addSubview:self.confirmButton];
    [self.maskBgView addSubview:self.cancelButton];
}


- (void)layoutTheSubViews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WIDTH, WIDTH));
    }];
    [self.maskBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.maskBgView);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2, 50));
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.maskBgView);
        make.size.mas_equalTo(CGSizeMake(WIDTH/2, 50));
    }];
}
- (void)setDataImage:(UIImage *)dataImage{
    self.imageView.image = dataImage;
}

- (UIView *)maskBgView{
    if (!_maskBgView) {
        _maskBgView = [[UIView alloc]init];
    }
    return _maskBgView;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_confirmButton setTitle:@"确认上传" forState:UIControlStateNormal];
        _confirmButton.backgroundColor = DefaultAPPColor;
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !self.confirmBlock ? : self.confirmBlock();
        }];
    }
    return _confirmButton;
}
- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton setTitle:@"重新采集" forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !self.cancelBlock ? : self.cancelBlock();
        }];
    }
    return _cancelButton;
}
@end
