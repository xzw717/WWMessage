//
//  CALScanQRCodeCameraView.m
//  WuWuMap
//
//  Created by mymac on 16/6/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CALScanQRCodeCameraView.h"

#define CALScreenWidth          (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define CALScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define CALStatusBarHeight      ([ManagerEngine isIPhoneXSeries] ?  44.f : 20.f)
#define CALNavigationBarHeight  (44.0f)
#define CALGetMethodReturnObjc(objc) if (objc) return objc

static const CGFloat KAlppha = 0.5;

@interface CALScanQRCodeCameraView()<CAAnimationDelegate>

@property (nonatomic, strong) UILabel          *tipsLabel;
@property (nonatomic, strong) UIImageView      *lineImageView;
@property (nonatomic, strong) UIImageView      *scanQRCodePickBackgroundImageView;
@property (nonatomic, strong) CABasicAnimation *lineImageViewAnimation;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *downView;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;
@end

@implementation CALScanQRCodeCameraView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, CALNavigationBarHeight + CALStatusBarHeight, CALScreenWidth, HEIGHT );
        [self addSubview:self.scanQRCodePickBackgroundImageView];
        [self setFillView];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.lineImageView];
        
        [self startAnimation];
    }
    
    return self;
}

-(UIView *)topView {
    if ( _topView == nil ) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:KAlppha];
        [self addSubview:_topView];
    }
    
    
    return _topView;
}
-(UIView *)downView {
    
    if ( _downView == nil ) {
        _downView = [[UIView alloc]init];
        _downView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:KAlppha];
        [self addSubview:_downView];

    }
    return _downView;
}
-(UIView *)leftView {
    if ( _leftView == nil ) {
        _leftView = [[UIView alloc]init];
        _leftView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:KAlppha];
        [self addSubview:_leftView];

    }
    return _leftView;
    
}
-(UIView *)rightView {
    if ( _rightView == nil ) {
        _rightView =[[UIView alloc]init];
        _rightView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:KAlppha];
        [self addSubview:_rightView];
    }
    
    return _rightView;
}

-(void)setFillView {
    self.topView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).heightIs(self.center.y / 3.5).widthIs(CALScreenWidth);
    self.leftView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self.topView,0).heightIs(CALScreenWidth - 80).widthIs(80/2);
     self.rightView.sd_layout.leftSpaceToView(self.scanQRCodePickBackgroundImageView,0).topSpaceToView(self.topView,0).heightIs(CALScreenWidth - 80).widthIs(80/2);
    self.downView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self.scanQRCodePickBackgroundImageView,0).heightIs(CALScreenHeight - (self.center.y / 3.5 + CALScreenWidth - 80)).widthIs(CALScreenWidth);
//    HQJLog(@"%f---",CALScreenHeight - (self.center.y / 3.5 + CALScreenWidth - 80));
}


#pragma mark - Set ScanQRCode Pick Background Image View
- (UIImageView *)scanQRCodePickBackgroundImageView {
    
    CALGetMethodReturnObjc(_scanQRCodePickBackgroundImageView);
    
    _scanQRCodePickBackgroundImageView       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CALScanQRCode.bundle/scan_pick_bg"]];
    _scanQRCodePickBackgroundImageView.frame = CGRectMake(80 / 2, self.center.y / 3.5, CALScreenWidth - 80, CALScreenWidth - 80);
    
    return _scanQRCodePickBackgroundImageView;
}

#pragma mark - Set ScanQRCode Tips Label Text
- (UILabel *)tipsLabel {
    
    CALGetMethodReturnObjc(_tipsLabel);
    
    _tipsLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y / 3.5 + self.scanQRCodePickBackgroundImageView.frame.size.height + 30, CALScreenWidth, 30)];
//    _tipsLabel.text          = @"二维码、条形码";
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.textColor     = [UIColor whiteColor];
    _tipsLabel.font          = [UIFont systemFontOfSize:14];
    
    return _tipsLabel;
}

#pragma mark - Set ScanQRCode Line Image View
- (UIImageView *)lineImageView {
    
    CALGetMethodReturnObjc(_lineImageView);
    
    _lineImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.center.y / 3.5, CALScreenWidth - 100, 4)];
    _lineImageView.image = [UIImage imageNamed:@"CALScanQRCode.bundle/scan_line"];
    
    [self.scanQRCodePickBackgroundImageView addSubview:_lineImageView];
    
    return _lineImageView;
}

#pragma mark - Set Tips Label Text
- (void)setTipsLabelText:(NSString *)tipsLabelText {
    
    self.tipsLabel.text = tipsLabelText;
}

#pragma mark - Set ScanQRCode Line Image
- (void)setScanQRCodeLineImage:(UIImage *)scanQRCodeLineImage {
    
    self.lineImageView.image = scanQRCodeLineImage;
}

#pragma mark - Set ScanQRCode ScanQRCode Pick Background Image
- (void)setScanQRCodePickBackgroundImage:(UIImage *)scanQRCodePickBackgroundImage {
    
    self.scanQRCodePickBackgroundImageView.image = scanQRCodePickBackgroundImage;
}

#pragma mark - Set ScanQRCode Line Animation
- (void)startAnimation {
    
    CABasicAnimation *lineImageViewAnimation = [CABasicAnimation animation];
    
    lineImageViewAnimation.keyPath             = @"position";
    lineImageViewAnimation.duration            = 1.5;
    lineImageViewAnimation.fillMode            = kCAMediaTimingFunctionEaseInEaseOut;
    lineImageViewAnimation.removedOnCompletion = NO;
    lineImageViewAnimation.delegate            = self;
    lineImageViewAnimation.repeatCount         = MAXFLOAT;
    lineImageViewAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(_lineImageView.center.x,
                                                                                       _scanQRCodePickBackgroundImageView.frame.origin.y + _scanQRCodePickBackgroundImageView.frame.size.height - 2)];
    
    [self.lineImageView.layer addAnimation:lineImageViewAnimation forKey:@"LineImageViewAnimation"];
}

#pragma mark - Stop Line Animtaion
- (void)stopAnimation {
    
    [self.lineImageView.layer removeAnimationForKey:@"LineImageViewAnimation"];
    self.lineImageView.hidden = true;
}

@end
