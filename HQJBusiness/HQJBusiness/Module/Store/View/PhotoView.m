//
//  PhotoView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/14.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PhotoView.h"
@interface PhotoView ()
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIView *maskView;
@end
@implementation PhotoView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}



- (void)addSubViews {
 
    [self addSubview: self.photoImageView];
    [self addSubview:self.photoDeleteButton];
//    [self addSubview:self.maskView];
}

- (void)updateConstraints {
    
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
    
    [self.photoDeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.photoImageView.mas_right);
        make.centerY.mas_equalTo(self.photoImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
  
    [super updateConstraints];
    
}

- (void)setTag:(NSInteger)tag {
    [super setTag:tag];
     [self.photoDeleteButton setTag:self.tag];
}


- (void)setUploadProgress:(CGFloat)uploadProgress {
    _uploadProgress = uploadProgress;
    CGFloat viewheight = 75 - 75 * uploadProgress;
    if (viewheight <= 0) {
         [self.maskView removeFromSuperview];
    } else {
        self.maskView.frame = CGRectMake(0,20, 75,viewheight);
    }
    
}

- (void)setPhotoImage:(UIImage *)photoImage {
     self.photoImageView.image = photoImage;
}

- (UIButton *)photoDeleteButton {
    if (!_photoDeleteButton) {
        _photoDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoDeleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
       

    }
    return _photoDeleteButton;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 75, 75)];
        _maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    }
    return _maskView;
}

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc]init];
        
    }
    return _photoImageView;
}

@end
