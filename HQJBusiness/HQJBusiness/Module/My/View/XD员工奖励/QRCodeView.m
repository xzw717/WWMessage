//
//  QRCodeView.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/30.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "QRCodeView.h"
#import "SavePhotosTool.h"
#import "HQJShareView.h"

@interface QRCodeView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *qrcodeImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIView *linkView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) HQJShareView * share;
@property (nonatomic, assign) NSInteger animateTag;
@end
@implementation QRCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5.0;
        self.layer.cornerRadius = 9.0;
        self.clipsToBounds = NO;
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.f];
        [CustomWindow addSubview:self];
        [self addView];
        [self setLayout];
    }
    return self;
}
+ (instancetype)showQrCode {
    QRCodeView *view = [[self alloc]init];
    [view animateShow];
    return view;
}
- (void)animateShow {
    if (self.animateTag == 1)return;
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(HEIGHT - NavigationControllerHeight - NewProportion(710) - 44 +10 );
    }];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
        }];
        [self layoutIfNeeded];
        self.animateTag = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(10);
            }];
            [self layoutIfNeeded];
            self.animateTag = 0;
        }];
    }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint(self.bgView.frame, pt) && !CGRectContainsPoint(self.share.maskView.frame, pt)) {
        [self dismissQrCode];
    }
}
- (void)dismissQrCode {
    if (self.animateTag == 1)return;
    [UIView animateWithDuration:0.15 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(10);
        }];
        [self layoutIfNeeded];
        self.animateTag = 1;

    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(HEIGHT - NavigationControllerHeight - NewProportion(710) - 44 +10 );
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.animateTag = 0;

        }];
    }];
}
- (void)shareAction {
    NSArray *titleArr = @[@[@"微信",@"icon_share_wx"],@[@"QQ",@"icon_share_qq"]];
    self.share = [HQJShareView showShareViewWithArray:titleArr];
    self.share.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
    [CustomWindow addSubview:self.share];
    @weakify(self);
    [UIView animateWithDuration:0.15 animations:^{
        self.frame = CGRectMake(10, 0, WIDTH, HEIGHT);
        self.share.frame = CGRectMake(WIDTH + 10 , 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0.f;
            self.frame = CGRectMake(-WIDTH, 0, WIDTH, HEIGHT);
            self.share.frame = CGRectMake(0 , 0, WIDTH, HEIGHT);
        } completion:^(BOOL finished) {
        }];
    }];
    [self.share setCancel:^{
        @strongify(self);
        self.hidden = NO;
        [UIView animateWithDuration:0.15 animations:^{
            self.alpha = 1.f;
            self.frame = CGRectMake(-WIDTH, 0, WIDTH, HEIGHT);
            self.share.frame = CGRectMake(-10 , 0, WIDTH, HEIGHT);

        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                       self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
                      self.share.frame = CGRectMake(WIDTH , 0, WIDTH, HEIGHT);
            } completion:^(BOOL finished) {
                [self.share removeFromSuperview];
            }];
        }];
    }];
}
- (CompanyBlock)company {
    if (!_company) {
        __weak typeof(self) weakSelf = self;
       return  ^(NSString * str) {
           weakSelf.nameLabel.text = str;
           return weakSelf;
        };
    }
    return _company;
}

- (NameBlock)name {
    if (!_name) {
        __weak typeof(self) weakSelf = self;
       return  ^(NSString * str) {
           weakSelf.phoneLabel.text = str;
           return weakSelf;
        };
    }
    return _name;
}

- (PhoneBlock)phone {
    if (!_phone) {
        __weak typeof(self) weakSelf = self;
       return  ^(NSString * str) {
           weakSelf.phoneLabel.text = [NSString stringWithFormat:@"%@  %@",weakSelf.phoneLabel.text,str];
           return weakSelf;
        };
    }
    return _phone;
}
- (QrCodeImagelock)qrCode {
    if (!_qrCode) {
        __weak typeof(self) weakSelf = self;
       return  ^(UIImage * qrImage) {
           weakSelf.qrcodeImageView.image = qrImage;
           return weakSelf;
        };
    }
    return _qrCode;
}
- (void)saveAction {
       [SavePhotosTool judgePHAuthorizationStatus:self.qrcodeImageView.image];
}
- (void)addView {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.qrcodeImageView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.saveButton];
    [self.bgView addSubview:self.shareButton];
    [self.bgView addSubview:self.linkView];
    [self.bgView addSubview:self.cancelButton];

}

- (void)setLayout {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(10);
        make.height.mas_equalTo(HEIGHT - NavigationControllerHeight - NewProportion(710) - 44 + 10);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(15);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelButton.mas_bottom);
        make.centerX.mas_equalTo(self.bgView);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.bgView);
    }];
    [self.qrcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.bgView);
        make.width.height.mas_equalTo(self.bgView.mas_height).multipliedBy(0.5);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.bgView.mas_width).multipliedBy(0.5);
    }];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.mas_equalTo(self.saveButton);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.saveButton.mas_top).mas_offset(3);
        make.bottom.mas_equalTo(self.saveButton.mas_bottom).mas_offset(-3);
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.saveButton);
        make.width.mas_equalTo(1);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 10.f;
    }
    return _bgView;
}
- (UIImageView *)qrcodeImageView {
    if (!_qrcodeImageView) {
        _qrcodeImageView = [[UIImageView alloc]init];
        _qrcodeImageView.backgroundColor = [UIColor greenColor];
        _qrcodeImageView.layer.borderColor = [[UIColor blackColor]CGColor];
        _qrcodeImageView.layer.borderWidth = 1.f;
    }
    return _qrcodeImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"吕奉先事业部";
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:14.f];
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.text = @"吕奉先  199333666871";
    }
    return _phoneLabel;
}
- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存到相册" forState:UIControlStateNormal];
        [_saveButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}
- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}
- (UIView *)linkView {
    if (!_linkView) {
        _linkView = [UIButton buttonWithType:UIButtonTypeCustom];
        _linkView.backgroundColor = DefaultBackgroundColor;

    }
    return _linkView;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton  setImage:[UIImage imageNamed:@"icon_Close-1"] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(dismissQrCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
@end
